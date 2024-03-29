package controller;

import java.io.IOException;
import java.io.UnsupportedEncodingException;
import java.net.URLEncoder;
import java.util.List;

import javax.servlet.ServletConfig;
import javax.servlet.ServletContext;
import javax.servlet.ServletException;
import javax.servlet.annotation.MultipartConfig;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.Part;

import org.apache.commons.beanutils.BeanUtils;

import DAO.CustomerDAO;
import DTO.Customer;

/**
 * Servlet implementation class CustomerController
 */
@WebServlet("/")
@MultipartConfig(maxFileSize = 1024 * 1024 * 50, location = "c:/Temp/profile_img")
public class CustomerController extends HttpServlet {
	private static final long serialVersionUID = 1L;

	private CustomerDAO dao;
	private ServletContext ctx;

	@Override
	public void init(ServletConfig config) throws ServletException {
		super.init(config);
		// init은 서블릿 객체 생성시 딱 한 번만 실행되므로 객체를 한 번만 생성해 공유한다.
		dao = new CustomerDAO();
		ctx = getServletContext(); // ServletContext: 웹 애플리케이션의 자원관리
	}

	@Override
	protected void service(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		request.setCharacterEncoding("UTF-8"); // request 객체 한글 깨짐 방지

		String command = request.getServletPath();
		String site = null;

		switch (command) {
		case "/index": // index.jsp로 이동
			site = getList(request);
			break;
		case "/detail": // detail.jsp로 이동
			site = getDetail(request);
			break;
		case "/regist": // regist.jsp로 이동
			site = "regist.jsp";
			break;
		case "/insert": // 게시글 등록
			site = registCustomer(request);
			break;
		case "/edit": // edit.jsp로 이동
			site = getViewForEdit(request);
			break;
		case "/update": // 게시글 수정
			site = updateInfo(request);
			break;
		case "/delete-page":
			getList(request);
			site = "delete.jsp";
			break;
		case "/delete": // 게시글 삭제
			site = deleteCustomer(request);
			break;
		case "/deleteMany":
			site = deleteCustomers(request);
			break;
		}

		/*
		 * - 공통점: 둘 다 페이지를 이동한다
		 * 
		 * - 차이점:
		 * 
		 * redirect: 객체(request, response)를 가지고 이동하지 않는다. URL의 변화 -> DB에 변화가 생기는 요청에
		 * 사용(insert, update, delete)
		 * 
		 * forward: 객체(request, response)를 가지고 이동, URL의 변화 X -> 단순 조회에 사용(select)
		 */

		// redirect:/index
		if (site.startsWith("redirect:/")) { // redirect 처리
			String rdetail = site.substring("redirect:/".length());
			response.sendRedirect(rdetail); // rdetail: /index
		} else { // forward 처리
			ctx.getRequestDispatcher("/" + site).forward(request, response);
		}
	}

	public String getList(HttpServletRequest request) {
		List<Customer> list;

		try {
			list = dao.getList();
			request.setAttribute("customerList", list);
		} catch (Exception e) {
			e.printStackTrace();
			request.setAttribute("error", "게시물 목록을 정상적으로 가져오지 못했습니다!");
		}
		return "index.jsp";
	}

	public String getDetail(HttpServletRequest request) {
		int id = Integer.parseInt(request.getParameter("id"));

		try {
			Customer c = dao.getDetail(id);
			request.setAttribute("customer", c);
		} catch (Exception e) {
			e.printStackTrace();
			request.setAttribute("error", "게시글을 정상적으로 가져오지 못했습니다!");
		}

		return "detail.jsp";
	}

	// 수정할 게시물의 기존 데이터를 가지고 와서 request 객체에 넣어준다.
	public String getViewForEdit(HttpServletRequest request) {
		int id = Integer.parseInt(request.getParameter("id"));

		try {
			Customer c = dao.getDetail(id);
			request.setAttribute("customer", c);
		} catch (Exception e) {
			e.printStackTrace();
		}

		return "edit.jsp";
	}

	// 게시글을 등록해준다.
	public String registCustomer(HttpServletRequest request) {
		Customer c = new Customer();

		try {
			BeanUtils.populate(c, request.getParameterMap());

			Part part = request.getPart("file");
			String fileName = getFilename(part); // 파일명 얻음

			// 업로드된 파일이 있는지 확인
			if (fileName != null && !fileName.isEmpty()) { // fileName이 null이 아니고 length()도 0이 아니라면
				part.write(fileName); // 서버에 파일 업로드

				c.setImg("/img/" + fileName);
			} else {
				c.setImg("/img/empty.jpg");
			}

			dao.registCustomer(c);

		} catch (Exception e) {
			e.printStackTrace();

			try {
				// 쿼리스트링의 한글깨짐을 방지하기 위해 UTF-8로 인코딩
				String encodeName = URLEncoder.encode("게시물이 정상적으로 등록되지 않았습니다!", "UTF-8");
				return "redirect:/index?error=" + encodeName;
			} catch (UnsupportedEncodingException e1) {
				e1.printStackTrace();
			}
		}

		return "redirect:/index";
	}

	// 게시글을 수정해준다.
	public String updateInfo(HttpServletRequest request) {
		Customer c = new Customer();
		String origin_file = request.getParameter("origin_file");

		try {
			BeanUtils.populate(c, request.getParameterMap());

			Part part = request.getPart("file");
			String fileName = getFilename(part);

			if (fileName != null && !fileName.isEmpty()) {
				part.write(fileName);

				c.setImg("/img/" + fileName);
			} else { // 업로드된 파일이 없을 때
				if (origin_file == null || origin_file.equals("")) {
					c.setImg("/img/empty.jpg");
				} else {
					c.setImg(origin_file);
				}
			}

			dao.updateInfo(c);

		} catch (Exception e) {
			e.printStackTrace();

			try {
				// 쿼리스트링의 한글깨짐을 방지하기 위해 UTF-8로 인코딩
				String encodeName = URLEncoder.encode("게시물이 정상적으로 수정되지 않았습니다!", "UTF-8");
				return "redirect:/detail?id=" + c.getId() + "&error=" + encodeName;
			} catch (UnsupportedEncodingException e1) {
				e1.printStackTrace();
			}
		}

		return "redirect:/detail?id=" + c.getId();
	}

	// 고객을 삭제해준다
	public String deleteCustomer(HttpServletRequest request) {
		int id = Integer.parseInt(request.getParameter("id"));

		try {
			dao.deleteCustomer(id);
		} catch (Exception e) {
			e.printStackTrace();

			try {
				// 쿼리스트링의 한글깨짐을 방지하기 위해 UTF-8로 인코딩
				String encodeName = URLEncoder.encode("게시물이 정상적으로 삭제되지 않았습니다!", "UTF-8");
				return "redirect:/index?error=" + encodeName;
			} catch (UnsupportedEncodingException e1) {
				e1.printStackTrace();
			}
		}

		return "redirect:/delete-page";
	}

	public String deleteCustomers(HttpServletRequest request) {
		String[] ids_str = request.getParameter("ids").split(",");

		for (String i : ids_str) {
			try {
				dao.deleteCustomer(Integer.parseInt(i));
			} catch (Exception e) {
				e.printStackTrace();
			}
		}

		return "redirect:/delete-page";
	}

	// 파일에서 이미지명을 추출하는 메소드
	private String getFilename(Part part) {
		String fileName = null;
		// 파일이름이 들어있는 헤더 영역을 가지고 옴
		String header = part.getHeader("content-disposition");

		// 파일 이름이 들어있는 속성부분의 시작위치(인덱스 번호)를 가지고 옴
		int start = header.indexOf("filename=");
		// 쌍따옴표 사이의 이미지명 부분만 가지고 옴
		fileName = header.substring(start + 10, header.length() - 1);

		return fileName;
	}
}
