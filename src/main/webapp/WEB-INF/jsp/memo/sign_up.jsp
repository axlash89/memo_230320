<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <title>
            메모 게시판 로그인
        </title>
        <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@4.6.2/dist/css/bootstrap.min.css" integrity="sha384-xOolHFLEh07PJGoPkLv1IbcEPTNtaed2xpHsD9ESMhqIYd0nLMwNLD69Npy4HI+N" crossorigin="anonymous">
        <script src="https://cdn.jsdelivr.net/npm/jquery@3.5.1/dist/jquery.slim.min.js" integrity="sha384-DfXdz2htPH0lsSSs5nCTpuj/zy4C+OGpamoFVy38MVBnE+IbbVYUew+OrCXaRkfj" crossorigin="anonymous"></script>
        <script src="https://cdn.jsdelivr.net/npm/bootstrap@4.6.2/dist/js/bootstrap.bundle.min.js" integrity="sha384-Fy6S3B9q64WdZWQUiU+q4/2Lc9npb8tCaSX9FK7E8HnRr0Jz8D6OP9dO5Vg3Q9ct" crossorigin="anonymous"></script>
               
        <link rel="stylesheet" type="text/css" href="/css/memo/style.css">
    </head>
    <body id="wrap" class="container">

        <header>
            <div id="top" class="h2 font-weight-bold d-flex align-items-center pl-4">메모 게시판</div>
        </header>
        <section class="contents d-flex justify-content-center align-items-center">
            <div>
                <form method="post" action="">
                    
                    <table class="table">
                        <tr>
                            <th class="left-side text-center pt-4">
                                * 아이디
                            </th>
                            <td class="right-side">
                                <div class="d-flex">
                                    <input type="text" class="form-control col-8 ml-2" name="loginId" placeholder="아이디 입력">
                                    <input type="button" class="btn btn-info ml-3" id="duplicatedIdCheck" value="중복확인">
                                </div>
                                <div>
                                    &nbsp;
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
        </section>
        <footer>
            <div id="bottom" class="font-weight-bold d-flex justify-content-center align-items-center">copyright marobiana</div>
        </footer>

    </body>
</html>