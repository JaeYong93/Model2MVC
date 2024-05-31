<%@ page language="java" contentType="text/html; charset=EUC-KR"%>
<%@ page pageEncoding="EUC-KR"%>

<%@ page import="com.model2.mvc.service.purchase.vo.*" %>

<%
	PurchaseVO purchaseVO = (PurchaseVO)request.getAttribute("purchaseVO");
%>

<html>
<head>
<title>상품구매완료</title>
</head>

<body>

다음과 같이 구매가 되었습니다.

<table border=1>
	<tr>
		<td>물품번호</td>
		<td><%= purchaseVO.getPurchaseProd().getProdNo() %></td>
		<td></td>
	</tr>
	<tr>
		<td>구매자아이디</td>
		<td><%= purchaseVO.getBuyer().getUserId() %></td>
		<td></td>
	</tr>
	
	<tr>
		<td>구매방법</td>
		<td><% if(purchaseVO.getPaymentOption().equals("1")) { %>
				현금구매
			<% } else if(purchaseVO.getPaymentOption().equals("2")) { %>	
				신용구매
			<% } %>		
		</td>
		<td></td>
	</tr>
	
	<tr>
		<td>구매자이름</td>
		<td><%= purchaseVO.getReceiverName() %></td>
		<td></td>
	</tr>
	
	<tr>
		<td>구매자연락처</td>
		<td><%= purchaseVO.getReceiverPhone() %></td>
		<td></td>
	</tr>
	
	<tr>
		<td>구매자주소</td>
		<td><%= purchaseVO.getDlvyAddr() %></td>
		<td></td>
	</tr>
		<tr>
		<td>구매요청사항</td>
		<td><%= purchaseVO.getDlvyRequest() %></td>
		<td></td>
	</tr>
	<tr>
		<td>배송희망일자</td>
		<td><%= purchaseVO.getDlvyDate() %></td>
		<td></td>
	</tr>
</table>
</body>
</html>