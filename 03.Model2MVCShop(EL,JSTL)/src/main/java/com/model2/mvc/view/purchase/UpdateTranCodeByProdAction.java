package com.model2.mvc.view.purchase;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.model2.mvc.framework.Action;
import com.model2.mvc.service.purchase.PurchaseService;
import com.model2.mvc.service.purchase.impl.PurchaseServiceImpl;
import com.model2.mvc.service.domain.Purchase;

public class UpdateTranCodeByProdAction extends Action {

	@Override
	public String execute(HttpServletRequest request, HttpServletResponse response) throws Exception {

		String tranCode = request.getParameter("tranCode");
		int prodNo = Integer.parseInt(request.getParameter("prodNo"));
		
		tranCode = "3";
		
		PurchaseService service = new PurchaseServiceImpl();
		
		Purchase purchase = service.getPurchaseByProd(prodNo);
		purchase.setTranCode(tranCode);
	   
		System.out.println(purchase);
		
		service.updateTranCode(purchase);

		
		return "redirect:/listProduct.do?menu=manage";
	}

}
