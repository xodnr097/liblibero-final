<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>	
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<!DOCTYPE html>
<html lang="ko">

<head>
<meta charset="UTF-8">
<jsp:include page="../../common/cdn.jsp" />
</head>

<body>
	<jsp:include page="../toolbar.jsp" />
	<jsp:include page="../community/addReport.jsp" />
	<div class="mt-5">&nbsp;</div>
	<div class="container">
   
        <form class="form-group my-5 py-5">
       		<c:if test = "${param.postType == 'n' }" ><input type="hidden" name="postType" value="n"></c:if>
            <c:if test = "${param.postType == 'f' }" ><input type="hidden" name="postType" value="f"></c:if>
            <c:if test = "${param.postType == 'q' }" ><input type="hidden" name="postType" value="q"></c:if>
            <c:if test = "${param.postType != 'q' }" >	
              <h1>게시글 작성</h1><br>
              <div class="form-row my-3">
                  <div class="input-group col-lg-12">
                      <input type="text" class="form-control" name="postName" placeholder="제목을 입력해주세요">
                  </div>
              </div>
            </c:if>
            <c:if test = "${param.postType == 'q' }" >	
            	<h1>문의하기</h1><br>
            	<div class="form-row my-3">
            		<div class="input-group col-lg-3">
            			<select name="qnaRegType" class="form-control">
											<option hidden>문의종류</option>
											<option value="p">출판하기</option>
											<option value="b">구매하기</option>
											<option value="u">이용문의</option>
											<option value="e">기타</option>
						</select>
	                </div>
	                <div class="input-group col-lg-9">
	                    <input type="text" class="form-control" name="postName" placeholder="제목을 입력해주세요">
	                </div>
	                <input type="hidden" id="qnaCode" name="qnaCode" value="x" />
					  
            	</div>
            </c:if>	
            <div>
				<textarea id="postContent" name="postContent" class="summernote" style="display: none;"></textarea>
				<div id="summernote"></div>
			</div>
            <div class="form-row justify-content-center my-5">
               
				<button type="button" class="btn btn-outline-brown waves-effect" href="javascript:history.back();" role="button">취&nbsp;소</button>
			    <button type="button" class="btn btn-brown">등&nbsp;록</button>	
            </div>
        </form>

    </div>
<jsp:include page="../../common/footer.jsp"></jsp:include>    
</body>

<link href="/libero/resources/css/summernote/summernote-lite.css" rel="stylesheet">
<script src="/libero/resources/javascript/summernote/summernote-lite.js"></script>
<script src="/libero/resources/javascript/summernote/lang/summernote-ko-KR.min.js"></script>

<script type="text/javascript">


	$(function() {

		$('#summernote').summernote({
			minHeight: 600,
	        maxHeight: 600,
			lang : 'ko-KR',
			focus: true,
			toolbar: [
 			    ['fontname', ['fontname']],
 			    ['fontsize', ['fontsize']],
 			    ['style', ['bold', 'italic', 'underline','strikethrough', 'clear']],
 			    ['color', ['forecolor','color']],
 			    ['table', ['table']],
 			    ['para', ['ul', 'ol', 'paragraph']],
 			    ['height', ['height']],
 			    ['insert',['picture','link','video']],
 			    ['view', ['fullscreen', 'help']]
 			  ],
 			fontNames: ['Arial', 'Arial Black', 'Comic Sans MS', 'Courier New','맑은 고딕','궁서','굴림체','굴림','돋음체','바탕체'],
 			fontSizes: ['8','9','10','11','12','14','16','18','20','22','24','28','30','36','50','72'],
			callbacks: {	
				onImageUpload : function(files, editor, welEditable) {
					console.log(files);

					for (var i = files.length - 1; i >= 0; i--) {
		            	sendFile(files[i], this);
		            }z
				}
			}
  	  	}); //summernote
		
		$("div.note-editable").on('drop',function(e){
            for(i=0; i< e.originalEvent.dataTransfer.files.length; i++){
            	sendFile(e.originalEvent.dataTransfer.files[i],$("#summernote")[0]);
            }
      		e.preventDefault();
  		});
  	  	
		$("button:contains('등')").on("click", function(){
			$('textarea[name="postContent"]').val($('#summernote').summernote('code'));
			var postName = $("input[name='postName']").val();
			var postContent = $("#postContent").val();
			var qnaRegType = $("select[name=qnaRegType] option:selected").val();
			var postType = $("input[name='postType']").val();
			
			if(postName == null || postName.length <1){
				alert("제목을 입력해주세요.");
				return;
			}
			
			if(postContent == "<p><br></p>"){
				alert("내용을 입력해주세요.");
				return;
			}
			
			if(qnaRegType == "문의종류"){
				alert("문의종류를 선택해주세요.");
				return;
			}
			
			if (postType != 'q'){
				swal("게시글이 등록되었습니다.", "", "success");
			} else if (postType == 'q'){
				swal("문의가 등록되었습니다.", "근무시간 내에 답변해드립니다.", "success");
			}
			setTimeout(function() {
				$("form").attr("method" , "POST").attr("action" , "/libero/community/addPost").attr("enctype","multipart/form-data").submit();
		    }, 1500);
			
		});
		
		
		
	});
	
	 /**
	* 이미지 파일 업로드
	*/
	function sendFile(file, editor) {
		data = new FormData();
		data.append("file", file);
		
		//SweetAlert Timer 
		let timerInterval
		Swal.fire({
		  title: '미리보기 생성중...',
		  html: '',
		  timer: 5000,
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
		  }
		});
		//SweetAlert End
		
		$.ajax({
			data : data,
			type : "POST",
			url : "/libero/community/json/addPost",
			//cache: false,
			contentType : false,
			processData : false,
			success : function(data) {
            	//항상 업로드된 파일의 url이 있어야 한다.
           		$(editor).summernote('insertImage', data.url);
           		
			}
		});
	}
	 
	
</script>

</html>