<%@ page language="java" contentType="text/html; charset=EUC-KR"%>
<%@ page pageEncoding="EUC-KR"%>

<%@ page import="com.model2.mvc.service.purchase.vo.*" %>

<%
	PurchaseVO purchaseVO = (PurchaseVO)request.getAttribute("purchaseVO");
%>

<html>
<head>
<title>��ǰ���ſϷ�</title>
</head>

<body>

������ ���� ���Ű� �Ǿ����ϴ�.

<table border=1>
	<tr>
		<td>��ǰ��ȣ</td>
		<td><%= purchaseVO.getPurchaseProd().getProdNo() %></td>
		<td></td>
	</tr>
	<tr>
		<td>�����ھ��̵�</td>
		<td><%= purchaseVO.getBuyer().getUserId() %></td>
		<td></td>
	</tr>
	
	<tr>
		<td>���Ź��</td>
		<td><% if(purchaseVO.getPaymentOption().equals("1")) { %>
				���ݱ���
			<% } else if(purchaseVO.getPaymentOption().equals("2")) { %>	
				�ſ뱸��
			<% } %>		
		</td>
		<td></td>
	</tr>
	
	<tr>
		<td>�������̸�</td>
		<td><%= purchaseVO.getReceiverName() %></td>
		<td></td>
	</tr>
	
	<tr>
		<td>�����ڿ���ó</td>
		<td><%= purchaseVO.getReceiverPhone() %></td>
		<td></td>
	</tr>
	
	<tr>
		<td>�������ּ�</td>
		<td><%= purchaseVO.getDlvyAddr() %></td>
		<td></td>
	</tr>
		<tr>
		<td>���ſ�û����</td>
		<td><%= purchaseVO.getDlvyRequest() %></td>
		<td></td>
	</tr>
	<tr>
		<td>����������</td>
		<td><%= purchaseVO.getDlvyDate() %></td>
		<td></td>
	</tr>
</table>
</body>
</html>