<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<div id="signUpBox" class="d-flex justify-content-center align-items-center">

	<form id="signUpForm" method="post" action="/user/sign_up">

		<table class="table">
			<tr>
				<th class="left-side text-center pt-4">* 아이디</th>
				<td class="right-side">
					<div class="d-flex">
						<input type="text" class="form-control col-8 ml-2" name="loginId" id="loginId" placeholder="아이디 입력"> 
						<input type="button" class="btn btn-info ml-3" id="duplicatedIdCheckBtn" value="중복확인">
					</div>
					<div class="pt-1">					
						<div id="msgSpace" class="small">&nbsp;</div>
						<%-- 아이디 체크 결과 --%>
						<%-- d-none 클래스: display none (보이지 않게) --%>
						<div id="msgWrongIdLength" class="small text-danger d-none ml-3">ID를 4자 이상 입력해주세요.</div>
						<div id="msgAlreadyUsedId" class="small text-danger d-none ml-3">이미 사용중인 ID입니다.</div>
						<div id="msgUsableId" class="small text-success d-none ml-3">사용 가능한 ID 입니다.</div>
					</div>
				</td>
			</tr>
			<tr>
				<th class="left-side text-center pt-4">* 비밀번호</th>
				<td class="right-side"><input type="password" class="form-control col-8 ml-2" name="password" placeholder="비밀번호 입력"></td>
			</tr>
			<tr>
				<th class="left-side text-center pt-4">* 비밀번호 확인</th>
				<td class="right-side"><input type="password" class="form-control col-8 ml-2" id="confirmPassword" placeholder="비밀번호 입력"></td>
			</tr>
			<tr>
				<th class="left-side text-center pt-4">* 이름</th>
				<td class="right-side"><input type="text" class="form-control col-8 ml-2" name="name" placeholder="이름 입력">
				</td>
			</tr>
			<tr>
				<th class="left-side text-center pt-4">* 이메일주소</th>
				<td class="right-side"><input type="text" class="form-control col-8 ml-2" name="email" placeholder="이메일 주소 입력"></td>
			</tr>
		</table>
		
		<div class="d-flex justify-content-center">
			<input type="submit" class="btn btn-primary col-4" value="회원가입">
		</div>
		
	</form>
	
</div>

<script>
	$(document).ready(function() {

		$('#duplicatedIdCheckBtn').on('click', function() {

			let loginId = $('#loginId').val().trim();

			// 경고 문구 초기화
			$('#msgWrongIdLength').addClass('d-none');
			$('#msgAlreadyUsedId').addClass('d-none');
			$('#msgUsableId').addClass('d-none');
			$('#msgSpace').removeClass('d-none');

			if (loginId.length < 4) {
				$('#msgWrongIdLength').removeClass('d-none');
				$('#msgSpace').addClass('d-none');
				return;
			}

			$.ajax({
				
				// request
				url : "/user/is_duplicated_id"
				, data : { "loginId" : loginId }
			
				// response
				, success : function(data) {
					if (data.isDuplicatedId) {
						// 중복일 때
						$('#msgAlreadyUsedId').removeClass('d-none');
						$('#msgSpace').addClass('d-none');
					} else {
						// 중복이 아닐 때 => 사용 가능
						$('#msgUsableId').removeClass('d-none');
						$('#msgSpace').addClass('d-none');
					}
				}				
				, error : function(request, status, error) {
					alert("중복확인에 실패했습니다.");					
				}
				
			});

		});
		
		
		$('#signUpForm').on('submit', function(e) {
			e.preventDefault();  // 서브밋 기능 중단

			// validation			
			let loginId = $('input[name=loginId]').val().trim();
			let password = $('input[name=password]').val();
			let confirmPassword = $('#confirmPassword').val();
			let name = $('input[name=name]').val().trim();
			let email = $('input[name=email]').val().trim();
			
			if (!loginId) {
				alert("아이디를 입력하세요");
				return false;
			}			
			if (!password || !confirmPassword) {
				alert("비밀번호를 입력하세요");
				return false;
			}			
			if (password != confirmPassword) {
				alert("비밀번호가 일치하지 않습니다.");
				return false;
			}			
			if (!name) {
				alert("이름을 입력하세요");
				return false;
			}			
			if (!email) {
				alert("이메일을 입력하세요");
				return false;
			}
			
			
			// 아이디 중복확인 완료되었는지 확인
			if ($('#msgUsableId').hasClass('d-none')) {
				alert("아이디를 확인하세요");
				return false;
			}
			
			
			// 서버로 보내는 방법 두가지
			// 1) form submit을 자바스크립트로 진행시킴.
			// $(this)[0].submit();  // 화면 이동을 반드시 해야한다. (컨트롤러가 redirect 또는 jsp)
			
			// 2) ajax - 컨트롤러가 JSON을 리턴
			let url = $(this).attr('action');
			let params = $(this).serialize();  // 폼 태그에 있는 name 속성과 값들로 파라미터 구성
			
			$.post(url, params)  // request  
			.done(function(data) {
				
				// response
				if (data.code == 1) {
					alert("가입을 환영합니다! 로그인을 해주세요.");
					location.href = "/user/sign_in_view";  // 로그인 화면으로 이동
				} else {
					// 로직 실패
					alert(data.errorMessage);
				}
				
			});
			
		});
		

	});
</script>