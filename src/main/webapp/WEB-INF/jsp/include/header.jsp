<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!-- 헤더 -->
<div class="d-flex justify-content-between align-items-center">
	<c:choose>
		<c:when test="${not empty userName}">
			<a href="/post/post_list_view" class="logo-text"><div class="h1 font-weight-bold pl-4">메모 게시판</div></a>
		</c:when>
		<c:otherwise>
			<a href="/user/sign_in_view" class="logo-text"><div class="h1 font-weight-bold pl-4">메모 게시판</div></a>
		</c:otherwise>
	</c:choose>
	<div>
		<div>&nbsp;</div>
		<div>&nbsp;</div>
		<div class="d-flex">
			<%-- 로그인이 된 경우에만 로그인 정보와 로그아웃 노출 --%>
			<%-- 로그인이 안 된 경우에는 로그인 링크 노출 --%>
			<c:choose>
				<c:when test="${not empty userName}">
					<div>${userName}님 안녕하세요</div>
					<div class="ml-4 mr-5"><a href="/user/sign_out">로그아웃</a></div>
				</c:when>
				<c:otherwise>
					<div class="mr-5"><a href="/user/sign_in_view">로그인</a></div>
				</c:otherwise>
			</c:choose>
		</div>		
	</div>
</div>	