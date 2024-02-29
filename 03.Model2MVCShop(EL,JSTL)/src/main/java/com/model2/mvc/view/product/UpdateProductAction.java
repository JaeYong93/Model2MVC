package com.model2.mvc.view.product;

import java.util.Date;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.model2.mvc.framework.Action;
import com.model2.mvc.service.product.ProductService;
import com.model2.mvc.service.product.impl.ProductServiceImpl;
import com.model2.mvc.service.domain.Product;

public class UpdateProductAction extends Action{

	@Override
	public String execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
		
		Product product = new Product();
		
		int price = Integer.parseInt(request.getParameter("price"));
		int prodNo = Integer.parseInt(request.getParameter("prodNo"));
		String menu = request.getParameter("menu");
		
		product.setProdNo(prodNo);
		
		product.setProdName(request.getParameter("prodName"));
		product.setProdDetail(request.getParameter("prodDetail"));
		product.setManuDate(request.getParameter("manuDate"));		
		product.setPrice(price);
		product.setFileName(request.getParameter("fileName"));

		ProductService service = new ProductServiceImpl();
		service.updateProduct(product);
		
		request.setAttribute("product", product);
		
		request.getParameter("menu");
		
		System.out.println(product);
		System.out.println(request.getParameter("menu"));
		
		return "forward:/getProduct.do?prodNo="+prodNo+"&menu="+menu;
	}

}