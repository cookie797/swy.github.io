<%@LANGUAGE="VBSCRIPT" CODEPAGE="65001"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<!--#include file="inc_head.asp"-->
<%
current_nav = "cms_link"
Call check_admin_purview("cms_link")
If Not inull(rf("save")) Then
	Set rs = ado_mquery("select * from cms_link")
	rs.AddNew
	rs("l_enable") = rf("l_enable")
	rs("l_name") = rf("l_name")
	rs("l_url") = rf("l_url")
	rs("l_picture") = rf("l_picture")
	rs.Update
	rs("l_order") = rs("id")
	rs.Update
	rs.Close
	Set rs = Nothing
	Call alert_href("新链接添加成功！", "cms_link.asp")
End If
If Not inull(rf("execute")) Then
	Call null_back(rf("id"), "请至少选中一项！")
	If inull(rf("method")) Then
		Call alert_back("请选择要执行的操作！")
	Else
		conn.Execute("delete from cms_link where id in ("&rf("id")&")")
	End If
	Call alert_href ("执行成功！", "cms_link.asp")
End If

%>
<script type="text/javascript">
$(function(){
	KindEditor.ready(function(K) {
		var editor = K.editor();
		K('#picture').click(function() {
			editor.loadPlugin('image', function() {
				editor.plugin.imageDialog({
				imageUrl : K('#l_picture').val(),
				clickFn : function(url, title, width, height, border, align) {
					K('#l_picture').val(url);
					editor.hideDialog();
					}
				});
			});
		});
	});
});
</script>
</head>
<body>
<!--#include file="inc_top.asp"-->
<div id="content">
	<!--#include file="inc_left.asp"-->
	<div id="right">
		<div class="hd"> 添加链接 </div>
		<div class="bd">
			<form method="post">
				<div class="form-group">
					<div class="label"><label for="l_enable">状态</label></div>
					<div class="field">
						<label class="btn"><input id="l_enable" name="l_enable" type="radio" value="1" checked="checked"/>发布</label>
						<label class="btn"><input name="l_enable" type="radio" value="0" />暂存</label>
					</div>
				</div>
				<div class="form-group">
					<div class="label"><label for="l_name">链接名称</label></div>
					<div class="field">
						<input id="l_name" class="input" name="l_name" type="text" size="60" data-validate="required:必填" value="" />
					</div>
				</div>
				<div class="form-group">
					<div class="label"><label for="l_url">链接地址</label></div>
					<div class="field">
						<input id="l_url" class="input" name="l_url" type="text" size="60" data-validate="required:必填" value="" />
					</div>
				</div>
				<div class="form-group">
					<div class="label"><label for="l_picture">链接图片</label> <span class="badge bg-dot cp" id="picture">上传</span></div>
					<div class="field">
						<input id="l_picture" class="input" name="l_picture" type="text" size="60" value="" />
					</div>
				</div>
				<div class="form-group">
					<div class="label"><label></label></div>
					<div class="field">
						<input id="save" class="btn bg-dot" name="save" type="submit" value="添加新链接" />
					</div>
				</div>
			</form>
		</div>
		<div class="hd"> 管理链接 </div>
		<div class="bd">
			<form method="post" class="form-auto">
				<table class="table table-bordered">
					<tr>
						<th>选</th>
						<th>排序</th>
						<th>状态</th>
						<th>链接名称</th>
						<th>链接地址</th>
						<th>修改</th>
					</tr>
					<%
					sql = "select * from cms_link order by l_order asc , id asc"
					page_size = 20
					pager = pageturner_handle(sql, "id", page_size)
					Set rs = pager(0)
					Do While Not rs.EOF
					%>
					<tr class="ac">
						<td><input name="id" type="checkbox" id="id" value="<%=rs("id")%>" /></td>
						<td><%=rs("l_order")%></td>
						<td><%=iif(rs("l_enable") = 1,"<span class=""badge bg-green"">发布</span>","<span class=""badge bg-dot"">暂存</span>")%></td>
						<td><a href="<%=rs("l_url")%>" target="_blank"><%=rs("l_name")%></a></td>
						<td><%=rs("l_url")%></td>
						<td><a class="btn bg-main" href="cms_link_modify.asp?id=<%=rs("id")%>"><span class="icon-edit"> 修改</span></a></td>
					</tr>
					<%
					rs.movenext
					Loop
					rs.Close
					Set rs = Nothing
					%>
					<tr>
						<td class="ac"><input type="checkbox" onclick="check_all(this,'id')" /></td>
						<td colspan="5">
							<select class="input" name="method">
								<option value="">选择操作</option>
								<option value="del">删除链接</option>
							</select>
							<input class="btn bg-main" type="submit" name="execute" value="执行操作" />
						</td>
					</tr>
				</table>
			</form>
			<%=pageturner_show(pager(1),pager(2),pager(3),page_size,5)%>
		</div>
	</div>
</div>
<!--#include file="inc_bottom.asp"-->
</body>
</html>
