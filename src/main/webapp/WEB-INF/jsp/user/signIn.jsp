<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<div id="loginBox" class="d-flex justify-content-center align-items-center">
	<div>
		<form method="post" action="/user/sign_in" id="loginForm" class="form-horizontal" role="form">
			<div style="margin-bottom: 15px" class="input-group">
				<span class="input-group-addon"><i class="glyphicon glyphicon-user"></i></span> 
				<input id="loginId" type="text" class="form-control" name="loginId" placeholder="아이디">
			</div>

			<div style="margin-bottom: 22px" class="input-group">
				<span class="input-group-addon"><i class="glyphicon glyphicon-lock"></i></span> 
				<input id="password" type="password" class="form-control" name="password" placeholder="비밀번호">
			</div>

			<input class="btn btn-primary d-block w-100" type="submit" value="로그인"> 
			<a href="/user/sign_up_view" class="btn btn-secondary d-block w-100 mt-3">회원가입</a>
		</form>
	</div>
</div>

<script>

$(document).ready(function() {
	
	// 로그인
	$('#loginForm').on('submit', function(e) {
		e.preventDefault();  // form submit 중단
		
		let loginId = $('#loginId').val().trim();
		let password = $('#password').val();
		
		if (!loginId) {
			alert("아이디를 입력하세요");
			return false;
		}
		
		if (!password) {
			alert("비밀번호를 입력하세요");
			return false;
		}
		
		let url = $(this).attr('action');
		let params = $(this).serialize();  // name 속성 반드시 있어야 한다.
		
		$.post(url, params)	 // request
		.done(function(data) {
			if(data.code == 1) {
				// 성공
				location.href = "/post/post_list_view";  // 글 목록으로 이동
			} else {
				// 로직 실패
				alert(data.errorMessage);
			}			
		});
		
	});
	
});	
	
</script>