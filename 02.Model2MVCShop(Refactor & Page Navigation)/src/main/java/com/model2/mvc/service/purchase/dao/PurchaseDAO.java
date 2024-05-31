package com.model2.mvc.service.purchase.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpSession;

import com.model2.mvc.common.Search;
import com.model2.mvc.common.util.DBUtil;
import com.model2.mvc.service.domain.Purchase;
import com.model2.mvc.service.domain.Product;
import com.model2.mvc.service.domain.User;

public class PurchaseDAO {

	public PurchaseDAO() {
		
	}
	
	public Purchase findPurchase(int tranNo) throws Exception {
		
		Connection con = DBUtil.getConnection();
		
		String sql = "SELECT * FROM TRANSACTION WHERE tran_no = ?";
		
		PreparedStatement pStmt = con.prepareStatement(sql);
		pStmt.setInt(1, tranNo);
		
		ResultSet rs = pStmt.executeQuery();
		
		Purchase purchase = null;
		Product product = new Product();
		User user = new User();
		
		while(rs.next()) {
		
			purchase = new Purchase();
			
			purchase.setTranNo(rs.getInt("tran_no"));			
			product.setProdNo(rs.getInt("prod_no"));
			user.setUserId(rs.getString("buyer_id"));
			purchase.setPurchaseProd(product);
			purchase.setBuyer(user);
			purchase.setDlvyAddr(rs.getString("demailaddr"));
			purchase.setDlvyDate(rs.getString("dlvy_date"));
			purchase.setDlvyRequest(rs.getString("dlvy_request"));
			purchase.setOrderDate(rs.getDate("order_data"));
			purchase.setPaymentOption(rs.getString("payment_option"));
			purchase.setReceiverName(rs.getString("receiver_name"));
			purchase.setReceiverPhone(rs.getString("receiver_phone"));
			purchase.setTranCode(rs.getString("tran_status_code"));

		}	
		con.close();
		return purchase;
	}	
	public Purchase findPurchaseByProd(int prodNo) throws Exception {

		Connection con = DBUtil.getConnection();
			
		String sql = "SELECT tran_no, tran_status_code FROM TRANSACTION WHERE prod_no = ?";
			
		PreparedStatement pStmt = con.prepareStatement(sql);
		pStmt.setInt(1, prodNo);
			
		ResultSet rs = pStmt.executeQuery();
			
		Purchase purchase = null;
		Product product = new Product();
		User user = new User();
			
		while(rs.next()) {
			
			purchase = new Purchase();
				
			purchase.setTranNo(rs.getInt("tran_no"));
			purchase.setTranCode(rs.getString("tran_status_code"));

		}	
		con.close();
		return purchase;			
	}
	
	public Map<String, Object> getPurchaseList(Search search, String userId) throws Exception{
		
		Map<String,Object> map = new HashMap<String,Object>();		
		
		Connection con = DBUtil.getConnection();
		
		String sql = "SELECT * FROM TRANSACTION ORDER BY order_data";

		System.out.println("Purchase DAO sql : "+sql);
		
		int totalCount = this.getTotalCount(sql);
		System.out.println("Purchase DAO totalCount : " + totalCount);
		
		sql = makeCurrentPageSql(sql, search);
		PreparedStatement pStmt = con.prepareStatement(sql);
		ResultSet rs = pStmt.executeQuery();

		System.out.println(search);
		
		List<Purchase> list = new ArrayList<Purchase>();
		
		while(rs.next()) {
		
			Purchase purchase = new Purchase();
			Product product = new Product();
			User user = new User();
				
			product.setProdNo(rs.getInt("prod_no"));
			user.setUserId(rs.getString("buyer_id"));
			user.setUserName(rs.getString("receiver_name"));

			purchase.setPurchaseProd(product);
			purchase.setBuyer(user);
			purchase.setTranNo(rs.getInt("tran_no"));
			purchase.setPaymentOption(rs.getString("payment_option"));
			purchase.setReceiverName(rs.getString("receiver_name"));
			purchase.setReceiverPhone(rs.getString("receiver_phone"));
			purchase.setDlvyAddr(rs.getString("demailaddr"));
			purchase.setDlvyRequest(rs.getString("dlvy_request"));
			purchase.setDlvyDate(rs.getString("dlvy_date"));
			purchase.setTranCode(rs.getString("tran_status_code"));
			purchase.setOrderDate(rs.getDate("order_data"));
				
			list.add(purchase);
		}
		
		map.put("totalCount", new Integer(totalCount));
		
		map.put("list", list);

		rs.close();
		pStmt.close();
		con.close();
		
		return map;
	}
	
	public Map<String, Object> getSaleList(Search search) throws Exception{

		Map<String,Object> map = new HashMap<String,Object>();
		
		Connection con = DBUtil.getConnection();
		
		String sql = "SELECT * FROM TRANSACTION ORDER BY order_date";
		System.out.println("Purchase DAO sql : "+sql);
		
		int totalCount = this.getTotalCount(sql);
		System.out.println("Purchase DAO totalCount : " + totalCount);
		
		sql = makeCurrentPageSql(sql, search);
		PreparedStatement pStmt = con.prepareStatement(sql);
		ResultSet rs = pStmt.executeQuery();

		System.out.println(search);
		
		List<Purchase> list = new ArrayList<Purchase>();
		
		while(rs.next()) {
	
			Purchase purchase = new Purchase();
			Product product = new Product();
			User user = new User();
							
			//productVO.setProdNo(productVO.getProdNo());
			//userVO.setUserId(userVO.getUserId());
			purchase.setTranNo(rs.getInt("tran_no"));
			purchase.setPaymentOption(rs.getString("payment_option"));
			purchase.setReceiverName(rs.getString("receiver_name"));
			purchase.setReceiverPhone(rs.getString("receiver_phone"));
			purchase.setDlvyAddr(rs.getString("demailaddr"));
			purchase.setDlvyRequest(rs.getString("dlvy_request"));
			purchase.setDlvyDate(rs.getString("dlvy_date"));
				
			list.add(purchase);
		}
		map.put("totalCount", new Integer(totalCount));
		
		map.put("list", list);

		rs.close();
		pStmt.close();
		con.close();
		
		return map;
		
	}
	
	public void insertPurchase(Purchase purchase) throws Exception{
	
		Connection con = DBUtil.getConnection();
		
		String sql = "INSERT INTO TRANSACTION values(seq_transaction_tran_no.nextval, ?, ?, ?, ?, ?, ?, ?, 2, SYSDATE, ?)";
		PreparedStatement pStmt = con.prepareStatement(sql);
			
		pStmt.setInt(1, purchase.getPurchaseProd().getProdNo());
		pStmt.setString(2, purchase.getBuyer().getUserId());
		pStmt.setString(3, purchase.getPaymentOption());
		pStmt.setString(4, purchase.getReceiverName());
		pStmt.setString(5, purchase.getReceiverPhone());
		pStmt.setString(6, purchase.getDlvyAddr());
		pStmt.setString(7, purchase.getDlvyRequest());
		pStmt.setString(8, purchase.getDlvyDate());
		
		pStmt.executeUpdate();
		
		con.close();
	}
	
	public void updatePurchase(Purchase purchase) throws Exception{
		
		Connection con = DBUtil.getConnection();
		
		String sql = "UPDATE TRANSACTION SET payment_option = ?, receiver_name = ?, receiver_phone = ?, "
				+ "demailaddr = ?, dlvy_request = ?, dlvy_date = ? WHERE tran_no = ?";
		
		PreparedStatement pStmt = con.prepareStatement(sql);

		pStmt.setString(1, purchase.getPaymentOption());
		pStmt.setString(2, purchase.getReceiverName());
		pStmt.setString(3, purchase.getReceiverPhone());
		pStmt.setString(4, purchase.getDlvyAddr());
		pStmt.setString(5, purchase.getDlvyRequest());
		pStmt.setString(6, purchase.getDlvyDate());
		pStmt.setInt(7, purchase.getTranNo());
		pStmt.executeUpdate();
		
		con.close();
	}
	
	public void updateTranCode(Purchase purchase) throws Exception{
		
		Connection con = DBUtil.getConnection();
		
		String sql =  "UPDATE TRANSACTION SET tran_status_code = ? WHERE tran_no = ?";
		PreparedStatement pStmt = con.prepareStatement(sql);

		pStmt.setString(1, purchase.getTranCode());
		pStmt.setInt(2, purchase.getTranNo());
		
		pStmt.executeUpdate();
		con.close();		
	}
	
	private int getTotalCount(String sql) throws Exception{
		
		sql = "SELECT COUNT(*) FROM (" +sql+ ") countTable";
		
		Connection con = DBUtil.getConnection();
		PreparedStatement pStmt = con.prepareStatement(sql);
		ResultSet rs = pStmt.executeQuery();
		
		int totalCount = 0;
		if(rs.next()) {
			totalCount = rs.getInt(1);	
		}
		
		pStmt.close();
		con.close();
		rs.close();
		
		return totalCount;
		
	}
	
	private String makeCurrentPageSql(String sql , Search search){
		sql = "SELECT * FROM (SELECT inner_table. * , ROWNUM AS row_seq " +
								"FROM( "+sql+" ) inner_table "+
								"WHERE ROWNUM <="+search.getCurrentPage()*search.getPageSize()+" ) " +
								"WHERE row_seq BETWEEN "+((search.getCurrentPage()-1)*search.getPageSize()+1) +
								" AND "+search.getCurrentPage()*search.getPageSize();
		
		System.out.println("Purchase DAO make SQL : "+ sql);	
		
		return sql;
	}	
}
