<%@ page language="java" contentType="text/html; charset=EUC-KR"%>
<%@ page pageEncoding="EUC-KR"%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<html lang ="ko">
<title>구매정보수정</title>
<head>

	<meta charset="EUC-KR">
	<meta name="viewport" content="width=device-width, initial-scale=1.0" />
	
	<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css" >
	<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap-theme.min.css" >
	<script src="https://code.jquery.com/jquery-3.1.1.min.js"></script>
	<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js" ></script>

	<script src="/javascript/bootstrap-dropdownhover.min.js"></script>
	
	<link rel="stylesheet" href="http://code.jquery.com/ui/1.12.1/themes/base/jquery-ui.css">
	<script src="https://code.jquery.com/jquery-1.12.4.js"></script>
	<script src="https://code.jquery.com/ui/1.12.1/jquery-ui.js"></script>	
		
	<link href="/css/bootstrap-dropdownhover.min.css" rel="stylesheet">

	<script type="text/javascript">
		$(function(){
			$('#dlvyDate').datepicker({
				dateFormat: 'yy/mm/dd',
				showMonthAfterYear : true,
				showOn : "both",
				buttonImage: "../images/calander.png",
				changeYear : true,
				changeMonth : true,
				monthNamesShort: ['1월','2월','3월','4월','5월','6월','7월','8월','9월','10월','11월','12월'],
				monthNames: ['1월','2월','3월','4월','5월','6월','7월','8월','9월','10월','11월','12월'],
				dayNamesMin: ['일','월','화','수','목','금','토'],
				dayNames: ['일요일','월요일','화요일','수요일','목요일','금요일','토요일'],
				position: {
					my: 'right top',
					at: 'right bottom'
				},
				onSelect: function(dateText, inst) {
					var selectedDate = $(this).datepicker('getDate');
					var today = new Date();
					
					if (selectedDate < today) {
						alert("오늘 이후의 날짜만 선택할 수 있습니다.");
						$(this).val(''); 
					}
				}
			});
		});
		
		// 구매정보 수정 Event
		$(function() {
			$("button.btn.btn-primary").on("click", function() {
				fncUpdatePurchase();	
			});
		});		
		
		function fncUpdatePurchase() {
			// Form 유효성 검증
			var tranNo=$("input[name='tanNo']").val();
			var name=$("input[name='receiverName']").val();
			var phone=$("input[name='receiverPhone']").val();
			var addr=$("input[name='dlvyAddr']").val();
			var date=$("input[name='dlvyDate']").val();
			
			if(name == null || name.length <1){
				alert("이름은 반드시 입력하셔야 합니다.");
				return;
			}
			if(phone == null || phone.length <1){
				alert("연락처는 반드시 입력하셔야 합니다.");
				return;
			}
			if(addr == null || addr.length <1){
				alert("주소는 반드시 입력하셔야 합니다.");
				return;
			}
			if(date == null || date.length <1){
				alert("배송희망일은 반드시 입력하셔야 합니다.");
				return;
			}
			$("form").attr("method" , "POST").attr("action" , "/purchase/updatePurchase").submit();
		}
		
		
		// 수정 취소 Event
		$(function() {
			$("#undo").on("click", function() {
				history.back();
			});
		});
		
		// 개인정보조회회 Event	
		$(function() {
			$("a[href='#']:contains('개인정보조회')").on("click" , function() {
				self.location = "/user/getUser?userId=${sessionScope.user.userId}"
			});
		});

		// 판매상품등록 Event
		$(function() {
			$( "a:contains('판매상품등록')" ).on("click" , function() {
				self.location = "../product/addProductView.jsp"
	 		});
		});		
	
		// 판매상품관리 Event
		$(function() {
			$( "a:contains('판매상품관리')" ).on("click" , function() {
				self.location = "/product/listProduct?menu=manage"
			});
		});		
		
		// 상품검색 Event
		$(function() {
			$("a[href='#' ]:contains('상품검색')").on("click" , function() {
				self.location = "/product/listProduct?menu=search"
			});
		});	
		
		// 구매이력조회 Event
		$(function() {
			$("a[href='#']:contains('구매이력조회')").on("click" , function() {
				self.location = "/purchase/listPurchase";
			});	
		});		
		
		// 최근본상품 Event
		$(function() { 
			$( "a:contains('최근본상품')" ).on("click" , function() {
				$(self.location).attr("href","../history.jsp");
			});
		});	
		
		
	</script>

	<style>
 		body {
			padding-top : 70px;
		}
		
		.table-name{
			text-align : center; 
		}			
		
		.table-bordered {
			border: 4px solid black; 
			border-collapse: collapse; 
		}		
		
		.table-bordered thead tr td {
			border: 4px solid black;
			padding: 6px;
		}
		
		.table-bordered tbody tr td {
			border: 1px solid black;
			padding: 6px;
		}			

		.Form-group {
			text-align : right;
		}		
	</style>		
</head>

<body>
	<jsp:include page="/layout/toolbar.jsp" />

	<div class="container">

		<div class="row">

			<div class="col-md-3">

				<div class="panel panel-primary">
				
					<div class="panel-heading">
						<i class="glyphicon glyphicon-user"></i> 회원관리
					</div>

					<ul class="list-group">
						<li class="list-group-item">
							<a href="#">개인정보조회</a> 
						</li>
						<c:if test="${sessionScope.user.role == 'admin'}">
						<li class="list-group-item"><a href="#">회원목록조회</a></li>
						</c:if>
					</ul>
				</div>
				
				<c:if test="${sessionScope.user.role == 'admin'}">
				<div class="panel panel-primary">
					<div class="panel-heading">
						<i class="glyphicon glyphicon-tasks"></i> 상품관리
					</div>
					
					<ul class="list-group">
						<li class="list-group-item">
							<a href="#">판매상품등록</a>
						</li>
						<li class="list-group-item">
							<a href="#">판매상품관리</a>
						</li>
					</ul>
				</div>
				</c:if>

				<div class="panel panel-primary">
					<div class="panel-heading">
						<i class="glyphicon glyphicon-shopping-cart"></i> 상품구매
					</div>
					
					<ul class="list-group">
						<li class="list-group-item">
							<a href="#">상품검색</a>
						</li>
						<li class="list-group-item">
							<a href="#">구매이력조회</a>
						</li>
						<li class="list-group-item">
							<a href="#">최근본상품</a>
						</li>
					</ul>
				</div>
			</div>			
	
			<div class="col-md-9">
				<form>
				<input type ="hidden" name="tranNo" value="${purchase.tranNo}" id="tranNo">
				<table class="table table-bordered">
					<thead class = "thead-dark">
						<tr>
							<th colspan="2" class="table-name"><h4>구매정보수정</h4></th>
						</tr>
					</thead>

					<tbody>
						<tr>
							<td class="success">구매자아이디</td>
							<td class="active">${purchase.buyer.userId}</td>
						</tr>
						<tr>
							<td class="success">구매자이름</td>
							<td class="active">
								<input type = "text" name = "receiverName" value = "${purchase.receiverName}">
							</td>
						</tr>
						<tr>
							<td class="success">구매방법</td>
							<td class="active">
								<select id="paymentOption" name="paymentOption">
									<option value="1" ${purchase.paymentOption eq '1' ? 'selected' : ''}>현금구매</option>
									<option value="2" ${purchase.paymentOption eq '2' ? 'selected' : ''}>신용구매</option>
								</select>
							</td>
						</tr>						
						<tr>
							<td class="success">구매자 연락처</td>
							<td class="active">
								<input type = "text" name = "receiverPhone" value = "${purchase.receiverPhone}">
							</td>
						</tr>
						<tr>
							<td class="success">구매자 주소</td>
							<td class="active">
								<input type = "text" name = "dlvyAddr" value = "${purchase.dlvyAddr}">
							</td>
						</tr>
						<tr>
							<td class="success">구매요청사항</td>
							<td class="active">
								<input type = "text" name = "dlvyRequest" value = "${purchase.dlvyRequest}">
							</td>
						</tr>
						<tr>
							<td class="success">배송희망일</td>
							<td class="active">
								<input type = "text" readonly="readonly" name = "dlvyDate" id="dlvyDate" value = "${purchase.dlvyDate}">
							</td>
						</tr>
					</tbody>
				</table>
				<div class = "Form-group">
					<input type ="hidden" name="tranNo" value="${purchase.tranNo}" id="tranNo">
					<button type=button class="btn btn-primary" data-tranNo ="${purchase.tranNo}">수정</button>
					<button type=button class="btn btn-primary" id="undo">취소</button>
				</div>	
				</form>
				
			</div>
		</div>
	</div>		

</body>
</html>