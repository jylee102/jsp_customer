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
		<form name="frm" method="post" action="insert"
			enctype="multipart/form-data" class="profile card">
			<div class="row info">
				<div class="col-md-4">
					<div class="profile-img">
						<img id="previewImage" src="/img/empty.jpg" alt="미리보기" class="rounded mx-auto d-block" />
						<div class="file btn btn-lg btn-primary">
							Choose Photo <input id="file" type="file" name="file" />
						</div>
					</div>
				</div>
				<div class="col-md-8 detail">
					<div class="row">
						<h5></h5>
						<div class="col-md-3">
							<label class="necessary">이름</label>
						</div>
						<div class="col-md-9">
							<input type="text" name="name" class="form-control" />
						</div>
					</div>
					<div class="row">
						<div class="col-md-3">
							<label>주소</label>
						</div>
						<div class="col-md-9">
							<input type="text" name="address" class="form-control" />
						</div>
					</div>
					<div class="row">
						<div class="col-md-3">
							<label class="necessary">전화번호</label>
						</div>
						<div class="col-md-9">
							<input type="text" name="phone" class="form-control" placeholder="000-0000-0000" />
						</div>
					</div>
					<div class="row">
						<div class="col-md-3">
							<label class="necessary">성별</label>
						</div>
						<div class="col-md-9">
							<div class="form-check form-check-inline">
								<label class="form-check-label">
									<input class="form-check-input gender" type="radio" name="gender" value="남" checked>남성
								</label>
							</div>
							<div class="form-check form-check-inline">
								<label class="form-check-label">
									<input class="form-check-input gender" type="radio" name="gender" value="여">여성
								</label>
							</div>
						</div>
					</div>
					<div class="row">
						<div class="col-md-3">
							<label class="necessary">나이</label>
						</div>
						<div class="col-md-9">
							<input type="text" name="age" class="form-control" />
						</div>
					</div>
					<div class="row">
						<div class="col-md-3">
							<label>포인트</label>
						</div>
						<div class="col-md-9">
							<input type="text" name="point" class="form-control" />
						</div>
					</div>
					<div class="row">
						<div class="col-md-3">
							<label>등급</label>
						</div>
						<div class="col-md-9">
							<select name="grade" id="grade" class="form-select">
								<option value="silver" selected>silver</option>
								<option value="gold">gold</option>
								<option value="vip">vip</option>
							</select>
						</div>
					</div>
				</div>
			</div>

			<div class="bt_wrap">
				<a onclick="chkForm(); return false;" class="on">등록</a> <a
					href="index">취소</a>
			</div>
		</form>
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

	<script type="text/javascript" src="./js/script.js"></script>
	<script>
		// request 객체에 error가 있을 경우 에러메시지 출력
		<c:if test="${error != null}">
			alert("${error}");
		</c:if>
		
		// 쿼리스트링에 error가 있을 경우 에러메시지 출력(request 객체에 포함되므로)
		<c:if test="${param.error != null}">
			alert("${param.error}");
		</c:if>
		
		// 이미지 미리보기
	    $('#file').on('change', previewSelectedImage);
		
	</script>
</body>
</html>