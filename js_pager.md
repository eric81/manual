## html

显示分页的div
```html
<div id="pager">
```

## js

```javascript
/* pagerID 为 显示分页的div的ID */
function showPager(pagerID, page, pageCount) {
	$("#" + pagerID).html("");
	$("#" + pagerID).append("<a id='pre' href='javascript:void(0)' target='_self' data-id='first'>首页</a> &nbsp;");
	$("#" + pagerID).append("<a id='pre' href='javascript:void(0)' target='_self' data-id='pre'>上一页</a> &nbsp;");
	showNumPager(pagerID, page, pageCount);
	$("#" + pagerID).append("<a id='next' href='javascript:void(0)' target='_self' data-id='next'>下一页</a> &nbsp;");
	$("#" + pagerID).append("<a id='pre' href='javascript:void(0)' target='_self' data-id='last'>尾页</a> &nbsp;");
	$("#" + pagerID + " a").on('click', function() {
		var pgnm = $(this).attr("data-id");
		switch (pgnm) {
		case 'first':
			page = 1;
			threadShow(page);
			break;
		case 'last':
			page = pageCount;
			threadShow(page);
			break;
		case 'pre':
			if (page > 1) {
				page--;
			}
			threadShow(page);
			break;
		case 'next':
			if (page < pageCount) {
				page++;
			}
			threadShow(page);
			break;
		default:
			threadShow(pgnm);
			break;
		}
	});
}

function showNumPager(pagerID, page, pageCount) {
	var start = page - 2;
	if(start < 1){
		start = 1;
	}
	var end = start + 5;
	if(end > pageCount){
		end = pageCount + 1;
		start = end - 5;
	}
	if(start < 1){
		start = 1;
	}
	var i = start;
	for(i = start; i < end; i++){
		if(i == page){
			$("#" + pagerID).append("<a class='currentPage' href='javascript:void(0)'
			 target='_self' data-id='" + i + "'>" + i + "</a> &nbsp;");
		}else{
			$("#" + pagerID).append("<a href='javascript:void(0)' target='_self' data-id='" + i + "'>" + i + "</a> &nbsp;");
		}
	}
}
```

## use in js
```javascript
function threadShow(page){
    thread(tid, page, 9, true, function(thread) {
        pageCount = thread.replyPageCount;
        var replys = thread.replys;
        $("#replys").html("");
        $.each(replys, function(index, reply) {
        	var contentHtml = "<li><div class='user-icon'><img src='http://tpic.home.news.cn/userIcon/l/"
				+ reply.userName + "'></div><h3>" + reply.userName
				+ "</h3><p>" + reply.content + "</p></li>";
            $("#replys").append(contentHtml);
        });
        showPager("pager", page, pageCount);
    });
}
```