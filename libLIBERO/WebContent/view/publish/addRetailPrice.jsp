<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!--  ///////////////////////// JSTL  ////////////////////////// -->
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<!DOCTYPE html>
<html>
	<head>
		<meta charset="UTF-8">
		<jsp:include page="/common/cdn.jsp"></jsp:include>
		<!--  ///////////////////////// CSS ////////////////////////// -->
		<link rel="stylesheet" href="../resources/css/common.css">
		<style type="text/css">
			.hrColor {
				border-color: #795548;
			}
			
			.formLabel {
				font-size: 15px;
				color: #795548;
				width: 100%;
				padding-top: 10px;
				padding-bottom: 10px;
				margin-bottom: 0;
				font-family: 'Nanum Gothic', sans-serif;
			}
			
			.modalTable {
				margin-bottom: 20px;
			}
		</style>
	</head>
	
	<body>
		<!-- ToolBar Start /////////////////////////////////////-->
		<jsp:include page="../toolbar.jsp" />
	   	<!-- ToolBar End /////////////////////////////////////-->
		
		<!-- //////////// Bootstrap Container Start////////////////// -->
	   	<div class="container">
	   		<!-- Horizontal Steppers -->
				<div class="row">
					<div class="col-md-12">
				
				    <!-- Stepers Wrapper -->
				    <ul class="stepper stepper-horizontal">
				
				    	<!-- First Step -->
				    	<li class="completed">
				        	<a href="#!">
				          		<span class="circle">1</span>
				          		<span class="label">인쇄옵션 등록</span>
				        	</a>
				      	</li>
				
				      	<!-- Second Step -->
				      	<li class="completed">
				        	<a href="#!">
				          		<span class="circle">2</span>
				          		<span class="label">원고 등록</span>
				        	</a>
				      	</li>
				
				      	<!-- Third Step -->
				      	<li class="completed">
					        <a href="#!">
					          	<span class="circle">3</span>
					          	<span class="label">도서 정보 등록</span>
					        </a>
				     	</li>
				     	
				     	<!-- Fourth Step -->
				      	<li class="active">
					        <a href="#!">
					          	<span class="circle">4</span>
					          	<span class="label">가격 책정</span>
					        </a>
				     	</li>
					
				    </ul>
				    <!-- /.Stepers Wrapper -->
				
				  	</div>
				</div>
				<!-- /.Horizontal Steppers -->
	   		<!-- 가격 책정 폼 Start -->
	   		<!-- Extended material form grid -->
			<form>
				<input type="hidden" name="prodNo" value="${param.prodNo}">
				<input type="hidden" id="factoryNickname" name="factoryNickname" value="${factoryNickname}">
				<!-- Grid row -->
				<div class="form-row">
				    <!-- Grid column -->
				    <div class="col-lg-8">
					    <!-- Material input -->
					    <div class="md-form form-group">
			      			<div class="formLabel">가격 책정</div>
			      			<hr class="hrColor">
			      		</div>
			      		<div class="md-form input-group mb-0">
  							<input type="text" id="retailPrice" name="retailPrice" class="form-control col-lg-5" onblur="retailView()" value="${prod.retailPrice}" autofocus="autofocus">
  							<div class="input-group-append">
    							<span class="input-group-text md-addon">원</span>
  							</div>
						</div>
				   	</div>
				    <!-- Grid column -->
			
			    	<!-- Grid column -->
			    	<div class="col-lg-4">
			    		<!-- Material input -->
			    		<div class="md-form form-group">
			      			<div class="formLabel">최종 소비자 가격</div>
			      			<hr class="hrColor">
			      			<div class="text-right font-weight-bold retailView"><fmt:formatNumber value="${prod.retailPrice}" pattern="#,###"/>원</div>
			      		</div>
				    </div>
				    <!-- Grid column -->
				</div>
			  	<!-- Grid row -->
			
				<!-- Grid row -->
				<div class="form-row">
					<!-- Grid column -->
					<div class="col-lg-8">
			    		<!-- Material input -->
			    		<div class="md-form form-group">
			      			<div class="formLabel">할인 적용 여부</div>
			      			<hr class="hrColor">
			      		</div>
						<div class="custom-control custom-checkbox custom-control-inline ">
						  <input type="checkbox" class="custom-control-input" id="discountCode" name="discountCode" value="x">
						  <label class="custom-control-label" for="discountCode">할인 제외</label>
						</div>
				    </div>
				    <!-- Grid column -->
				    
				    <!-- Grid column -->
			    	<div class="col-lg-4">
			    		<!-- Material input -->
			    		<div class="md-form form-group">
			      			<div class="formLabel">예상 수익금</div>
			      			<hr class="hrColor">
			      			<table style="width: 100%">
			      				<tbody>
			      					<tr>
			      						<th>소비자 가격</th>
			      						<td class="text-right retailView"><fmt:formatNumber value="${prod.retailPrice}" pattern="#,###"/>원</td>
			      					</tr>
			      					<tr>
			      						<th>인쇄비</th>
			      						<td id="printPrice" class="text-right">- <fmt:formatNumber value="${prod.printPrice}" pattern="#,###"/>원</td>
			      					</tr>
			      					<tr>
			      						<th>리브리베로 수수료</th>
			      						<td id="fee" class="text-right"></td>
			      					</tr>
			      				</tbody>
			      			</table>
			      			<hr>
			      			<div id="finalPrice" class="text-right font-weight-bold"></div>
			      		</div>
				    </div>
				    <!-- Grid column -->
			  	</div>
			  	<!-- Grid row -->
			
			  	<!-- Button trigger modal -->
				<button type="button"  align="center" class="btn btn-info brown lighten-1 btn-block" data-toggle="modal" onclick="addModalContent()">
				  	최종 확인 및 등록
				</button>
				
			</form>
			<!-- Extended material form grid -->
	   		<!-- 가격 책정 폼 End -->
	   		
			<!-- Central Modal Large -->
			<div class="modal fade" id="centralModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
			
				<!-- Change class .modal-lg to change the size of the modal -->
			  	<div class="modal-dialog modal-lg" role="document">
			
			    	<div class="modal-content">
			      		<div class="modal-header">
			        		<h4 class="modal-title w-100" id="myModalLabel">최종 확인</h4>
				        	<button type="button" class="close" data-dismiss="modal" aria-label="Close">
				          		<span aria-hidden="true">&times;</span>
				        	</button>
			     		</div>
			      	
				      	<div class="modal-body">
				      		<div class="row">
				      			<div class="col-lg-6 text-center justify-content-center align-self-center">
				      				<img src="../resources/images/publish/fileUpload/thumbnailFile/${prod.prodThumbnail}" id="modalImg" width="230px" height="280px">
				      			</div>
				      			<div class="col-lg-6 justify-content-right">
				      				<table class="modalTable">
				      					<tbody>
					      					<tr>
					      						<th><h5><b>책 정보 확인</b></h5></th>
					      					</tr>
				      					</tbody>
				      				</table>
				      				<table class="modalTable">
					      				<tbody>
					      					<tr>
					      						<th><b>도서제목</b></th>
					      						<td>: ${prod.prodName}</td>
					      					</tr>
					      					<tr>
					      						<th><b>저자</b></th>
					      						<td>: ${prod.author}</td>
					      					</tr>
					      					<tr>
					      						<th><b>책 형태</b></th>
					      						<td>: 
					      							<c:if test="${prod.prodType=='paper'}">
					      								종이책
					      							</c:if>
					      							<c:if test="${prod.prodType=='ebook'}">
					      								전자책
					      							</c:if>
					      						</td>
					      					</tr>
					      					<tr>
					      						<th><b>제작목적</b></th>
					      						<td>: 
					      							<c:if test="${prod.purposeCode =='sale'}">
					      								판매용
					      							</c:if>
					      							<c:if test="${prod.purposeCode =='have'}">
					      								소장용
					      							</c:if>
					      						
					      						</td>
					      					</tr>
					      					<tr>
					      						<th><b>카테고리</b></th>
					      						<td>: ${prod.bookCategory}</td>
					      					</tr>
					      					<tr>
					      						<th><b>해시태그</b></th>
					      						<td>: 
					      							<c:forEach var="hash" items="${hash}" varStatus="status">
					      								<c:if test="${!status.last}">
					      									${hash},
					      								</c:if>
					      								<c:if test="${status.last}">
					      									${hash}
					      								</c:if>
					      							</c:forEach>
					      						</td>
					      					</tr>
					      					<tr>
					      						<th><b>페이지수</b></th>
					      						<td>: ${prod.bookPage} pages</td>
					      					</tr>
					      					<tr>
					      						<th><b>소비자가격</b></th>
					      						<td id="modalPrice">: </td>
					      					</tr>
					      					<tr>
					      						<th><b>할인여부</b></th>
					      						<td id="modalDiscount">: </td>
					      					</tr>
					      				</tbody>
				      				</table>
				      				<c:if test="${prod.prodType!='ebook'}">
				      					<table class="modalTable">
					      					<tbody>
					      						<tr>
					      							<th><h5><b>인쇄 옵션</b></h5></th>
					      						</tr>
					      					</tbody>
					      				</table>
					      				<table>
					      					<tbody>
					      						<tr>
					      							<th><b>컬러</b></th>
					      							<td>: 
														<c:if test="${prod.colorType=='color'}">
					      									컬러
					      								</c:if>
					      								<c:if test="${prod.colorType=='black'}">
					      									흑백
					      								</c:if>
													</td>
					      						</tr>
					      						<tr>
					      							<th><b>규격</b></th>
					      							<td>: ${prod.sizeType}</td>
					      						</tr>
					      						<tr>
					      							<th><b>표지 재질</b></th>
					      							<td>: 
					      								<c:if test="${prod.coverType=='snow'}">
					      									스노우
					      								</c:if>
					      								<c:if test="${prod.coverType=='mont'}">
					      									몽블랑
					      								</c:if>
					      								<c:if test="${prod.coverType=='arte'}">
					      									아트
					      								</c:if>
					      							</td>
					      						</tr>
					      						<tr>
					      							<th><b>내지 재질</b></th>
					      							<td>: 
					      								<c:if test="${prod.innerType=='white'}">
					      									백상지
					      								</c:if>
					      								<c:if test="${prod.innerType=='ivory'}">
					      									미색지
					      								</c:if>
					      								<c:if test="${prod.innerType=='rough'}">
					      									갱지
					      								</c:if>
					      							</td>
					      						</tr>
					      					</tbody>
					      				</table>
				      				</c:if>
				      			</div>
				      			
				      		</div> 
				      		
				      	</div>
			      	
				      	<div class="modal-footer">
				      		<div class="col-lg-12">
			      			<button type="button" class="btn btn-brown brown lighten-1 btn-md btn-block col-lg-5" style="position: relative; float: left;" onclick="addRetailPrice()">등록</button>
			        		<button type="button" class="btn btn-outline-brown waves-effect btn-md btn-block col-lg-5" style="position: relative; float: right;" data-dismiss="modal">취소</button>
				      		</div>
				      	</div>
			    	</div>
				</div>
			</div>
			<!-- Central Modal Large -->
	   	</div>
	   	<jsp:include page="../../common/footer.jsp"></jsp:include>
	</body>
	<script type="text/javascript">
		$(function(){
			if ("${prod.purposeCode}"=='sale') {
				var price = $("input[name='retailPrice']").val();
				var printPrice = "${prod.printPrice}";
				var fee = Math.ceil(price*0.3/10)*10;
				
				fee = numberWithCommas(fee);
				price = numberWithCommas(price);
				printPrice = numberWithCommas(printPrice);
				
				$("#fee").html("- "+fee+"원");
				
				var finalPrice = removeCommas(price)-removeCommas(printPrice)-removeCommas(fee);
				
				finalPrice = numberWithCommas(finalPrice);
				
				$("#finalPrice").html(finalPrice+"원");
			}
			
			if ("${prod.purposeCode}"=='have') {
				var printPrice = "${prod.printPrice}";
				var fee = Math.ceil(printPrice*0.3);
				fee = numberWithCommas(fee);
				
			}
			
		});
		
		function retailView() {
			var price = removeCommas($("input[name='retailPrice']").val());
			var printPrice = "${prod.printPrice}";
			// 10의 자리에서 올림
			if ("${prod.purposeCode}"=='sale') {
				var fee = Math.ceil(price*0.3/10)*10;
				fee = numberWithCommas(fee);
				price = Math.ceil(price/100)*100;
				price = numberWithCommas(price);
			}
			if ("${prod.purposeCode}"=='have') {
				var fee = Math.ceil(printPrice*0.3);
				fee = numberWithCommas(fee);
				price = Math.ceil(price);
				price = numberWithCommas(price);
			}
			
			
			printPrice = numberWithCommas(printPrice);
			
			var finalPrice = removeCommas(price)-removeCommas(printPrice)-removeCommas(fee);
			
			finalPrice = numberWithCommas(finalPrice);
			
			// 올림값 반환
			$("input[name='retailPrice']").val(price);
			$(".retailView").html(price+"원");
			$("#modalPrice").html(": "+price+"원");
			$("#fee").html("- "+fee+"원");
			
			$("#finalPrice").html(finalPrice+"원");
		}
		
		function addModalContent() {
			var price = removeCommas($("#retailPrice").val());
			var discount = $("input[name='discountCode']:checked").val();
			var thumbnail = "${prod.prodThumbnail}";
			var finalPrice = $("#finalPrice").html();
			console.log(finalPrice);
			finalPrice = removeCommas(finalPrice);
			//finalPrice = Number(finalPrice.slice(0,-1));
			console.log(finalPrice);
			
			if (discount=="x") {
				$("#modalDiscount").html(": 할인제외");
			}else {
				$("#modalDiscount").html(": 할인포함");
			}
			
			if (thumbnail != "") {
				$("#modalImg").attr("src","../resources/images/publish/fileUpload/thumbnailFile/${prod.prodThumbnail}");
			}else {
				$("#modalImg").attr("src","../resources/images/publish/fileUpload/coverFile/${prod.coverFile}");
			}
			
			if ("${prod.purposeCode}"=='sale' && price == "") {
				Swal.fire({
					  icon: 'error',
					  text: '가격을 등록해주세요.'
					});
	    		return;
			} else if (0>finalPrice) {
				Swal.fire({
					  icon: 'error',
					  text: '수익금이 마이너스입니다. 가격을 높여주세요.'
					});
	    		return;
			}else {
				//SweetAlert Timer 
				let timerInterval
				Swal.fire({
				  title: '썸네일 생성중...',
				  html: '',
				  timer: 2000,
				  timerProgressBar: true,
				  onBeforeOpen: () => {
				    Swal.showLoading()
				    timerInterval = setInterval(() => {
				      const content = Swal.getContent()
				      if (content) {
				        const b = content.querySelector('b')
				        if (b) {
				          b.textContent = Swal.getTimerLeft()
				        }
				      }
				    }, 100)
				  },
				  onClose: () => {
				    clearInterval(timerInterval)
				  }
				}).then((result) => {
				  /* Read more about handling dismissals below */
				  if (result.dismiss === Swal.DismissReason.timer) {
				    console.log('I was closed by the timer')
				    $("#centralModal").modal("show");
				  }
				});
				//SweetAlert End
				
				
			}
			
		}
		
		function numberWithCommas(x) {
		    return x.toString().replace(/\B(?=(\d{3})+(?!\d))/g, ",");
		}
			
		function removeCommas(x){ 
			x = parseInt(x.replace(/,/g,""));
			return x;
		}
		
		function sendMsg(){
			var facNick = $("#factoryNickname").val();
			var msg = {
					type : "message", //메세지 구분하는 구분자 - 상대방 아이디와 메세지 포함
					sendNickname : "${sessionScope.user.userId}",
					recvNickname : facNick,
			};
			ws.send(JSON.stringify(msg));
		};
		
		function addRetailPrice() {
			var price = removeCommas($("#retailPrice").val());
			
			//sendMsg();			
			$("input[name='retailPrice']").val(price);
			$("form").attr("method" , "POST").attr("action" , "/libero/publish/addRetailPrice").submit();
		}
	</script>
</html>