<%@ page language="java" contentType="text/html; charset=EUC-KR" %>
<%@ page pageEncoding="EUC-KR"%>

<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>

<html>
<head>
<title>상품구매</title>

<link rel="stylesheet" href="/css/admin.css" type="text/css">

<script type="text/javascript">

function fncAddPurchase() {
	document.addPurchase.submit();
}
</script>

<script type="text/javascript" src="../javascript/calendar.js">
</script>

</head>

<body bgcolor="#ffffff" text="#000000">

<form name="addPurchase"  method="post" action="/addPurchase.do">

<input type = "hidden" name = "prodNo" value = "${param.prodNo}"/>

<table width="100%" height="37" border="0" cellpadding="0"	cellspacing="0">
	<tr>
		<td width="15" height="37">
			<img src="/images/ct_ttl_img01.gif" width="15" height="37"/>
		</td>
		<td background="/images/ct_ttl_img02.gif" width="100%" style="padding-left:10px;">
			<table width="100%" border="0" cellspacing="0" cellpadding="0">
				<tr>
					<td width="93%" class="ct_ttl01">상품구매</td>
					<td width="20%" align="right">&nbsp;</td>
				</tr>
			</table>
		</td>
		<td width="12" height="37">
			<img src="/images/ct_ttl_img03.gif" width="12" height="37"/>
		</td>
	</tr>
</table>

<table width="600" border="0" cellspacing="0" cellpadding="0" align="center" style="margin-top:13px;">
	<tr>
		<td height="1" colspan="3" bgcolor="D6D6D6"></td>
	</tr>
	
	<tr>
		<td width="300" class="ct_write">
			상품번호 <img src="/images/ct_icon_red.gif" width="3" height="3" align="absmiddle"/>
		</td>
		<td bgcolor="D6D6D6" width="1"></td>
		<td class="ct_write01">
			<table width="100%" border="0" cellspacing="0" cellpadding="0">
				<tr>
					<td width="105">${param.prodNo}</td>
				</tr>
			</table>
		</td>
	</tr>

	<tr>
		<td height="1" colspan="3" bgcolor="D6D6D6"></td>
	</tr>
	
	<tr>
		<td width="104" class="ct_write">
			상품명 <img src="/images/ct_icon_red.gif" width="3" height="3" align="absmiddle"/>
		</td>
		<td bgcolor="D6D6D6" width="1"></td>
		<td class="ct_write01"> ${product.prodName}
		</td>
	</tr>
	
	<tr>
		<td height="1" colspan="3" bgcolor="D6D6D6"></td>
	</tr>
	
		<tr>
		<td width="104" class="ct_write">
			상품상세정보 <img src="/images/ct_icon_red.gif" width="3" height="3" align="absmiddle"/>
		</td>
		<td bgcolor="D6D6D6" width="1"></td>
		<td class="ct_write01"> ${product.prodDetail}
		</td>
	</tr>
	
	<tr>
		<td height="1" colspan="3" bgcolor="D6D6D6"></td>
	</tr>

	<tr>
		<td width="104" class="ct_write">
			제조일자
		</td>
		<td bgcolor="D6D6D6" width="1"></td>
		<td class="ct_write01">${product.manuDate}
		</td>
	</tr>

	<tr>
		<td height="1" colspan="3" bgcolor="D6D6D6"></td>
	</tr>
		
	<tr>
		<td width="104" class="ct_write">
			가격
		</td>
		<td bgcolor="D6D6D6" width="1"></td>
		<td class="ct_write01">${product.price}원
		</td>
	</tr>

	<tr>
		<td height="1" colspan="3" bgcolor="D6D6D6"></td>
	</tr>
	
	<tr>
		<td width="104" class="ct_write">
			등록일자
		</td>
		<td bgcolor="D6D6D6" width="1"></td>
		<td class="ct_write01">${product.regDate}
		</td>
	</tr>

	<tr>
		<td height="1" colspan="3" bgcolor="D6D6D6"></td>
	</tr>

	<tr>
		<td width="104" class="ct_write">
			구매자 아이디 <img src="/images/ct_icon_red.gif" width="3" height="3" align="absmiddle"/>
		</td>
		<td bgcolor="D6D6D6" width="1"></td>
		<td class="ct_write01">${user.userId}
		</td>
	</tr>
	
	<tr>
		<td height="1" colspan="3" bgcolor="D6D6D6"></td>
	</tr>
	
	<tr>
		<td width="104" class="ct_write">
			구매방법
		</td>
		<td bgcolor="D6D6D6" width="1"></td>
		<td class="ct_write01">
      		<select name="paymentOption" class="ct_input_g" style="width: 100px; height: 19px" maxLength="20">
				<option value="1" ${purchase.paymentOption.trim eq '1'} ? "selected":""%>현금구매</option>
				<option value="2" ${purchase.paymentOption.trim eq '2'} ? "selected":""%>신용구매</option>
    		</select>
		</td>
	</tr>

	<tr>
		<td height="1" colspan="3" bgcolor="D6D6D6"></td>
	</tr>
	
	<tr>
		<td width="104" class="ct_write">
			구매자이름 
		</td>
		<td bgcolor="D6D6D6" width="1"></td>
		<td class="ct_write01">
		 <input type = "text" name = "receiverName" value = "${user.userName}"
		 	class = "ct_input_g" style = "width:100px; height:19px" maxLength="20"/>
		</td>
	</tr>
	
	<tr>
		<td height="1" colspan="3" bgcolor="D6D6D6"></td>
	</tr>
	
	<tr>
		<td width="104" class="ct_write">
			구매자연락처 
		</td>
		<td bgcolor="D6D6D6" width="1"></td>
		<td class="ct_write01">
		 <input type = "text" name = "receiverPhone" value = "${user.phone}"
		 	class = "ct_input_g" style = "width:100px; height:19px" maxLength="20"/>
		</td>
	</tr>
	
	<tr>
		<td height="1" colspan="3" bgcolor="D6D6D6"></td>
	</tr>	
	
	<tr>
		<td width="104" class="ct_write">
			구매자주소 
		</td>
		<td bgcolor="D6D6D6" width="1"></td>
		<td class="ct_write01">
		 <input type = "text" name = "dlvyAddr" value = "${user.addr}"
		 	class = "ct_input_g" style = "width:100px; height:19px" maxLength="20"/>
		</td>
	</tr>
	
	<tr>
		<td height="1" colspan="3" bgcolor="D6D6D6"></td>
	</tr>

	<tr>
		<td width="104" class="ct_write">
			구매자요청사항
		</td>
		<td bgcolor="D6D6D6" width="1"></td>
		<td class="ct_write01">
		 <input type = "text" name = "dlvyRequest" value = "${purchase.dlvyRequest}"
		 	class = "ct_input_g" style = "width:100px; height:19px" maxLength="20"/>
		</td>
	</tr>
	
	<tr>
		<td height="1" colspan="3" bgcolor="D6D6D6"></td>
	</tr>
		
	<tr>
		<td width="104" class="ct_write">
			배송희망일자 
		</td>
		<td bgcolor="D6D6D6" width="1"></td>
		<td class="ct_write01">
			<input type="text" name="dlvyDate" readonly="readonly" class="ct_input_g" 
							style="width:100px; height:19px"  maxLength="20" />
			&nbsp;<img src="../images/ct_icon_date.gif" width= "15" height= "15"
			onclick = "show_calendar('document.addPurchase.dlvyDate', document.addPurchase.dlvyDate.value)"/>				
		</td>
	</tr>
	
	<tr>
		<td height="1" colspan="3" bgcolor="D6D6D6"></td>
	</tr>
	
</table>	

<table width="100%" border="0" cellspacing="0" cellpadding="0" style="margin-top:10px;">
	<tr>
		<td width="53%"></td>
		<td align="center">
			<table border="0" cellspacing="0" cellpadding="0">
				<tr>
					<td width="17" height="23">
						<img src="/images/ct_btnbg01.gif" width="17" height="23"/>
					</td>
					<td background="/images/ct_btnbg02.gif" class="ct_btn01" style="padding-top:3px;">
						<a href="javascript:fncAddPurchase();">구매</a>
					</td>
					<td width="14" height="23">
						<img src="/images/ct_btnbg03.gif" width="14" height="23"/>
					</td>
					<td width="30"></td>					
					<td width="17" height="23">
						<img src="/images/ct_btnbg01.gif" width="17" height="23"/>
					</td>
					<td background="/images/ct_btnbg02.gif" class="ct_btn01" style="padding-top:3px;">
						<a href="javascript:history.go(-1);">취소</a>
					</td>
					<td width="14" height="23">
						<img src="/images/ct_btnbg03.gif" width="14" height="23">
					</td>
				</tr>
			</table>
		</td>
	</tr>
</table>

</form>
</body>
</html>