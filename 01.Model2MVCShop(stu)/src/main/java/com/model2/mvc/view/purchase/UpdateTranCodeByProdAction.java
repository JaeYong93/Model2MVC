package com.model2.mvc.view.purchase;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.model2.mvc.framework.Action;
import com.model2.mvc.service.purchase.PurchaseService;
import com.model2.mvc.service.purchase.impl.PurchaseServiceImpl;
import com.model2.mvc.service.purchase.vo.PurchaseVO;

public class UpdateTranCodeByProdAction extends Action {

	@Override
	public String execute(HttpServletRequest request, HttpServletResponse response) throws Exception {

		String tranCode = request.getParameter("tranCode");
		//int tranNo = Integer.parseInt(request.getParameter("tranNo"));
		int prodNo = Integer.parseInt(request.getParameter("prodNo"));
		
		System.out.println(tranCode);
		//System.out.println(tranNo);
		
		tranCode = "3";
		
		PurchaseService service = new PurchaseServiceImpl();
		
		//PurchaseVO purchaseVO = service.getPurchase(tranNo);
		
		PurchaseVO purchaseVO = service.getPurchaseByProd(prodNo);
		purchaseVO.setTranCode(tranCode);
	   
		System.out.println(purchaseVO);
		
		service.updateTranCode(purchaseVO);

		
		return "redirect:/listProduct.do?menu=manage";
	}

}
