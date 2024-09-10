package com.model2.mvc.view.product;

import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.model2.mvc.framework.Action;
import com.model2.mvc.service.product.ProductService;
import com.model2.mvc.service.product.impl.ProductServiceImpl;
import com.model2.mvc.service.product.vo.ProductVO;

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

	    // ���ο� ��ǰ ��ȸ ����� �߰��մϴ�.
	    if (history == null) {
	        history = String.valueOf(prodNo);
	    } else {
	        history += "|" + prodNo;
	    }

	    // ��Ű�� �����丮 ������ �����մϴ�.
	    Cookie historyCookie = new Cookie("history", history);
	    historyCookie.setMaxAge(24 * 60 * 60); // ��Ű ��ȿ �ð��� �����մϴ�. ���⼭�� �Ϸ�� �����߽��ϴ�.
	    response.addCookie(historyCookie);
		
		//���Ķ����menu�� manage��� updateproductView.do�ΰ���
		//���Ķ����menu�� search��� readProductjsp�ΰ���
		ProductService service = new ProductServiceImpl();
		ProductVO productVO = service.getProduct(prodNo);
	
		request.setAttribute("productVO", productVO);
		request.getParameter("menu");
		
		System.out.println(request.getParameter("menu"));
		System.out.println(prodNo);
		
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