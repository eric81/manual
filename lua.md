#### 字符串分割
```lua
-- string split, return table data
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
```

#### 获取客户端IP地址
```lua
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
```

### 时间处理
```lua
os.time()                                                     --当前时间(int)
os.date("%Y-%m-%d %H:%M:%S", os.time())                       --当前时间(String)
os.time{year=2017, month=02, day=16, hour=09, min=09, sec=33} --String型时间转化成int型时间
```

```lua
-- 获取第二天开始时间(0时0分0秒)
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
```

#### 返回jason数据
```lua
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
```