package com.model2.mvc.service.purchase.test;

import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;

import com.model2.mvc.service.domain.Purchase;
import com.model2.mvc.service.purchase.PurchaseService;

@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration(locations = {"classpath:config/commonservice.xml"})
public class PurchaseServiceTest {

	@Autowired
	@Qualifier("purchaseServiceImpl")
	private PurchaseService purchaseService;

	//@Test
	public void testAddpurchase() throws Exception {
	
		Purchase purchase = new Purchase();
		
		purchase.getBuyer().getUserId();
		purchase.getDlvyAddr();
		purchase.getDlvyDate();
		purchase.getDlvyRequest();
		purchase.getOrderDate();
		purchase.getPaymentOption();
		purchase.getPurchaseProd().getProdNo();
		purchase.getReceiverName();
		purchase.getReceiverPhone();
		purchase.setTranCode("2");
		purchase.getTranNo();
		
		purchaseService.addPurchase(purchase);
		
		System.out.println(purchase);
	}


}
