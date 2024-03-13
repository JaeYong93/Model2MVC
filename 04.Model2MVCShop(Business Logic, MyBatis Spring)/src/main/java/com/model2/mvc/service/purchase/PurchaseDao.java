package com.model2.mvc.service.purchase;

import java.util.List;

import com.model2.mvc.common.Search;
import com.model2.mvc.service.domain.Product;
import com.model2.mvc.service.domain.Purchase;

public interface PurchaseDao {

	
	public Purchase findPurchase(int tranNo) throws Exception;

	public Purchase findPurchaseByProd(int prodNo) throws Exception;

	public List<Purchase> getPurchseList(Search search, String userId) throws Exception;

	public List<Purchase> getSaleList(Search search) throws Exception;
	
	public void insertPurchase(Purchase purchase) throws Exception;

	public void updatePurchase(Purchase purchase) throws Exception;

	public void updateTranCode(Purchase purchase) throws Exception;

	public int getTotalCount(Search search) throws Exception;
		
}