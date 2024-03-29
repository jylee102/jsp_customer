/* regist.jsp */

// 고객 정보 등록 전 체크
function chkForm() {
	var f = document.frm;

	if (f.name.value == '') {
		alert("이름을 입력해주세요.");
		return false;
	}

	if (f.phone.value == '') {
		alert("전화번호를 입력해주세요.");
		return false;
	} else {
		const reg = /^\d{2,3}-\d{3,4}-\d{4}$/;
		if (!reg.test(f.phone.value)) {
			alert("전화번호 형식이 맞지 않습니다.");
			return false;
		}
	}

	if (f.age.value == '') {
		alert("나이를 입력해주세요.");
		return false;
	}

	if (f.point.value == '') {
		if (!confirm("포인트를 입력하지 않으면 0점으로 등록됩니다. 계속하시겠습니까?"))
			return false;
	}

	f.submit(); // 서버로 폼태그 안의 데이터 전송
}

/* edit.jsp */

// 정보 수정할 때 선택한 이미지 미리보기
function previewSelectedImage() {
	const file = $('#file').prop('files')[0];
	if (file) {
		const reader = new FileReader();
		reader.readAsDataURL(file);
		reader.onload = function(e) {
			$('#previewImage').attr("src", e.target.result);
		}
	}
}


/* delete.jsp */

function openModal(id) {
	$.ajax({
		url: 'detail?id=' + id,
		type: 'GET',
		success: function(response) {
			$('.modal-body').append($(response).find('.profile-img').prop('outerHTML'));
			$('.modal-body').append($(response).find('.detail').prop('outerHTML'));
			$('#delete-btn').attr("onclick", "deleteModalData(); deleteCustomer(" + id + ");")
			$('#modal').modal('show');
		},
		error: function(xhr, status, error) {
			console.error(xhr.responseText);
		}
	});
}

function deleteModalData() {
	$('.modal-body').empty();
}

function deleteCustomer(id) {
	const url = location.origin;
	location.href = url + "/jsp_customer/delete?id=" + id;
}


// 롱 클릭 이벤트
function onLongClick($target, duration, callback) {
	$($target).on('mousedown', () => {
		const timer = setTimeout(() => {
			callback($target);
		}, duration);

		$($target).on('mouseup', () => {
			clearTimeout(timer);
		});
	});
}

function deleteMany($target) {
	if ($('caption a:visible').text() === '돌아가기') {

		$('.del2').css('display', 'block');
		$('.del2_table').css('display', 'table');
		$('.del2_cell').css('display', 'table-cell');
		$('.del2_a').css('display', 'inline-block');
		$('.del1').css('display', 'none');

		$('.longclick-row').each(function(index, item) {
			$(this).addClass('.clickable-row');
			$(this).attr('onclick', 'toggleCheckbox(' + Number.parseInt($(this).find('#id').text()) + '); return false;');
		});
	}
}

window.onload = () => {
	const targetList = document.querySelectorAll('.longclick-row');
	targetList.forEach(($target) => {
		// 테이블의 행을 길게 누르면 고객 여러 명 삭제할 수 있도록
		onLongClick($target, 500, deleteMany);
	});
};

function toggleCheckbox(id) {
	if ($('input[value=' + id + ']').prop("checked") == false)
		$('input[value=' + id + ']').prop("checked", true);
	else $('input[value=' + id + ']').prop("checked", false);
}

function deleteCustomers() {
	let ids = [];

	$("input:checked").each(function() {
		ids.push($(this).val());
	});

	if (ids.length == 0) {
		alert("선택된 항목이 없습니다.");
		return false;
	} else if (ids.length == 1) {
		openModal(ids[0]);
		return false;
	} else {
		const pw = prompt("비밀번호를 입력하세요");
		
		if (!pw) {
			return false;
		} else if (pw != "root1234") {
			alert("비밀번호가 틀렸습니다.");
			return false;
		} else {
			const url = location.origin;
			location.href = url + "/jsp_customer/deleteMany?ids=" + ids;
		}
	}
}
