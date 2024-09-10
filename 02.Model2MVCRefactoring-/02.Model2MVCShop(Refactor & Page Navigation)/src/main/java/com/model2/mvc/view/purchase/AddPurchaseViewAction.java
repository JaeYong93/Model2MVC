package com.model2.mvc.view.purchase;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.model2.mvc.framework.Action;
import com.model2.mvc.service.purchase.PurchaseService;
import com.model2.mvc.service.purchase.impl.PurchaseServiceImpl;
import com.model2.mvc.service.product.ProductService;
import com.model2.mvc.service.product.impl.ProductServiceImpl;
import com.model2.mvc.service.user.UserService;
import com.model2.mvc.service.domain.Purchase;
import com.model2.mvc.service.domain.Product;
import com.model2.mvc.service.domain.User;

public class AddPurchaseViewAction extends Action {


	@Override
	public String execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
		
		int prodNo = Integer.parseInt(request.getParameter("prodNo"));
	
		HttpSession session = request.getSession();
		User user = (User)session.getAttribute("user");
		
		if(user == null) {
			return "forward:/user/loginView.jsp";
		}
		
		String userId = user.getUserId();
		
		PurchaseService purchaseService = new PurchaseServiceImpl();
		Purchase purchase = purchaseService.getPurchase(prodNo);
		
		ProductService prodService = new ProductServiceImpl();
		Product product = prodService.getProduct(prodNo);
		
		request.setAttribute("purchase", purchase);
		request.setAttribute("product", product);
		request.setAttribute("user", user);
		
		System.out.println(prodNo);
		System.out.println(userId);
		System.out.println(purchase);
		System.out.println(product);
		
		return "forward:/purchase/addPurchaseView.jsp";
	}


}
