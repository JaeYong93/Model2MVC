<%@ page contentType="text/html; charset=euc-kr" %>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
	
<c:choose>
    <c:when test="${param.listType eq 'user'}">
        <c:set var="listFunction" value="fncGetUserList" />
    </c:when>
    <c:when test="${param.listType eq 'product'}">
        <c:set var="listFunction" value="fncGetProductList" />
    </c:when>
</c:choose>

<c:if test="${resultPage.currentPage > resultPage.pageUnit}">
    <a href="javascript:${listFunction}('${resultPage.currentPage - 1}')">◀ 이전</a>
</c:if>

<c:forEach var="i" begin="${resultPage.beginUnitPage}" end="${resultPage.endUnitPage}" step="1">
    <a href="javascript:${listFunction}('${i}')">${i}</a>
</c:forEach>

<c:if test="${resultPage.endUnitPage < resultPage.maxPage}">
    <a href="javascript:${listFunction}('${resultPage.endUnitPage + 1}')">다음 ▶</a>
</c:if>

