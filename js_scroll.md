#jquery方式

## js

```javascript
var Scroll = function(param){
	this.config = this.initConfig(param);
	this.son = this.config.son;
	this.pap = this.config.pap;
	this.speed = this.config.speed;
	this.scrollY = 0;
	this.hover = false;
};
Scroll.prototype = {
	initConfig:function(param){
		var opt = param || {};
		var defaultConfig = {
			pap : $('#parent'),
			son : $('#son'),
			speed : 0.5
		};

		return $.extend(defaultConfig, opt);
	},
	start:function(callback){
		console.log(this.config);
		this.scrollWindow();
		this.papHover(callback);
	},
	scrollWindow:function(){
		var self = this;
		if(self.hover) return;

		self.scrollY <= this.son.height() ? self.scrollY += self.speed : self.scrollY = 0;
		self.son.css('margin-top', -self.scrollY+'px');

		setTimeout(self.scrollWindow.bind(this), 1000/60);
	},
	papHover:function(){
		var self = this;
		this.pap.on('mouseenter', function(){
			self.hover = true;
		}).on('mouseleave', function(){
			self.hover = false;
			self.scrollWindow();
		});
	},
	getdata:function(callback, dataUrl){
		var sn = this.son;
		var parnt = this.pap;
		$.get(dataUrl, function(data){
			var html = callback(data);
			sn.empty().append(html);
			parnt.append(sn.clone());
		},'jsonp');
	}
};
```
## use in html

```html
<!DOCTYPE html>
<html>
<head lang="en">
    <meta charset="UTF-8">
    <title></title>
	<style>
	.pa {
		height: 220px;
		overflow: hidden;
	}
	</style>
</head>
<body>
	<div id="parentDiv" class="pa">
		<ul id="sonDiv"></ul>
	</div>
</body>
<script type="text/javascript" src="http://forum.home.news.cn/static/zonglitiwen/js/jquery.min.js"></script>
<script type="text/javascript" src="scroll.js"></script>
<script type="text/javascript">
$(function(){
	var scl = new Scroll({
		pap:$('#parentDiv'),
		son:$('#sonDiv'),
		speed:0.5
	});
	
	scl.getdata(handleData, "http://forum.home.news.cn/api/post/thread.do?tid=137095995&ps=5");
	scl.start();
});

function handleData(data){
	var replys = data.replys, html = '';
	for(var i = 0;i<replys.length;i++){
		html += '<li><img src="http://tpic.home.news.cn/userIcon/l/'
		+ replys[i].userName + '"/>@'
		+ replys[i].userName + '：'
		+ replys[i].content+'</li>';
	}
	return html;
}
</script>
</html>
```

# 纯javascript方式

## code

```html
<!DOCTYPE html>
<head>
<title>留言</title>
<base target="_blank" />
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<style>
#pa {overflow:hidden; height:320px; width:460px;}
#pa ul{margin:0; padding:0;}
#pa li {list-style-type:none; padding:5px 0px 10px 0px; color:#333; border-bottom:1px dashed #999; font:normal 14px/30px "微软雅黑";}
#pa img {float:left; width:36px; height:36px; border-radius:36px; padding:0px 5px 0px 0px;}
#pa li span {font-weight: bold; color:#d70016}
</style>

</head>
<body>
	<div id="pa">
		<ul id="son"></ul>
		<ul id="son2"></ul>
	</div>

<script type="text/javascript" src="http://forum.home.news.cn/static/js/jquery-1.10.2.js"></script>
<script type="text/javascript">
	$(function() {
		var url = "http://forum.home.news.cn/api/post/thread.do?tid=139333848&ps=10&isDesc=true";
		$.get(url, function(data){handleData(data)}, "jsonp");
	});

	function handleData(data) {
		var replys = data.replys;
		$("#son").html("");
		$.each(replys, function(index, reply) {
			var us = reply.userName;
			var content = reply.content;
			content = content.replace(/<\/?[^>]*>/g, '');
			$("#son").append(
					"<li><img src='http://tpic.home.news.cn/userIcon/l/" + us + "'><span class='us'>@" + us
							+ ": </span>" + content + "</li>");
		})

		if (replys.length > 5) {
			scroll(80);
		}
	}
	
	function scroll(speed) {
		var pa = document.getElementById("pa");
		var son2 = document.getElementById("son2");
		var son = document.getElementById("son");
		son2.innerHTML = son.innerHTML;
		function Marquee() {
			if (son2.offsetHeight - pa.scrollTop <= 0)
				pa.scrollTop = 0;
			else {
				pa.scrollTop++;
			}
		}
		var MyMar = setInterval(Marquee, speed);
		pa.onmouseover = function() {
			clearInterval(MyMar)
		};
		pa.onmouseout = function() {
			MyMar = setInterval(Marquee, speed)
		};
	}
</script>
</body>
</html>
```