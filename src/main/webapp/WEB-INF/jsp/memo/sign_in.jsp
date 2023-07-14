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
        
        <!-- 로그인 샘플 -->
        <link href="//netdna.bootstrapcdn.com/bootstrap/3.1.0/css/bootstrap.min.css" rel="stylesheet" id="bootstrap-css">
        <script src="//netdna.bootstrapcdn.com/bootstrap/3.1.0/js/bootstrap.min.js"></script>
        <script src="//code.jquery.com/jquery-1.11.1.min.js"></script>
        
        <link rel="stylesheet" type="text/css" href="./style.css">
    </head>
    <body id="wrap" class="container">

        <header>
            <div id="top" class="h2 font-weight-bold d-flex align-items-center pl-4">메모 게시판</div>
        </header>
        <section class="contents d-flex justify-content-center align-items-center">
            <div>
                <form method="post" action="" id="loginform" class="form-horizontal" role="form">
                                    
                    <div style="margin-bottom: 15px" class="input-group">
                        <span class="input-group-addon"><i class="glyphicon glyphicon-user"></i></span>
                        <input id="login-username" type="text" class="form-control" name="loginId" placeholder="ID">                                        
                    </div>
                        
                    <div style="margin-bottom: 22px" class="input-group">
                        <span class="input-group-addon"><i class="glyphicon glyphicon-lock"></i></span>
                        <input id="login-password" type="password" class="form-control" name="password" placeholder="PASSWORD">
                    </div>

                    <input class="btn btn-primary d-block w-100" type="submit" value="로그인">
                    <a href="" class="btn btn-secondary d-block w-100 mt-3">회원가입</a>
                </form>
            </div>
        </section>
        <footer>
            <div id="bottom" class="font-weight-bold d-flex justify-content-center align-items-center">copyright marobiana</div>
        </footer>

    </body>
</html>