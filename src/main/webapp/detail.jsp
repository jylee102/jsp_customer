<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<!-- 부트스트랩 -->
<link
	href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css"
	rel="stylesheet"
	integrity="sha384-T3c6CoIi6uLrA9TneNEoa7RxnatzjcDSCmG1MXxSR1GAsXEV/Dwwykc2MPK8M2HN"
	crossorigin="anonymous" />
<link rel="stylesheet" href="./css/style.css">
</head>
<body>
	<div class="container wrap">
		<div class="profile card">
			<div class="row">
				<div class="col-md-4">
					<div class="profile-img">
						<img src="${customer.img}" alt="프로필 사진" />
					</div>
				</div>

				<div class="col-md-4 main_info">
					<div class="profile-head">
						<div>
							<h5>${customer.name}</h5>
							<h6>${customer.phone}</h6>
						</div>
						<div class="point">
							<p>
								포인트 : <span>${customer.point}</span>점
							</p>
							<p>
								등급 : <span>${customer.grade}</span><i class="fa-solid fa-crown"></i>
							</p>
						</div>
					</div>
				</div>

				<div class="col-md-4"
					style="display: flex; justify-content: center;">
					<a class="profile-edit-btn" href="edit?id=${customer.id}">정보
						수정하기</a>
				</div>
			</div>

			<hr>

			<div class="row info">
				<div class="col-md-4">
					<h5>Detail</h5>
				</div>
				<div class="col-md-8 detail">
					<div class="row">
						<h5></h5>
						<div class="col-md-4">
							<label>이름</label>
						</div>
						<div class="col-md-8">
							<p>${customer.name}</p>
						</div>
					</div>
					<div class="row">
						<div class="col-md-4">
							<label>주소</label>
						</div>
						<div class="col-md-8">
							<p>${customer.address}</p>
						</div>
					</div>
					<div class="row">
						<div class="col-md-4">
							<label>전화번호</label>
						</div>
						<div class="col-md-8">
							<p>${customer.phone}</p>
						</div>
					</div>
					<div class="row">
						<div class="col-md-4">
							<label>성별</label>
						</div>
						<div class="col-md-8">
							<p>${customer.gender}성</p>
						</div>
					</div>
					<div class="row">
						<div class="col-md-4">
							<label>나이</label>
						</div>
						<div class="col-md-8">
							<p>${customer.age}세</p>
						</div>
					</div>
					<div class="row">
						<div class="col-md-4">
							<label>포인트</label>
						</div>
						<div class="col-md-8">
							<p>${customer.point}점</p>
						</div>
					</div>
					<div class="row">
						<div class="col-md-4">
							<label>등급</label>
						</div>
						<div class="col-md-8">
							<p>${customer.grade}</p>
						</div>
					</div>
				</div>
			</div>
		</div>

		<div class="bt_wrap">
			<a class="on" href="index">목록으로</a>
		</div>

	</div>

	<!-- jquery -->
	<script src="https://code.jquery.com/jquery-3.7.1.min.js"
		integrity="sha256-/JqT3SQfawRcv/BIHPThkBvs0OEvtFFmqPF/lYI/Cxo="
		crossorigin="anonymous"></script>

	<!-- 부트스트랩 JS -->
	<script
		src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"
		integrity="sha384-C6RzsynM9kWDrMNeT87bh95OGNyZPhcTNXj1NW7RuBCsyN/o0jlpcV8Qyq46cDfL"
		crossorigin="anonymous"></script>

	<script>
		// request 객체에 error가 있을 경우 에러메시지 출력
		<c:if test="${error != null}">
			alert("${error}");
		</c:if>
		
		// 쿼리스트링에 error가 있을 경우 에러메시지 출력(request 객체에 포함되므로)
		<c:if test="${param.error != null}">
			alert("${param.error}");
		</c:if>
		
		$('')
	</script>
	<script type="text/javascript" src="./js/script.js"></script>
</body>
</html>