<%@ page contentType="text/html; charset=EUC-KR" %>
<%@ page pageEncoding="EUC-KR"%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<c:choose>
    <c:when test="${param.listType eq 'user'}">
        <c:set var="listFunction" value="fncGetUserList" />
    </c:when>
    <c:when test="${param.listType eq 'product'}">
        <c:set var="listFunction" value="fncGetProductList" />
    </c:when>
    <c:when test="${param.listType eq 'purchase'}">
        <c:set var="listFunction" value="fncGetPurchaseList" />
    </c:when>    
</c:choose>
 
<div class="container text-center">
		 
		 <nav>
		  <!-- ũ������ :  pagination-lg pagination-sm-->
		  <ul class="pagination" >
		    
		    <!--  <<== ���� nav -->
			<c:if test="${resultPage.currentPage > resultPage.pageUnit}">
				<li>
				<a href="javascript:${listFunction}('${resultPage.beginUnitPage - 1}')" aria-label="Previous">
					<span aria-hidden="true">&laquo;</span>
				</a>		        
			</c:if>	
		    </li>
		    
		    <!--  �߾�  -->
			<c:forEach var="i"  begin="${resultPage.beginUnitPage}" end="${resultPage.endUnitPage}" step="1">
				<c:if test="${ resultPage.currentPage == i }">
					<!--  ���� page ����ų��� : active -->
				    <li class="active">
				    	<a href="javascript:${listFunction}('${ i }');">${ i }<span class="sr-only"></span></a>
				    </li>
				</c:if>	
				
				<c:if test="${ resultPage.currentPage != i}">	
					<li>
						<a href="javascript:${listFunction}('${ i }');">${ i }</a>
					</li>
				</c:if>
			</c:forEach>
		    
		     <!--  ���� nav==>> -->
		     <c:if test="${resultPage.endUnitPage < resultPage.maxPage}">
		     	<li>
			    <a href="javascript:${listFunction}('${resultPage.endUnitPage + 1}')" aria-label="Next">
			        <span aria-hidden="true">&raquo;</span>
			    </a>
			</c:if>
		    </li>
		  </ul>
		</nav>
</div>