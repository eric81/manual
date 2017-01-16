local rediss = require "resty.redis"
local cjson = require "cjson"

--get params
local args
if "GET" == ngx.req.get_method() then
	args = ngx.req.get_uri_args()
elseif "POST" == ngx.req.get_method() then
	ngx.req.read_body()
	args = ngx.req.get_post_args()
else
	ngx.say("只支持GET和POST方式！")
	return
end
local callback = args["callback"]
local id = args["id"]
local options = args["ops"]

-- string split
function split(str, delimiter)
	if str==nil or str=='' or delimiter==nil then
		return nil
	end
	
    local result = {}
    for match in (str..delimiter):gmatch("(.-)"..delimiter) do
        table.insert(result, match)
    end
    return result
end
--split options
local options_tb = split(options, ",")

--get remote ip
local remoteIp;
local t_str = ngx.var.http_x_forwarded_for;
if t_str ~= ngx.null and  t_str ~= nil  then
	local pos = string.find(t_str,",");
	if not pos then
		remoteIp = t_str
	end
	remoteIp = string.sub(t_str,1,pos-1)
else
	remoteIp = ngx.var.remote_addr;
end
ngx.say("remoteIp="..remoteIp);

--convert data to result object
local function convert2Result(code, msg, data, callback)
	local result = {}
	result["code"] = code
	result["msg"] = msg
	result["content"] = data
	if callback ~= nil and callback ~= "" then
		return callback .. "(" .. cjson.encode(result) .. ")";
	else
		return cjson.encode(result)
	end
end

-- redis connect
local redis = rediss.new()
redis:set_timeout(6000) --6sec  
local resconnect, err = redis.connect(redis, '192.168.84.218', '6379')
if not resconnect then
	ngx.say("failed to connect redis : ", err)
	return
end
--redis auth
local resauth, err = redis:auth("redistest")
if not resauth then
	ngx.say("failed to authenticate redis : ", err)
    return
end
--redis db select
local resDbSelect, err = redis:select(3);
if not resDbSelect then
    ngx.say("redis db select failed, err : ", err)
end

-- get tommorow time
local function getTommorowStartTime()
	local tnow = os.date("%Y%m%d%H%M%S", os.time())
	
	local Y = string.sub(tnow,1,4)
    local M = string.sub(tnow,5,6)
    local D = string.sub(tnow,7,8)
    local HH = string.sub(tnow,9,10)
    local MM = string.sub(tnow,11,12)
    local SS = string.sub(tnow,13,14)

	D = D + tonumber(1)
	HH  = 0
	MM = 0
	SS = 0

	local tmt = os.time{year=Y, month=M, day=D, hour=HH, min=MM, sec=SS}
	return tmt
end

--ip check by redis 每个IP每天容许n次
local function ipcheck(ip, n)
	local key = "poll."..id..".ip.day";
	local vc, err = redis:hget(key, ip);
	if vc == ngx.null or tonumber(vc) < n then
		local ok, err = redis:hincrby(key, ip, 1);
		local ok1, err = redis:expireat(key, getTommorowStartTime());
		if ok and ok1 then
			return true;
		else
			return false;
		end
	else
		return false;
	end
end

--ip check by redis 每个IP一段时间内(n秒)容许n次
local function ipcheck_time(ip, t, n)
	local key = "poll."..id..".ip.time";
	local vc, err = redis:hget(key, ip);
	if vc == ngx.null or tonumber(vc) < n then
		local ok, err = redis:hincrby(key, ip, 1);
		local ok1, err = redis:expire(key, t);
		if ok and ok1 then
			return true;
		else
			return false;
		end
	else
		return false;
	end
end

--redis vote
local function vote()
	local rsipcheck = ipcheck_time(remoteIp, 60, 2);
	if not rsipcheck then
		ngx.say(convert2Result(500, "ip limit "..remoteIp, "", callback))
	else
		local rs = {}
		for index, option in pairs(options_tb) do
			local ok, err = redis:zincrby("poll."..id, 1, option)
			if not ok then
				ngx.say(convert2Result(500, "vote fail : "..err, "", callback))
			else
				table.insert(rs, ok)
			end
		end
		ngx.say(convert2Result(200, "success", rs, callback))
	end
end
vote()


local ok, err = redis:close()
if ok then
	ngx.say("redis closed")
else
	ngx.say("redis close fail : ", err)
end