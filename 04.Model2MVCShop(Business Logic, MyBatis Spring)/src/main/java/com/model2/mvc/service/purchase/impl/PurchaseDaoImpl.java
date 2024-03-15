package com.model2.mvc.service.purchase.impl;

import java.util.ArrayList;
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
	public void addPurchase(Purchase purchase) throws Exception {
		sqlSession.insert("PurchaseMapper.addPurchase", purchase);
	}


	@Override
	public Purchase getPurchase(int tranNo) throws Exception {
		return sqlSession.selectOne("PurchaseMapper.getPurchase", tranNo);
	}


	@Override
	public Purchase getPurchaseByProd(int prodNo) throws Exception {
		return sqlSession.selectOne("PurchaseMapper.getPurchaseByProd", prodNo);
	}


	@Override
	public List<Object> getPurchaseList(Search search, String userId) throws Exception {
		
		List<Object> list = new ArrayList<Object>();
		list.add(search);
		list.add(userId);
		
		return sqlSession.selectList("PurchaseMapper.getPurchaseList", list);
	}


	@Override
	public List<Object> getSaleList(Search search) throws Exception {
		return sqlSession.selectList("PurchaseMapper.getSaleList", search);
	}


	@Override
	public void updatePurchase(Purchase purchase) throws Exception {
		sqlSession.update("PurchaseMapper.updatePurchase", purchase);
	}


	@Override
	public void updateTranCode(Purchase purchase) throws Exception {
		sqlSession.update("PurchaseMapper.updateTranCode", purchase);
		
	}


	@Override
	public int getTotalCount(Search search) throws Exception {
		return sqlSession.selectOne("PurchaseMapper.getTotalCount", search);
	}


}
