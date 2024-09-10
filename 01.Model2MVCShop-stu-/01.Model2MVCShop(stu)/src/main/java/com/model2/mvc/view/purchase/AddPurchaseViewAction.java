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
import com.model2.mvc.service.purchase.vo.PurchaseVO;
import com.model2.mvc.service.product.vo.ProductVO;
import com.model2.mvc.service.user.vo.UserVO;

public class AddPurchaseViewAction extends Action {


	@Override
	public String execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
		
		int prodNo = Integer.parseInt(request.getParameter("prodNo"));
	
		HttpSession session = request.getSession();
		UserVO userVO = (UserVO)session.getAttribute("user");
		
		if(userVO == null) {
			return "forward:/user/loginView.jsp";
		}
		
		String userId = userVO.getUserId();
		
		PurchaseService purchaseService = new PurchaseServiceImpl();
		PurchaseVO purchaseVO = purchaseService.getPurchase(prodNo);
		
		ProductService prodService = new ProductServiceImpl();
		ProductVO productVO = prodService.getProduct(prodNo);
		
		request.setAttribute("purchaseVO", purchaseVO);
		request.setAttribute("productVO", productVO);
		request.setAttribute("userVO", userVO);
		
		System.out.println(prodNo);
		System.out.println(userId);
		System.out.println(purchaseVO);
		System.out.println(productVO);
		
		return "forward:/purchase/addPurchaseView.jsp";
	}


}
