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
$("#select  option:selected").text();   //选中的文本
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
    $('input[name="' + optionName　+ '"]:checked').each(function() {
        selected.push($(this).val());
    });
    return selected;
}
```

#### 父窗口刷新子窗口内容
```javascript
document.getElementById("ff").contentWindow.location.href = "index.html"
```
或
```javascript
document.getElementById("ff").src="index.html"
```