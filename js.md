* a标签提交form表单
```html
<a href="javascript:document:formName.submit();">确定</a>
```
* 按钮调用JS
```html
<input type="button" value="button onClick="javascript:window.location.href='' " >
```
* jquery获取下拉框选中
```javascript
$("#select  option:selected").text();   //选中的文本
$("#select").val();    //选中值
```

* 父窗口刷新子窗口内容

`document.getElementById("ff").contentWindow.location.href = "index.html"`
或
`document.getElementById("ff").src="index.html"`