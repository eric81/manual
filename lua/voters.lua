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
local option = args["op"]

--convert data to result object
local function conter2Result(code,data,callback)
	local result = {}
	result["code"] = code
	result["content"] = data
	if callback ~= nil and callback ~= "" then
		return callback .. "(" .. cjson.encode(result) .. ")";
	else
		return cjson.encode(result)
	end
end

local redis = rediss.new()
redis:set_timeout(6000) --6sec  
local resconnect, err = redis.connect(redis, '192.168.84.218', '6379')
if not resconnect then
	ngx.say("failed to connect redis : ", err)
	return
end

local resauth, err = redis:auth("redistest")
if not resauth then
	ngx.say("failed to authenticate redis : ", err)
    return
end

local resDbSelect, err = redis:select(3);
if not resDbSelect then
    ngx.say("redis db select failed, err : ", err)
end

-- get vote result by redis
local vote_result = {};
local ok, err = redis:zrevrange("poll."..id, 0, -1, "WITHSCORES");
if not ok then
    ngx.say("vote failed, err : ", err);
else
	
end
local count = 0;
for index, value in pairs(ok) do
	if index % 2 == 0 then
		count = count + value;
	end
end
vote_result["count"]=count;
vote_result["detail"]=ok;
ngx.say(conter2Result(200,vote_result,callback));

local ok, err = redis:close()
if not ok then
	ngx.say("</br></br> failed to close redis : ", err)
end