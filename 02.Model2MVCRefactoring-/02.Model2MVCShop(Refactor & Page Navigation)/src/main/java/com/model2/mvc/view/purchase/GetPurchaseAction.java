package com.model2.mvc.view.purchase;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.model2.mvc.framework.Action;
import com.model2.mvc.service.purchase.PurchaseService;
import com.model2.mvc.service.purchase.impl.PurchaseServiceImpl;
import com.model2.mvc.service.domain.Purchase;


public class GetPurchaseAction extends Action{

	@Override
	public String execute(HttpServletRequest request, HttpServletResponse response) throws Exception {

		int tranNo = Integer.parseInt(request.getParameter("tranNo"));
		//int prodNo = Integer.parseInt(request.getParameter("prodNo"));
		
		PurchaseService service = new PurchaseServiceImpl();
		Purchase purchase = service.getPurchase(tranNo);
	
		request.setAttribute("purchase", purchase);

		System.out.println(tranNo);
		System.out.println(purchase);
		
		
		return "forward:/purchase/getPurchase.jsp";
	}

}
