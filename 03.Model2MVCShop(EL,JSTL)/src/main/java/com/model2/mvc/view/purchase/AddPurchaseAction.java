package com.model2.mvc.view.purchase;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.model2.mvc.framework.Action;
import com.model2.mvc.service.purchase.PurchaseService;
import com.model2.mvc.service.purchase.impl.PurchaseServiceImpl;
import com.model2.mvc.service.domain.Purchase;
import com.model2.mvc.service.domain.User;
import com.model2.mvc.service.product.ProductService;
import com.model2.mvc.service.product.impl.ProductServiceImpl;
import com.model2.mvc.service.domain.Product;

public class AddPurchaseAction extends Action{

	@Override
	public String execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
		
		int prodNo = Integer.parseInt(request.getParameter("prodNo"));
		
		HttpSession session = request.getSession();
		User user = (User)session.getAttribute("user");
		
		Purchase purchase = new Purchase();
		
		ProductService serviceprod = new ProductServiceImpl();
		Product product = serviceprod.getProduct(prodNo);
		
		
		purchase.setPurchaseProd(product);
		purchase.setBuyer(user);
		purchase.setPaymentOption(request.getParameter("paymentOption"));
		purchase.setReceiverName(request.getParameter("receiverName"));
		purchase.setReceiverPhone(request.getParameter("receiverPhone"));
		purchase.setDlvyAddr(request.getParameter("dlvyAddr"));
		purchase.setDlvyRequest(request.getParameter("dlvyRequest"));
		purchase.setDlvyDate(request.getParameter("dlvyDate"));
		
		PurchaseService service = new PurchaseServiceImpl();
		service.addPurchase(purchase);
		
		request.setAttribute("purchase", purchase);
		
		System.out.println(purchase);
		System.out.println(product);
		System.out.println(user);
		
		return "forward:/purchase/addPurchase.jsp";
	}

}
