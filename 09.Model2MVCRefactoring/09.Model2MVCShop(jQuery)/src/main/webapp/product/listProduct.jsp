<%@ page language="java" contentType="text/html; charset=EUC-KR"%>
<%@ page pageEncoding="EUC-KR"%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<html>
<head>
<title>��ǰ�����ȸ</title>

<link rel="stylesheet" href="/css/admin.css" type="text/css">

	<script src="http://code.jquery.com/jquery-2.1.4.min.js"></script>
	<script type="text/javascript">

	function fncGetProductList(currentPage) {
		
	    var menu = "${param.menu}";
	    $("#currentPage").val(currentPage);
	    $("#menu").val(menu);
	    $("form").attr("method" , "POST").attr("action" , "/product/listProduct").submit();
	}
	
	$(function() {
		
		//��ǰ�� Click Event
		$(".ct_list_pop td:nth-child(3)").on("click", function() {
		
			var prodNo = $(this).data('prodno');
			var menu = "${menu}";
			
			alert("/product/getProduct?prodNo="+prodNo+"&menu="+menu);
			if(menu == 'search') {
				$("input[name='prodNo']").val(prodNo);
				$("form").attr("method", "POST").attr("action", "/product/getProduct?prodNo="+prodNo+"&menu=search").submit();
			} else if(menu == 'manage') {
				$("input[name='prodNo']").val(prodNo);
				$("form").attr("method", "Multipart").attr("action", "/product/getProduct").submit();
			}

		});
		
		$(".ct_list_pop td:nth-child(9):contains('���ſϷ� ����ϱ�')").on("click", function() {
			var prodNo = $(this).data('prodno');
			
			alert("/purchase/updateTranCodeByProd?prodNo="+prodNo+"&tranCode=2");
			$("form").attr("method", "POST").attr("action", "/purchase/updateTranCodeByProd?prodNo="+prodNo+
						"&tranCode=2&currentPage="+${resultPage.currentPage}).submit();
		});
		
		///purchase/updateTranCodeByProd?prodNo=${product.prodNo}&tranCode=${product.proTranCode}
		
		// ��ǰ�� ���� ����
		$(".ct_list_pop td:nth-child(3)").css("color" , "orange");

		// ������� ���� ����
		$(".ct_list_pop td:nth-child(9)").css("color" , "red");		
		
		//�˻� Event
		$("td.ct_btn01:contains('�˻�')" ).on("click" , function() {
			fncGetProductList(1);
		});
		
	 });		
	</script>
	
</head>

<body bgcolor="#ffffff" text="#000000">

<div style="width:98%; margin-left:10px;">

<form name="detailForm">

<input type = "hidden" id = "prodNo" name = "prodNo">
<input type = "hidden" id = "menu" name = "menu" value = "${param.menu}">

<table width="100%" height="37" border="0" cellpadding="0"	cellspacing="0">

	<tr>
		<td width="15" height="37">
			<img src="/images/ct_ttl_img01.gif" width="15" height="37">
		</td>
		<td background="/images/ct_ttl_img02.gif" width="100%" style="padding-left:10px;">
			<table width="100%" border="0" cellspacing="0" cellpadding="0">
			<tr>
			<!-- if������ menu search manage�� ������. -->
			
			<c:if test="${param.menu != null && param.menu eq 'manage'}">
				<td width="93%" class="ct_ttl01">��ǰ����</td>
			</c:if>	
			
			<c:if test="${param.menu != null && param.menu eq 'search'}">
				<td width="93%" class="ct_ttl01">��ǰ�����ȸ</td>
			</c:if>	
	
			</tr>

			</table>
		</td>
		<td width="12" height="37">
			<img src="/images/ct_ttl_img03.gif" width="12" height="37">
		</td>
	</tr>

</table>

<table width="100%" border="0" cellspacing="0" cellpadding="0" style="margin-top:10px;">
	<tr>
		<td align="right">
			<select name="searchCondition" class="ct_input_g" style="width:80px">
			<option value="0" ${! empty search.searchCondition && search.searchCondition==0 ? "selected" : ""}>��ǰ��ȣ</option>
			<option value="1" ${! empty search.searchCondition && search.searchCondition==1 ? "selected" : ""}>��ǰ��</option>
			<option value="2" ${! empty search.searchCondition && search.searchCondition==2 ? "selected" : ""}>����</option>						
			</select>
			<input type = "text" name = "searchKeyword" value = "${! empty search.searchKeyword ? search.searchKeyword : "" }"
				class="ct_input_g" style="width:200px; height:19px" >
		</td>

		<td align="right" width="70">
			<table border="0" cellspacing="0" cellpadding="0">
				<tr>
					<td width="17" height="23">
						<img src="/images/ct_btnbg01.gif" width="17" height="23">
					</td>
					<td background="/images/ct_btnbg02.gif" class="ct_btn01" style="padding-top:3px;">
						�˻�
					</td>
					<td width="14" height="23">
						<img src="/images/ct_btnbg03.gif" width="14" height="23">
					</td>
				</tr>
			</table>
		</td>
	</tr>
</table>

<table width="100%" border="0" cellspacing="0" cellpadding="0" style="margin-top:10px;">
	<tr>
		<td colspan = 11"> ��ü ${resultPage.totalCount} �Ǽ�, ���� ${resultPage.currentPage} ������ </td>

	</tr>
	<tr>
		<td class="ct_list_b" width="100">No</td>
		<td class="ct_line02"></td>
		<td class="ct_list_b" width="150">��ǰ��</td>
		<td class="ct_line02"></td>
		<td class="ct_list_b" width="150">����</td>
		<td class="ct_line02"></td>
		<td class="ct_list_b" >�����</td>
		<td class="ct_line02"></td>
		<td class="ct_list_b" >�������</td>		
	</tr>
	<tr>
		<td colspan="11" bgcolor="808285" height="1"></td>
	</tr>
	
	 <c:set var = "i" value = "0"/>
	 <c:forEach var = "product" items = "${list}">
	 	<c:set var = "i" value = "${i+1}"/>
	 	<tr class = "ct_list_pop">
	 		<td align="center">${ i }</td>
	 		<td></td>
	 		<c:if test = "${param.menu != null && param.menu eq 'manage'}">
	 			<td align = "left" data-prodNo = "${product.prodNo}">
	 				${product.prodName}
<%-- 	 				<a href = "/product/getProduct?prodNo=${product.prodNo}&menu=manage">${product.prodName}</a> --%>
	 			</td>
	 		</c:if>
	 		
	 		<c:if test = "${param.menu != null && param.menu eq 'search'}">
	 			<td align = "left" data-prodNo = "${product.prodNo}">
	 				${product.prodName}
<%-- 	 				<a href = "/product/getProduct?prodNo=${product.prodNo}&menu=search">${product.prodName}</a> --%>
	 			</td>
	 		</c:if>	
	 	<td></td>
	 	
	 	<td align = "left">${product.price} </td> 
		<td></td>
		<td align = "left">${product.regDate} </td>
		<td></td>
		<c:if test="${not empty param.menu}">
    		<c:choose>
        		<c:when test="${param.menu eq 'manage'}">
            		<c:choose>
                		<c:when test="${empty product.proTranCode}">
                    		<td align="left">�Ǹ���</td>
                		</c:when>
                		<c:when test="${product.proTranCode eq '2'}">
                    		<td align="left" data-prodNo = "${product.prodNo}">���ſϷ� ����ϱ�</td>
                    		
<%--                     		<a href="/purchase/updateTranCodeByProd?prodNo=${product.prodNo}&tranCode=${product.proTranCode}">����ϱ�</a></td> --%>
                		</c:when>
                		<c:when test="${product.proTranCode eq '3'}">
                  	  		<td align="left">�����</td>
                		</c:when>
                		<c:when test="${product.proTranCode eq '4'}">
                    		<td align="left">��ۿϷ�</td>
                		</c:when>
            		</c:choose>
        		</c:when>
        		<c:when test="${param.menu eq 'search'}">
            		<c:choose>
                		<c:when test="${empty product.proTranCode}">
                    		<td align="left">�Ǹ���</td>
                		</c:when>
                		<c:otherwise>
                    		<td align="left">������</td>
                		</c:otherwise>
            		</c:choose>
        		</c:when>
   			 </c:choose>
		</c:if>
		<td></td>
		</tr>
	<tr>
		<td colspan="11" bgcolor="D6D7D6" height="1"></td>
	</tr>	
	 </c:forEach>
</table>

<table width="100%" border="0" cellspacing="0" cellpadding="0" style="margin-top:10px;">
	<tr>
		<td align="center">
			<input type = "hidden" id = "currentPage" name = "currentPage" value=""/> 
			<jsp:include page="../common/pageNavigator.jsp">	
				<jsp:param name = "listType" value = "product"/>
			</jsp:include>
    	</td>
	</tr>
</table>
<!--  ������ Navigator �� -->
</form>
</div>

</body>
</html>