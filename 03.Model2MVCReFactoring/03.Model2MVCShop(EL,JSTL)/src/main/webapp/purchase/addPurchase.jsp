<%@ page language="java" contentType="text/html; charset=EUC-KR"%>
<%@ page pageEncoding="EUC-KR"%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<html>
<head>
<title>상품구매완료</title>
</head>

<body>

다음과 같이 구매가 되었습니다.

<table border=1>
	<tr>
		<td>물품번호</td>
		<td>${purchase.purchaseProd.prodNo}</td>
		<td></td>
	</tr>
	<tr>
		<td>구매자아이디</td>
		<td>${purchase.buyer.userId}</td>
		<td></td>
	</tr>
	
	<tr>
		<td>구매방법</td>
		<td>
		<c:if test="${purchase.paymentOption eq '1'}">
			현금구매
		</c:if>
		<c:if test="${purchase.paymentOption eq '2'}">		
			신용구매
		</c:if>			
		</td>
		<td></td>
	</tr>
	
	<tr>
		<td>구매자이름</td>
		<td>${purchase.receiverName}</td>
		<td></td>
	</tr>
	
	<tr>
		<td>구매자연락처</td>
		<td>${purchase.receiverPhone}</td>
		<td></td>
	</tr>
	
	<tr>
		<td>구매자주소</td>
		<td>${purchase.dlvyAddr}</td>
		<td></td>
	</tr>
		<tr>
		<td>구매요청사항</td>
		<td>${purcahse.dlvyRequest}</td>
		<td></td>
	</tr>
	<tr>
		<td>배송희망일자</td>
		<td>${purchase.dlvyDate}</td>
		<td></td>
	</tr>
</table>
</body>
</html>