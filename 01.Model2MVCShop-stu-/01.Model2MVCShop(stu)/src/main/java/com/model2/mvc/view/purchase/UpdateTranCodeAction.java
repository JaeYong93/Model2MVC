package com.model2.mvc.view.purchase;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.model2.mvc.framework.Action;
import com.model2.mvc.service.purchase.PurchaseService;
import com.model2.mvc.service.purchase.impl.PurchaseServiceImpl;
import com.model2.mvc.service.purchase.vo.PurchaseVO;

public class UpdateTranCodeAction extends Action{

	@Override
	public String execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
	
		String tranCode = request.getParameter("tranCode");
		int tranNo = Integer.parseInt(request.getParameter("tranNo"));
		
		tranCode = "4";
		
		PurchaseService service = new PurchaseServiceImpl();
		
		PurchaseVO purchaseVO = service.getPurchase(tranNo);

		purchaseVO.setTranCode(tranCode);
		
		service.updateTranCode(purchaseVO);
		
		System.out.println("purchaseVO");
				
		return "redirect:/listPurchase.do";
	}

}
