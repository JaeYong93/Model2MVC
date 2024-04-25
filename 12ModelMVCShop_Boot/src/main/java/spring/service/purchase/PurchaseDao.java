package spring.service.purchase;


import java.util.List;

import org.apache.ibatis.annotations.Mapper;

import spring.domain.Purchase;
import spring.domain.Search;

@Mapper
public interface PurchaseDao {

	public void addPurchase(Purchase purchase) throws Exception;
	
	public Purchase getPurchase(int tranNo) throws Exception;
	
	public Purchase getPurchaseByProd(int prodNo) throws Exception;
	
	public List<Object> getPurchaseList(Search search, String userId) throws Exception;
	
	public List<Object> getSaleList(Search search) throws Exception;
	
	public void updatePurchase(Purchase purchase) throws Exception;
	
	public void updateTranCode(Purchase purchase) throws Exception;
	
	public int getTotalCount(Search search) throws Exception;	
	
}