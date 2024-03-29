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

<style>
.modal-body {
	display: flex;
}

.profile-img {
	width: 200px;
	height: 200px;
}

.profile-img img {
	width: 100%;
	height: 100%;
	object-fit: cover;
}

.detail {
	padding-left: 3%;
}

.del2, .del2_table, .del2_cell, .del2_a {
	display: none;
}
</style>
</head>
<body>
	<form class="wrap">
		<table
			class="customer_list table caption-top table-hover table-striped table-light">
			<caption style="padding-bottom: 0;">
				<h1>고객 리스트-삭제</h1>
				<p style="text-align: right;">
					<a href="index" class="del1">돌아가기</a> <a href="delete-page"
						class="del2_a">취소</a>
				</p>
			</caption>
			<thead class="table-light">
				<tr>
					<th scope="col" class="del2_table"></th>
					<th scope="col">번호</th>
					<th scope="col">이름</th>
					<th scope="col">포인트</th>
					<th scope="col">등급</th>
					<th scope="col" class="del1"></th>
				</tr>
			</thead>
			<tbody class="table-group-divider">
				<c:forEach var="customer" items="${customerList}">
					<tr class="longclick-row">
						<td class="del2_cell"><input type="checkbox"
							value="${customer.id}"></td>
						<td scope="row" id="id">${customer.id}</td>
						<td class="title">${customer.name}</td>
						<td>${customer.point}점</td>
						<td>${customer.grade}</td>
						<td class="del1">
							<button type="button" class="btn btn-danger"
								onclick="openModal(${customer.id}); return false;">삭제</button>
						</td>
					</tr>
					
					<div class="modal fade" id="modal" tabindex="-1"
							aria-hidden="true">
							<div class="modal-dialog">
								<div class="modal-content">
									<div class="modal-header">
										<h1 class="modal-title fs-5">정말로 삭제하시겠습니까?</h1>
										<button type="button" class="btn-close"
											data-bs-dismiss="modal" aria-label="Close"
											onclick="deleteModalData(); return false;"></button>
									</div>
									<div class="modal-body"></div>
									<div class="modal-footer">
										<button type="button" class="btn btn-secondary"
											data-bs-dismiss="modal"
											onclick="deleteModalData(); return false;">취소</button>
										<button type="button" class="btn btn-danger" id="delete-btn"
											onclick="">삭제</button>
									</div>
								</div>
							</div>
						</div>
				</c:forEach>
			</tbody>
		</table>
		<div class="bt_wrap bt_list del2">
			<a class="on del" onclick="deleteCustomers(); return false;">삭제하기</a>
		</div>
		<nav aria-label="Page navigation example">
			<ul
				class="pagination justify-content-center pagination-lg board_page">
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
	</form>

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