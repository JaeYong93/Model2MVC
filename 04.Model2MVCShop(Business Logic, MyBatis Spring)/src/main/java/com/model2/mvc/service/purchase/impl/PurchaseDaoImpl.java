package com.model2.mvc.service.purchase.impl;

import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Repository;

import com.model2.mvc.common.Search;
import com.model2.mvc.service.domain.Purchase;
import com.model2.mvc.service.purchase.PurchaseDao;

@Repository("purchaseDaoImpl")
public class PurchaseDaoImpl implements PurchaseDao{

	@Autowired
	@Qualifier("sqlSessionTemplate")
	private SqlSession sqlSession;
	
	public void setSqlSession(SqlSession sqlSession) {
		this.sqlSession = sqlSession;
	}
	
	
	public PurchaseDaoImpl() {
		System.out.println(this.getClass());
	}

	@Override
	public Purchase findPurchase(int tranNo) throws Exception {

		return null;
	}

	@Override
	public Purchase findPurchaseByProd(int prodNo) throws Exception {

		return null;
	}

	@Override
	public List<Purchase> getPurchseList(Search search, String userId) throws Exception {

		return null;
	}

	@Override
	public List<Purchase> getSaleList(Search search) throws Exception {

		return null;
	}

	@Override
	public void insertPurchase(Purchase purchase) throws Exception {

		
	}

	@Override
	public void updatePurchase(Purchase purchase) throws Exception {

		
	}

	@Override
	public void updateTranCode(Purchase purchase) throws Exception {

		
	}

	@Override
	public int getTotalCount(Search search) throws Exception {
		// TODO Auto-generated method stub
		return 0;
	}

}
