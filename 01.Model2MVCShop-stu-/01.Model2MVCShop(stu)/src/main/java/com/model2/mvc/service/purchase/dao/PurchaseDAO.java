package com.model2.mvc.service.purchase.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.HashMap;

import javax.servlet.http.HttpSession;

import com.model2.mvc.common.SearchVO;
import com.model2.mvc.common.util.DBUtil;
import com.model2.mvc.service.purchase.vo.PurchaseVO;
import com.model2.mvc.service.product.vo.ProductVO;
import com.model2.mvc.service.user.vo.UserVO;

public class PurchaseDAO {

	public PurchaseDAO() {
		
	}
	
	public PurchaseVO findPurchase(int tranNo) throws Exception {
		
		Connection con = DBUtil.getConnection();
		
		String sql = "SELECT * FROM TRANSACTION WHERE tran_no = ?";
		
		PreparedStatement pStmt = con.prepareStatement(sql);
		pStmt.setInt(1, tranNo);
		
		ResultSet rs = pStmt.executeQuery();
		
		PurchaseVO purchaseVO = null;
		ProductVO productVO = new ProductVO();
		UserVO userVO = new UserVO();
		
		while(rs.next()) {
		
			purchaseVO = new PurchaseVO();
			
			purchaseVO.setTranNo(rs.getInt("tran_no"));			
			productVO.setProdNo(rs.getInt("prod_no"));
			userVO.setUserId(rs.getString("buyer_id"));
			purchaseVO.setPurchaseProd(productVO);
			purchaseVO.setBuyer(userVO);
			purchaseVO.setDlvyAddr(rs.getString("demailaddr"));
			purchaseVO.setDlvyDate(rs.getString("dlvy_date"));
			purchaseVO.setDlvyRequest(rs.getString("dlvy_request"));
			purchaseVO.setOrderDate(rs.getDate("order_data"));
			purchaseVO.setPaymentOption(rs.getString("payment_option"));
			purchaseVO.setReceiverName(rs.getString("receiver_name"));
			purchaseVO.setReceiverPhone(rs.getString("receiver_phone"));
			purchaseVO.setTranCode(rs.getString("tran_status_code"));

		}	
		con.close();
		return purchaseVO;
	}	
	public PurchaseVO findPurchaseByProd(int prodNo) throws Exception {

		Connection con = DBUtil.getConnection();
			
		String sql = "SELECT tran_no, tran_status_code FROM TRANSACTION WHERE prod_no = ?";
			
		PreparedStatement pStmt = con.prepareStatement(sql);
		pStmt.setInt(1, prodNo);
			
		ResultSet rs = pStmt.executeQuery();
			
		PurchaseVO purchaseVO = null;
		ProductVO productVO = new ProductVO();
		UserVO userVO = new UserVO();
			
		while(rs.next()) {
			
			purchaseVO = new PurchaseVO();
				
			purchaseVO.setTranNo(rs.getInt("tran_no"));
			purchaseVO.setTranCode(rs.getString("tran_status_code"));

		}	
		con.close();
		return purchaseVO;			
	}
	
	public HashMap<String, Object> getPurchaseList(SearchVO searchVO, String userId) throws Exception{
		Connection con = DBUtil.getConnection();
		
		String sql = "SELECT * FROM TRANSACTION ORDER BY order_data";

		PreparedStatement pStmt = 
			con.prepareStatement(sql, ResultSet.TYPE_SCROLL_INSENSITIVE, ResultSet.CONCUR_UPDATABLE);
		ResultSet rs = pStmt.executeQuery();

		rs.last();
		int total = rs.getRow();
		System.out.println("로우의 수:" + total);

		HashMap<String,Object> map = new HashMap<String,Object>();
		map.put("count", new Integer(total));

		rs.absolute(searchVO.getPage() * searchVO.getPageUnit() - searchVO.getPageUnit()+1);
		System.out.println("searchVO.getPage():" + searchVO.getPage());
		System.out.println("searchVO.getPageUnit():" + searchVO.getPageUnit());

		ArrayList<PurchaseVO> list = new ArrayList<PurchaseVO>();
		if (total > 0) {
			for (int i = 0; i < searchVO.getPageUnit(); i++) {
				PurchaseVO purchaseVO = new PurchaseVO();
				ProductVO productVO = new ProductVO();
				UserVO userVO = new UserVO();
				
				productVO.setProdNo(rs.getInt("prod_no"));
				userVO.setUserId(rs.getString("buyer_id"));
				userVO.setUserName(rs.getString("receiver_name"));

				purchaseVO.setPurchaseProd(productVO);
				purchaseVO.setBuyer(userVO);
				purchaseVO.setTranNo(rs.getInt("tran_no"));
				purchaseVO.setPaymentOption(rs.getString("payment_option"));
				purchaseVO.setReceiverName(rs.getString("receiver_name"));
				purchaseVO.setReceiverPhone(rs.getString("receiver_phone"));
				purchaseVO.setDlvyAddr(rs.getString("demailaddr"));
				purchaseVO.setDlvyRequest(rs.getString("dlvy_request"));
				purchaseVO.setDlvyDate(rs.getString("dlvy_date"));
				purchaseVO.setTranCode(rs.getString("tran_status_code"));
				purchaseVO.setOrderDate(rs.getDate("order_data"));
				
				list.add(purchaseVO);
				if (!rs.next())
					break;
			}
		}

		System.out.println("list.size() : "+ list.size());
		map.put("list", list);
		System.out.println("map().size() : "+ map.size());

		con.close();
		
		return map;
		
	}
	
	public HashMap<String, Object> getSaleList(SearchVO searchVO) throws Exception{
		Connection con = DBUtil.getConnection();
		
		String sql = "SELECT * FROM TRANSACTION ORDER BY order_date";
		
		PreparedStatement pStmt = 
			con.prepareStatement(sql, ResultSet.TYPE_SCROLL_INSENSITIVE, ResultSet.CONCUR_UPDATABLE);
		ResultSet rs = pStmt.executeQuery();

		rs.last();
		int total = rs.getRow();
		System.out.println("로우의 수:" + total);

		HashMap<String,Object> map = new HashMap<String,Object>();
		map.put("count", new Integer(total));

		rs.absolute(searchVO.getPage() * searchVO.getPageUnit() - searchVO.getPageUnit()+1);
		System.out.println("searchVO.getPage():" + searchVO.getPage());
		System.out.println("searchVO.getPageUnit():" + searchVO.getPageUnit());

		ArrayList<PurchaseVO> list = new ArrayList<PurchaseVO>();
		if (total > 0) {
			for (int i = 0; i < searchVO.getPageUnit(); i++) {
				PurchaseVO purchaseVO = new PurchaseVO();
							
				//productVO.setProdNo(productVO.getProdNo());
				//userVO.setUserId(userVO.getUserId());
				purchaseVO.setTranNo(rs.getInt("tran_no"));
				purchaseVO.setPaymentOption(rs.getString("payment_option"));
				purchaseVO.setReceiverName(rs.getString("receiver_name") != null ? rs.getString("receiver_name") : "null");
				purchaseVO.setReceiverPhone(rs.getString("receiver_phone") != null ? rs.getString("receiver_phone") : "null");
				purchaseVO.setDlvyAddr(rs.getString("demailaddr") != null ? rs.getString("demailaddr") : "null");
				purchaseVO.setDlvyRequest(rs.getString("dlvy_request") != null ? rs.getString("dlvy_request") : "null");
				purchaseVO.setDlvyDate(rs.getString("dlvy_date") != null ? rs.getString("dlvy_date") : "null");
				
				list.add(purchaseVO);
				if (!rs.next())
					break;
			}
		}
		System.out.println("list.size() : "+ list.size());
		map.put("list", list);
		System.out.println("map().size() : "+ map.size());

		con.close();
		
		return map;
		
	}
	
	public void insertPurchase(PurchaseVO purchaseVO) throws Exception{
	
		Connection con = DBUtil.getConnection();
		
		String sql = "INSERT INTO TRANSACTION values(seq_transaction_tran_no.nextval, ?, ?, ?, ?, ?, ?, ?, 2, SYSDATE, ?)";
		PreparedStatement pStmt = con.prepareStatement(sql);
			
		pStmt.setInt(1, purchaseVO.getPurchaseProd().getProdNo());
		pStmt.setString(2, purchaseVO.getBuyer().getUserId());
		pStmt.setString(3, purchaseVO.getPaymentOption());
		pStmt.setString(4, purchaseVO.getReceiverName());
		pStmt.setString(5, purchaseVO.getReceiverPhone());
		pStmt.setString(6, purchaseVO.getDlvyAddr());
		pStmt.setString(7, purchaseVO.getDlvyRequest());
		pStmt.setString(8, purchaseVO.getDlvyDate());
		
		pStmt.executeUpdate();
		
		con.close();
	}
	
	public void updatePurchase(PurchaseVO purchaseVO) throws Exception{
		
		Connection con = DBUtil.getConnection();
		
		String sql = "UPDATE TRANSACTION SET payment_option = ?, receiver_name = ?, receiver_phone = ?, "
				+ "demailaddr = ?, dlvy_request = ?, dlvy_date = ? WHERE tran_no = ?";
		
		PreparedStatement pStmt = con.prepareStatement(sql);

		pStmt.setString(1, purchaseVO.getPaymentOption());
		pStmt.setString(2, purchaseVO.getReceiverName());
		pStmt.setString(3, purchaseVO.getReceiverPhone());
		pStmt.setString(4, purchaseVO.getDlvyAddr());
		pStmt.setString(5, purchaseVO.getDlvyRequest());
		pStmt.setString(6, purchaseVO.getDlvyDate());
		pStmt.setInt(7, purchaseVO.getTranNo());
		pStmt.executeUpdate();
		
		con.close();
	}
	
	public void updateTranCode(PurchaseVO purchaseVO) throws Exception{
		
		Connection con = DBUtil.getConnection();
		
		String sql =  "UPDATE TRANSACTION SET tran_status_code = ? WHERE tran_no = ?";
		PreparedStatement pStmt = con.prepareStatement(sql);

		pStmt.setString(1, purchaseVO.getTranCode());
		pStmt.setInt(2, purchaseVO.getTranNo());
		
		pStmt.executeUpdate();
		con.close();
	}
}
