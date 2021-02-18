<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<meta name="renderer" content="webkit" />
<meta http-equiv="X-UA-Compatible" content="IE=edge" />
<title><%=c_title%></title><%If Not inull(c_key) Then%>
<meta name="keywords" content="<%=c_key%>" /><%End If%><%If Not inull(c_des) Then%>
<meta name="description" content="<%=c_des%>" /><%End If%>
<!--#include file="inc_head.asp"-->
</head>
<body>
<!--#include file="inc_header.asp"-->
<%If Not inull(c_cover) Then%><div id="channel_cover"><img src="<%=c_cover%>" alt="<%=c_title%>" title="<%=c_title%>" /></div><%End If%>
<div class="container">
	<!--#include file="inc_channel.asp"-->
	<div id="channel_content"> <%=c_content%> </div>
	<div class="l40 picture_wlist">
		<%
		sql = "select id,i_enable,i_order,i_name,i_parent,i_ifrec,i_ifhot,i_iftop,i_ifcov,i_bold,i_italic,i_color,i_picture,i_target,i_scontent,i_hits,i_date from cms_info where i_enable = 1 and i_parent in ("&c_sub&") order by i_order desc , id desc"
		pager = pageturner_handle(sql, "id", c_page)
		Set rs = pager(0)
		Do While Not rs.EOF
		%>
		<div class="x3">
			<div class="wrap">
				<div class="picture"><div class="thumbnail"><a href="<%=i_url(rs("id"))%>" target="<%=rs("i_target")%>"><img src="<%=iif((inull(rs("i_picture"))),nopicture,rs("i_picture"))%>" alt="<%=rs("i_name")%>" title="<%=rs("i_name")%>"/></a></div></div>
				<div class="title cut"><a style="<%=rs("i_color")&rs("i_bold")&rs("i_italic")%>" href="<%=i_url(rs("id"))%>" target="<%=rs("i_target")%>" title="<%=rs("i_name")%>"><%=rs("i_name")%></a></div>
			</div>
		</div>
		<%
		rs.movenext
		Loop
		rs.Close
		Set rs = Nothing
		%>
	</div>
	<%=iif((site_mode = 1),pageturner_show(pager(1),pager(2),pager(3),c_page,5),pageturner_rshow(pager(1),pager(2),pager(3),c_page,5,c_fname))%>
</div>
<!--#include file="inc_rh_w.asp"-->
<!--#include file="inc_footer.asp"-->
<%If site_thumbnail = 1 Then%>
<script type="text/javascript">
$(function(){
	var thumbnail = $('.thumbnail');
	thumbnail.find('img').jqthumb({
		width: thumbnail.width(),
		height: thumbnail.width() / <%=site_twidth%> * <%=site_theight%>
	});
});
</script>
<%End If%>
</body>
</html>