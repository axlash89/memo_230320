<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
			<div class="d-flex justify-content-center align-items-center mt-5">
                <form method="post" action="">
                    
                    <table class="table">
                        <tr>
                            <th class="left-side text-center pt-4">
                                * 아이디
                            </th>
                            <td class="right-side">
                                <div class="d-flex">
                                    <input type="text" class="form-control col-8 ml-2" name="loginId" id="loginId" placeholder="아이디 입력">
                                    <input type="button" class="btn btn-info ml-3" id="duplicatedIdCheck" value="중복확인">
                                </div>
                                <div>
                                    <%-- 아이디 체크 결과 --%>
									<%-- d-none 클래스: display none (보이지 않게) --%>
									<div id="idCheckLength" class="small text-danger d-none">ID를 4자 이상 입력해주세요.</div>
									<div id="idCheckDuplicated" class="small text-danger d-none">이미 사용중인 ID입니다.</div>
									<div id="idCheckOk" class="small text-success d-none">사용 가능한 ID 입니다.</div>
                                </div>
                            </td>
                        </tr>
                        <tr>
                            <th class="left-side text-center pt-4">
                                * 비밀번호
                            </th>
                            <td class="right-side">
                                <input type="password" class="form-control col-8 ml-2" name="password" placeholder="비밀번호 입력">
                            </td>
                        </tr>
                        <tr>
                            <th class="left-side text-center pt-4">
                                * 비밀번호 확인
                            </th>
                            <td class="right-side">
                                <input type="password" class="form-control col-8 ml-2" id="passwordCheck" placeholder="비밀번호 입력">
                            </td>
                        </tr>
                        <tr>
                            <th class="left-side text-center pt-4">
                                * 이름
                            </th>
                            <td class="right-side">
                                <input type="text" class="form-control col-8 ml-2" name="name" placeholder="이름 입력">
                            </td>
                        </tr>
                        <tr>
                            <th class="left-side text-center pt-4">
                                * 이메일주소
                            </th>
                            <td class="right-side">
                                <input type="text" class="form-control col-8 ml-2" name="email" placeholder="이메일 주소 입력">
                            </td>
                        </tr>
                    </table>
                    <div class="d-flex justify-content-center">
                        <input type="submit" class="btn btn-primary col-4" value="회원가입">
                    </div>
                </form>
            </div>
            
            <script>
            	$(document).ready(function() {
            		
            		$('#duplicatedIdCheck').on('click', function() {
            			// alert("클릭");
            			
            			let loginId = $('#loginId').val().trim();
            			
            			// 경고 문구 초기화
            			$('#idCheckLength').addClass('d-none');
            			$('#idCheckDuplicated').addClass('d-none');
            			$('#idCheckOk').addClass('d-none');
            			
            			if (loginId.length < 4) {
            				$('#idCheckLength').removeClass('d-none');
            				return;
            			}
            			
            			
            			$.ajax({
            				// request
            				url:"/user/is_duplicated_id"
            				, data: {"loginId":loginId}
            				, success: function(data) {
            					if(data.isDuplicatedId) {
            						// 중복일 때
            						$('#idCheckDuplicated').removeClass('d-none');
            					} else {	
            						// 중복이 아닐 때 => 사용 가능
            						$('#idCheckOk').removeClass('d-none');
            					}
            				}
            				// response
                    		, error: function(request, status, error) {
                    			alert("중복확인에 실패했습니다.");
                    		}            				
                		});
            			
            		});           
            		
            	});
            </script>