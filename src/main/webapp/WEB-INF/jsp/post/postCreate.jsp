<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<div class="d-flex justify-content-center">
	<div class="w-50">
	
		<h1>글 쓰기</h1>
		
		<input type="text" id="subject" class="form-control" placeholder="제목을 입력하세요">
		<textarea id="content" class="form-control" rows="10" placeholder="내용을 입력하세요"></textarea>
		<div class="d-flex justify-content-end my-3">
			<input type="file" id="file" accept=".jpg, .jpeg, .png, .gif">
		</div>
		
		<div class="d-flex justify-content-between">		
			<button type="button" id="postListBtn" class="btn btn-dark">목록</button>			
			<div>
				<button type="button" id="clearBtn" class="btn btn-secondary">모두 지우기</button>
				<button type="button" id="saveBtn" class="btn btn-info">저장</button>
			</div>			
		</div>
		
	</div>
</div>


<script>
$(document).ready(function() {
	
	// 목록 버튼 클릭 -> 글 목록 이동
	$('#postListBtn').on('click', function() {
		location.href="/post/post_list_view";
	});
	
	// 모두 지우기 버튼
	$('#clearBtn').on('click', function() {
		if(!confirm('작성한 제목과 내용을 모두 지우시겠습니까?')){
            return false;
        }
		$('#subject').val("");
		$('#content').val("");
	});
	
	// 글 저장 버튼
	$('#saveBtn').on('click', function() {
		
		let subject = $('#subject').val().trim();
		let content = $('#content').val().trim();
		let file = $('#file').val();  // 파일 경로 ex) C:\fakepath\Part1-Day08-20230314_API_예시.ipynb
		
		// validation check
		if (!subject) {
			alert("제목을 입력하세요");
			return;
		}
		if (!content) {
			alert("내용을 입력하세요");
			return;
		}
		
		// 파일이 업로드 된 경우에만 확장자 체크
		if (file != "") {
			// C:\fakepath\Part1-Day08-20230314_API_예시.ipynb
			// 확장자만 뽑은 후 소문자로 변경한다.
			let ext = file.split(".").pop().toLowerCase();
			// alert(ext);
			
			if ($.inArray(ext, ['jpg', 'jpeg', 'png', 'gif']) == -1) {  // 요소가 없으면 -1을 반환
				alert("이미지 파일만 업로드 가능합니다.")
				$('#file').val('');  // 파일을 비운다.
				return;
			}
		}
		
		// AJAX 통신
		// 이미지를 업로드 할 때는 반드시 form 태그가 있어야 한다.
		// form 태그를 만들거나, 
		// 이렇게 한다 ↓
		let formData = new FormData();
		formData.append("subject", subject);  // key는 form 태그의 name 속성과 같고 RequestParam명이 된다.
		formData.append("content", content);
		formData.append("file", $('#file')[0].files[0]);  // 멀티 업로드도 구현해보기
		
		$.ajax({
			// request
			type: "post"
			, url: "/post/create"
			, data: formData
			, enctype: "multipart/form-data"  // 파일 업로드를 위한 필수 설정
			, processData: false  // 파일 업로드를 위한 필수 설정  무슨 뜻? JSON이 아니다!!
			, contentType: false  // 파일 업로드를 위한 필수 설정  무슨 뜻? String이 아니다!!
			
			//response
			, success: function(data) {
				if (data.code == 1) {
					alert("메모가 저장되었습니다.");
					location.href="/post/post_list_view"
				} else {
					// 로직 상 실패
					alert(data.errorMessage);
				}
			}
			
			, error:function(request, status, error) {
				alert("메모를 저장하는데 실패했습니다. 관리자에게 문의하세요.");
			}
			
		});
		
	});
	
});
</script>