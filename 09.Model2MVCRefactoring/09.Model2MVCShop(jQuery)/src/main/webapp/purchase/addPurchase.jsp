<%@ page language="java" contentType="text/html; charset=EUC-KR"%>
<%@ page pageEncoding="EUC-KR"%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<html>
<head>
<title>��ǰ���ſϷ�</title>
</head>

<body>

������ ���� ���Ű� �Ϸ� �Ǿ����ϴ�.

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