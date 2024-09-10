package com.model2.mvc.view.purchase;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.model2.mvc.framework.Action;
import com.model2.mvc.service.purchase.PurchaseService;
import com.model2.mvc.service.purchase.impl.PurchaseServiceImpl;
import com.model2.mvc.service.purchase.vo.PurchaseVO;

public class UpdatePurchaseAction extends Action{

	@Override
	public String execute(HttpServletRequest request, HttpServletResponse response) throws Exception {

		int tranNo = Integer.parseInt(request.getParameter("tranNo"));
		
		PurchaseVO purchaseVO = new PurchaseVO();
		purchaseVO.setPaymentOption(request.getParameter("paymentOption"));
		purchaseVO.setReceiverName(request.getParameter("receiverName"));
		purchaseVO.setReceiverPhone(request.getParameter("receiverPhone"));
		purchaseVO.setDlvyAddr(request.getParameter("dlvyAddr"));
		purchaseVO.setDlvyRequest(request.getParameter("dlvyRequest"));
		purchaseVO.setDlvyDate(request.getParameter("dlvyDate"));
		purchaseVO.setTranNo(tranNo);
		
		PurchaseService service = new PurchaseServiceImpl();
		service.updatePurchase(purchaseVO);
		
		return "forward:/getPurchase.do?tranNo="+tranNo;
	}

}
