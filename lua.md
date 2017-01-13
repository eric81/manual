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
os.time()                                  --当前时间(int)
os.date("%Y-%m-%d %H:%M:%S", os.time())    --当前时间(String)
```
```lua
local function getNewDate(srcDateTime,interval ,dateUnit)  
    --从日期字符串中截取出年月日时分秒  
    local Y = string.sub(srcDateTime,1,4)  
    local M = string.sub(srcDateTime,5,6)  
    local D = string.sub(srcDateTime,7,8)  
    local H = string.sub(srcDateTime,9,10)  
    local MM = string.sub(srcDateTime,11,12)  
    local SS = string.sub(srcDateTime,13,14)
    
    --把日期时间字符串转换成对应的日期时间  
    local dt1 = os.time{year=Y, month=M, day=D, hour=H,min=MM,sec=SS}  
  
    --根据时间单位和偏移量得到具体的偏移数据  
    local ofset=0  
  
    if dateUnit =='DAY' then  
        ofset = 60 *60 * 24 * interval  
  
    elseif dateUnit == 'HOUR' then  
        ofset = 60 *60 * interval  
          
 elseif dateUnit == 'MINUTE' then  
        ofset = 60 * interval  
  
    elseif dateUnit == 'SECOND' then  
        ofset = interval  
    end  
  
    --指定的时间+时间偏移量  
    local newTime = os.date("*t", dt1 + tonumber(ofset))  
    return newTime  
end

function test()  
    local oldTime="20130908232828"  
        --把指定的时间加3小时  
    local newTime=getNewDate(oldTime,3,'HOUR')  
    local t1 = string.format('%d-%02d-%02d %02d:%02d:%02d',newTime.year,newTime.month,newTime.day,newTime.hour,newTime.min,newTime.sec)  
    ngx.say('t1='..t1)  
  
        --把指定的时间加1天  
    local newTime=getNewDate(oldTime,1,'DAY')  
  
    local t2 = string.format('%d%02d%02d%02d%02d%02d',newTime.year,newTime.month,newTime.day,newTime.hour,newTime.min,newTime.sec)  
  
    ngx.say('t2='..t2)  
end
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