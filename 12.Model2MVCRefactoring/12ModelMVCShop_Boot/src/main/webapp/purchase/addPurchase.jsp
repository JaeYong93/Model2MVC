<%@ page language="java" contentType="text/html; charset=EUC-KR"%>
<%@ page pageEncoding="EUC-KR"%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<!DOCTYPE html>

<html lang="ko">
<title>��ǰ���ſϷ�</title>
<head>

	<meta charset="EUC-KR">
	<meta name="viewport" content="width=device-width, initial-scale=1.0" />
	
	<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css" >
	<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap-theme.min.css" >
	<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js" ></script>

	<style>
		body {
			padding-top : 70px;
		}
	</style>

</head>

<body>
	<jsp:include page="/layout/toolbar.jsp"/>

	������ ���� ���Ű� �Ǿ����ϴ�.
	
	<table border=1>
		<tr>
			<td>��ǰ��ȣ</td>
			<td>${purchase.purchaseProd.prodNo}</td>
			<td></td>
		</tr>
		<tr>
			<td>�����ھ��̵�</td>
			<td>${purchase.buyer.userId}</td>
			<td></td>
		</tr>
		
		<tr>
			<td>���Ź��</td>
			<td>
			<c:if test="${purchase.paymentOption eq '1'}">
				���ݱ���
			</c:if>
			<c:if test="${purchase.paymentOption eq '2'}">		
				�ſ뱸��
			</c:if>			
			</td>
			<td></td>
		</tr>
		
		<tr>
			<td>�������̸�</td>
			<td>${purchase.receiverName}</td>
			<td></td>
		</tr>
		
		<tr>
			<td>�����ڿ���ó</td>
			<td>${purchase.receiverPhone}</td>
			<td></td>
		</tr>
		
		<tr>
			<td>�������ּ�</td>
			<td>${purchase.dlvyAddr}</td>
			<td></td>
		</tr>
			<tr>
			<td>���ſ�û����</td>
			<td>${purchase.dlvyRequest}</td>
			<td></td>
		</tr>
		<tr>
			<td>����������</td>
			<td>${purchase.dlvyDate}</td>
			<td></td>
		</tr>
	</table>
</body>
</html>