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
	<div class="wrap">
		<table
			class="customer_list table caption-top table-hover table-striped table-light">
			<caption style="padding-bottom: 0;">
				<h1>고객 리스트</h1>
				<p style="text-align: right;"><a href="delete-page">고객삭제</a></p>
			</caption>
			<thead class="table-light">
				<tr>
					<th scope="col">번호</th>
					<th scope="col">이름</th>
					<th scope="col">포인트</th>
					<th scope="col">등급</th>
				</tr>
			</thead>
			<tbody class="table-group-divider">
				<c:forEach var="customer" items="${customerList}">
					<tr class="clickable-row" onclick="location.href='./detail?id=${customer.id}'">
						<td scope="row">${customer.id}</td>
						<td class="title">${customer.name}</td>
						<td>${customer.point}점</td>
						<td>${customer.grade}</td>
					</tr>
				</c:forEach>
			</tbody>
		</table>
		<div class="bt_wrap bt_list">
			<a class="on" href="regist">고객 등록하기</a>
		</div>
		<nav aria-label="Page navigation example">
			<ul class="pagination justify-content-center pagination-lg board_page">
				<li class="page-item"><a class="page-link" href="#"
					aria-label="Previous"> <span aria-hidden="true">&laquo;</span>
				</a></li>
				<li class="page-item"><a class="page-link" href="#">1</a></li>
				<li class="page-item"><a class="page-link" href="#">2</a></li>
				<li class="page-item"><a class="page-link" href="#">3</a></li>
				<li class="page-item"><a class="page-link" href="#">4</a></li>
				<li class="page-item"><a class="page-link" href="#">5</a></li>
				<li class="page-item"><a class="page-link" href="#"
					aria-label="Next"> <span aria-hidden="true">&raquo;</span>
				</a></li>
			</ul>
		</nav>
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
	</script>
	<script type="text/javascript" src="./js/script.js"></script>
</body>
</html>