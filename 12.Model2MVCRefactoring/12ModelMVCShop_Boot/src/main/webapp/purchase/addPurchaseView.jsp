<%@ page language="java" contentType="text/html; charset=EUC-KR" %>
<%@ page pageEncoding="EUC-KR"%>

<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>

<!DOCTYPE html>

<html lang="ko">
<title>상품구매</title>
<head>
	<meta charset="EUC-KR">
	<meta name="viewport" content="width=device-width, initial-scale=1.0" />
	
	<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css" >
	<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap-theme.min.css" >
	<script src="https://code.jquery.com/jquery-3.1.1.min.js"></script>
	<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js" ></script>

	<script src="https://www.example.com/javascript/bootstrap-dropdownhover.min.js"></script>
		
	<link rel="stylesheet" href="https://code.jquery.com/ui/1.12.1/themes/base/jquery-ui.css">

	<script src="https://code.jquery.com/jquery-1.12.4.js"></script>
	<script src="https://code.jquery.com/ui/1.12.1/jquery-ui.js"></script>	
		
	<link href="https://www.example.com/css/bootstrap-dropdownhover.min.css" rel="stylesheet">
	
	<script type="text/javascript">

		var search = {
				"searchCondition" : $("select[name='searchCondition']").val(),
				"searchKeyword" : $("#searchKeyword").val(),
					"searchOrderByPrice" : $("input[name='searchOrderByPrice']").val()
				}	 
		 
		 $.ajax({
			    url: "/product/json/listProduct",
			    method: "POST",
			    contentType: 'application/json; charset=euc-kr',
			    data: JSON.stringify(search),
			    dataType: "json",
			    success: function(responseData) {
			        var totalCount = responseData.totalCount;
			        console.log("Total Count:", totalCount);
	
			        $("#productCountBadge").text(totalCount);
	
			        var productList = responseData.list;
	
			    },
			    error: function() {
			        console.log("Error 발생");
			    }
			});
	
		// 상품구매 Event
		$(function() {
			$( "button.btn.btn-primary").on("click" , function() {
				fncAddPurchase();
			});
		});	
	
		// 폼 리셋 Evnet
		$(function() {
			$("a[href='#']").on("click" , function() {
				$("form")[0].reset();
			});
		});	
	
		// 회원목록조회 Event
		$(function() {
			$("a:contains('회원목록조회')").on("click" , function() {
				//$(self.location).attr("href","/user/logout");
				self.location = "/user/listUser"
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

		// 찜목록 Event
	 	$( "a:contains('찜목록')" ).on("click" , function() {
			$(self.location).attr("href","/product/dibProductList");
		});				
		
		// 최근본상품 Event
		$(function() { 
			$( "a:contains('최근본상품')" ).on("click" , function() {
				$(self.location).attr("href","../history.jsp");
			});
		});	 	
		
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
					today.setHours(0,0,0,0);
					
					if (selectedDate < today) {
						alert("오늘 이후의 날짜만 선택할 수 있습니다.");
						$(this).val(''); 
					}
				}
			});
		});
		
		function fncAddPurchase() {
			$("form").attr("method" , "POST").attr("action" , "/purchase/addPurchase").submit();
		}
	</script>

	<style>
		body {
			padding-top : 70px;
		}
		
		.ui-datepicker {
		    z-index: 9999 !important;
		}		
		
		.form-control {
 		   width: 300px;
		}
		
		.col-sm-4 {
		    width: 50%;
		}		
	</style>
</head>

<body>
	<jsp:include page="/layout/toolbar.jsp"/>
	
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
							<a href="#">상품검색<span class="badge" id="productCountBadge"></span></a>
						</li>
						<li class="list-group-item">
							<a href="#">구매이력조회</a>
						</li>
						<li class="list-group-item">
							<a href="#">찜목록</a>
						</li>						
						<li class="list-group-item">
							<a href="#">최근본상품</a>
						</li>
					</ul>
				</div>
			</div>			
	
		<div class="col-md-9">
		
			<div class="page-header text-info">
				<h4>상품구매</h4>
			</div>
		
			<form class= "form-horizontal" name="addPurchase">
				<input type = "hidden" name = "prodNo" value = "${param.prodNo}"/>
				<input type = "hidden" name = "userId" value = "${user.userId}"/>
				
				<div class="form-group">
					<label for="prodNo" class="col-sm-2 control-label" >상품번호</label>
					<div class="col-sm-4">${product.prodNo}</div>
				</div>
	
				<div class="form-group">
					<label for="prodName" class="col-sm-2 control-label" >상품명</label>
					<div class="col-sm-4">${product.prodName}</div>
				</div>
				
				<div class="form-group">
					<label for="prodDetail" class="col-sm-2 control-label" >상품상세정보</label>
					<div class="col-sm-4">${product.prodDetail}</div>
				</div>					
				
				<div class="form-group">
					<label for="prodDetail" class="col-sm-2 control-label" >가격</label>
					<div class="col-sm-4">${product.price}원</div>
				</div>			
	
				<div class="form-group">
					<label for="manuDate" class="col-sm-2 control-label" >제조일자</label>
					<div class="col-sm-4">${product.manuDate}</div>
				</div>
				
				<div class="form-group">
					<label for="userId" class="col-sm-2 control-label" >구매자아이디</label>
					<div class="col-sm-4">${user.userId}</div>
				</div>			
	
				<div class="form-group">
					<label for="userId" class="col-sm-2 control-label" >구매자이름</label>
					<div class="col-sm-4">
						<input type="text" class="form-control" id="receiverName" name="receiverName" value="${user.userName}">
					</div>
				</div>
	
				<div class="form-group">
					<label for="paymentOption" class="col-sm-2 control-label">구매방법</label>
					<div class="col-sm-4">
						<select id="paymentOption" name="paymentOption" class="form-control">
							<option value="1" ${purchase.paymentOption eq '1' ? 'selected' : ''}>현금구매</option>
							<option value="2" ${purchase.paymentOption eq '2' ? 'selected' : ''}>신용구매</option>
						</select>
					</div>
				</div>
		
				<div class="form-group">
					<label for="receiverPhone" class="col-sm-2 control-label" >구매자연락처</label>
					<div class="col-sm-4">
						<input type="text" class="form-control" id="receiverPhone" name="receiverPhone" value="${user.phone}">
					</div>
				</div>			
	
				<div class="form-group">
					<label for="dlvyAddr" class="col-sm-2 control-label" >구매자주소</label>
					<div class="col-sm-4">
						<div class="input-group">
							<input type="text" class="form-control" id="dlvyAddr" name="dlvyAddr" placeholder="주소를 입력해주세요.">
							<span class="input-group-btn">
								<button type="button" class="btn btn-default" onclick="DaumPostcode()">주소검색</button>
							</span>
						</div>
						<div id="map" style="width:300px;height:300px;margin-top:10px;display:none"></div>
					</div>
				</div>
				
				<script src="//t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>			
				<script type="text/javascript" src="//dapi.kakao.com/v2/maps/sdk.js?appkey=5e3239f6b618581baf00d6add12eb8ef&libraries=services"></script>
				
				<script>
			
					var mapContainer = document.getElementById('map'), // 지도를 표시할 div
						mapOption = {
						center: new daum.maps.LatLng(37.537187, 127.005476), // 지도의 중심좌표
						level: 5 // 지도의 확대 레벨
					};
			
					//지도를 미리 생성
					var map = new daum.maps.Map(mapContainer, mapOption);
					//주소-좌표 변환 객체를 생성
					var geocoder = new daum.maps.services.Geocoder();
					//마커를 미리 생성
					var marker = new daum.maps.Marker({
						position: new daum.maps.LatLng(37.537187, 127.005476),
						map : map
					});
					
					function DaumPostcode() {
						new daum.Postcode({
							oncomplete: function(data) {
								var addr = data.address; // 최종 주소 변수
			
								// 주소 정보를 해당 필드에 넣는다.
								document.getElementById("dlvyAddr").value = addr;
								// 주소로 상세 정보를 검색
								geocoder.addressSearch(data.address, function(results, status) {
									// 정상적으로 검색이 완료됐으면
									if (status === daum.maps.services.Status.OK) {
					
					 					var result = results[0]; //첫번째 결과의 값을 활용

										// 해당 주소에 대한 좌표를 받아서
										var coords = new daum.maps.LatLng(result.y, result.x);
					 					
										// 지도를 보여준다.
										mapContainer.style.display = "block";
										map.relayout();
										
										// 지도 중심을 변경한다.
										map.setCenter(coords);
										// 마커를 결과값으로 받은 위치로 옮긴다.
										marker.setPosition(coords)
										
								        var infowindow = new kakao.maps.InfoWindow({
								            content: '<div style="width:200px;text-align:center;padding:6px 0;">'+result.address_name+'</div>'
								        });
								        infowindow.open(map, marker);
										
									}
								});
							}
			   	 		}).open();
					}
				</script>				
			
				<div class="form-group">
					<label for="dlvyRequest" class="col-sm-2 control-label" >구매요청사항</label>
					<div class="col-sm-4">				
						<input type="text" class="form-control" id="dlvyRequest" name="dlvyRequest">
					</div>	
				</div>		
				
				<div class="form-group">
					<label for="dlvyDate" class="col-sm-2 control-label" >배송희망일자</label>
					<div class="col-sm-4">				
						<input type="text" class="form-control" id="dlvyDate" name="dlvyDate" readonly="readonly">
					</div>	
				</div>
			
				<br/>
				
				<div class="form-group">
					<div class="col-sm-4 text-center">
						<button type=button class="btn btn-primary">구매</button>
						<a class="btn btn-primary btn" href="#" role="button">취소</a>
					</div>
				</div>
			</form>
			</div>
		</div>								
	</div>	
	
</body>
</html>