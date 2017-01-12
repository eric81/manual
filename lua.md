#### 字符串分割
```lua
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