<%@ page language="java" contentType="text/html; charset=EUC-KR"%>
<%@ page pageEncoding="EUC-KR"%>

<%@ page import="com.model2.mvc.service.domain.Purchase" %>

<%
	Purchase purchase = (Purchase)request.getAttribute("purchase");
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
		<td><%= purchase.getPurchaseProd().getProdNo() %></td>
		<td></td>
	</tr>
	<tr>
		<td>�����ھ��̵�</td>
		<td><%= purchase.getBuyer().getUserId() %></td>
		<td></td>
	</tr>
	
	<tr>
		<td>���Ź��</td>
		<td><% if(purchase.getPaymentOption().equals("1")) { %>
				���ݱ���
			<% } else if(purchase.getPaymentOption().equals("2")) { %>	
				�ſ뱸��
			<% } %>		
		</td>
		<td></td>
	</tr>
	
	<tr>
		<td>�������̸�</td>
		<td><%= purchase.getReceiverName() %></td>
		<td></td>
	</tr>
	
	<tr>
		<td>�����ڿ���ó</td>
		<td><%= purchase.getReceiverPhone() %></td>
		<td></td>
	</tr>
	
	<tr>
		<td>�������ּ�</td>
		<td><%= purchase.getDlvyAddr() %></td>
		<td></td>
	</tr>
		<tr>
		<td>���ſ�û����</td>
		<td><%= purchase.getDlvyRequest() %></td>
		<td></td>
	</tr>
	<tr>
		<td>����������</td>
		<td><%= purchase.getDlvyDate() %></td>
		<td></td>
	</tr>
</table>
</body>
</html>