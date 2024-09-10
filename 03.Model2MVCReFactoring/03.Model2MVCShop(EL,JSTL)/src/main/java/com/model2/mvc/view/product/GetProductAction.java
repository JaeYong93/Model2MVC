package com.model2.mvc.view.product;

import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.model2.mvc.framework.Action;
import com.model2.mvc.service.product.ProductService;
import com.model2.mvc.service.product.impl.ProductServiceImpl;
import com.model2.mvc.service.domain.Product;

public class GetProductAction extends Action {

	@Override
	public String execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
	
		int prodNo = Integer.parseInt(request.getParameter("prodNo"));

	    Cookie[] cookies = request.getCookies();
	    String history = null;
	    if (cookies != null) {
	        for (Cookie cookie : cookies) {
	            if (cookie.getName().equals("history")) {
	                history = cookie.getValue();
	                break;
	            }
	        }
	    }

	    // 새로운 상품 조회 기록을 추가합니다.
	    if (history == null) {
	        history = String.valueOf(prodNo);
	    } else {
	        history += "|" + prodNo;
	    }		

	    // 쿠키에 히스토리 정보를 저장합니다.
	    Cookie historyCookie = new Cookie("history", history);
	    historyCookie.setMaxAge(24 * 60 * 60); // 쿠키 유효 시간을 설정합니다. 여기서는 하루로 설정했습니다.
	    response.addCookie(historyCookie);
		
		//겟파라미터menu가 manage라면 updateproductView.do 로가고
		//겟파라미터menu가 search라면 readProductjsp로간다
		ProductService service = new ProductServiceImpl();
		Product product = service.getProduct(prodNo);
	
		request.setAttribute("product", product);
		request.getParameter("menu");
		
		System.out.println(request.getParameter("menu"));
		
		if(request.getParameter("menu")!=null) {
			if(request.getParameter("menu").equals("manage")) {
				return "forward:/updateProductView.do";
				
			}else if(request.getParameter("menu").equals("search")){
				return "forward:/product/readProduct.jsp";
			}
		}
		return "forward:/product/readProduct.jsp";
	}

}