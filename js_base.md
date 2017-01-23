#### a标签提交form表单
```html
<a href="javascript:document:formName.submit();">确定</a>
```

#### a标签调用JS
```html
<a href="javascript:void(0);" onClick="sendsvr();">
```

#### 按钮调用JS
```html
<input type="button" value="button" onClick="javascript:window.location.href='' " >
```

#### jquery获取下拉框选中
```javascript
$("#select option:selected").text();   //选中的文本
$("#select").val();    //选中值
```

#### 获取checkbox选中项
```javascript
//普通js方式
function getOptionArrays(optionName){
	var checkedOptions = [];
    var r = document.getElementsByName(optionName);  
    for(var i=0; i<r.length; i++){
    	if(r[i].checked){
    		checkedOptions.push(r[i]);
    	}
    }
    return checkedOptions;
}
```

```javascript
//jquery方式
function getOptionArrays(optionName){
    var selected= [];
    $('input[name="' + optionName + '"]:checked').each(function() {
        selected.push($(this).val());
    });
    return selected;
}
```

#### 时间格式化
```javascript
function formatTime(obj) {
    var myDate = new Date(obj);
    var year = myDate.getFullYear();
    var month = ("0" + (myDate.getMonth() + 1)).slice(-2);
    var day = ("0" + myDate.getDate()).slice(-2);
    var h = ("0" + myDate.getHours()).slice(-2);
    var m = ("0" + myDate.getMinutes()).slice(-2);
    var s = ("0" + myDate.getSeconds()).slice(-2);
    var mi = ("00" + myDate.getMilliseconds()).slice(-3);
    return year + "-" + month + "-" + day + " " + h + ":" + m;
}
```

#### 刷新当前页及跳转
```javascript
//刷新当前页
location.reload();
//页面跳转 当前页打开
location.href="http://www.news.cn/";
//页面跳转 新页面打开
window.open("http://www.news.cn");
```

#### 父窗口刷新子窗口内容
```javascript
document.getElementById("ff").contentWindow.location.href = "index.html"
```
或
```javascript
document.getElementById("ff").src="index.html"
```

#### jquery ajax
#####POST
```javascript
var urls = "http://localhost:9090/api/user/add";
var datas = {name:'vvv', roles:'中国'};
$.post(urls, datas, function(data){alert(JSON.stringify(data));}, "jsonp");
```
#####GET
```javascript
var url = "http://localhost:9090/api/user/list";
$.get(url, function(data){alert(JSON.stringify(data));}, "jsonp");
```

#### 电话号码校验
```javascript
	var tel = $("#tel").val();
	tel = $.trim(tel);
	if (tel == null || tel == '') {
		alert("请填写电话!");
		return;
	}
	if(!(/^1[3|4|5|7|8]\d{9}$/.test(tel))){
		alert("电话号码输入有误！");
		return;
	}
```

#### 随机数
```javascript
//抽奖
var arr =["一","二","三","四","五","六","七","八","九","十",]
console.log(arr[Math.floor(Math.random()*10)])
```