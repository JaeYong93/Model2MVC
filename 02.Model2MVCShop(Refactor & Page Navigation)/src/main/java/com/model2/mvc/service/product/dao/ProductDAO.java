package com.model2.mvc.service.product.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.Map;
import java.util.HashMap;
import java.util.List;

import com.model2.mvc.common.Search;
import com.model2.mvc.common.util.DBUtil;
import com.model2.mvc.service.domain.Product;

public class ProductDAO {

	public ProductDAO() {
		
	}
	
	public Product findProduct(int prodNo) throws Exception {
		
		Connection con = DBUtil.getConnection();
		
		String sql = "SELECT * FROM PRODUCT WHERE prod_no= ? ";
		
		PreparedStatement pStmt = con.prepareStatement(sql);
		pStmt.setInt(1, prodNo);
		
		ResultSet rs = pStmt.executeQuery();
		
		Product product = null;
		while(rs.next()) {
			product = new Product();
			product.setProdNo(rs.getInt("prod_no"));
			product.setProdName(rs.getString("prod_name"));
			product.setProdDetail(rs.getString("prod_detail"));
			product.setManuDate(rs.getString("manufacture_day"));
			product.setPrice(rs.getInt("price"));
			product.setFileName(rs.getString("image_file"));
			product.setRegDate(rs.getDate("reg_date"));	
		}
		rs.close();
		pStmt.close();
		con.close();

		return product;
		
	}

	public Map<String, Object> getProductList(Search search) throws Exception {
		
		Map<String, Object> map = new HashMap<String, Object>(); 
		
		Connection con = DBUtil.getConnection();
		
		String sql = "SELECT p.*, (SELECT t.tran_status_code " +
				" FROM transaction t " +
				" WHERE p.prod_no = t.prod_no) AS tranCode " +
				" FROM product p";
		
		if (search.getSearchCondition() != null) {
			if (search.getSearchCondition().equals("0") && !search.getSearchKeyword().equals("")) {
				sql += " WHERE prod_no LIKE '%" + search.getSearchKeyword() + "%'";
				
			} else if (search.getSearchCondition().equals("1") && !search.getSearchKeyword().equals(""))  {
				sql += " WHERE prod_name LIKE '%" + search.getSearchKeyword() + "%'";
				
			}  else if (search.getSearchCondition().equals("2") && !search.getSearchKeyword().equals("")) {
				sql += " WHERE price LIKE '%" + search.getSearchKeyword() + "%'";
			}	
		}
		sql += " ORDER BY prod_no";

		System.out.println("Product DAO sql : "+sql);
		
		int totalCount = this.getTotalCount(sql);
		System.out.println("Product DAO totalCount :"+ totalCount);
		
		sql = makeCurrentPageSql(sql, search);
		PreparedStatement pStmt = con.prepareStatement(sql);
		ResultSet rs = pStmt.executeQuery();

		System.out.println(search);

		List<Product> list = new ArrayList<Product>();
		
		while(rs.next()) {
			Product product = new Product();
			
			product.setProdNo(rs.getInt("prod_no"));
			product.setProdName(rs.getString("prod_name"));
			product.setProdDetail(rs.getString("prod_detail"));
			product.setManuDate(rs.getString("manufacture_day"));
			product.setPrice(rs.getInt("price"));
			product.setFileName(rs.getString("image_file"));
			product.setRegDate(rs.getDate("reg_date"));
			
			String tranCode = rs.getString("tranCode");
			product.setProTranCode(tranCode != null ? tranCode : "");			
			
			list.add(product);
		}
		
		map.put("totalCount", new Integer(totalCount));

		map.put("list", list);
		
		rs.close();
		pStmt.close();
		con.close();

		return map;
	}
	
	public void insertProduct(Product product) throws Exception{
		
		Connection con = DBUtil.getConnection();
		
		String replaceManuDate = product.getManuDate().replace("-", "");
		
		String sql = "INSERT INTO PRODUCT values(seq_product_prod_no.nextval, ?, ?, ?, ?, ?, SYSDATE)";
		
		PreparedStatement pStmt = con.prepareStatement(sql);
		pStmt.setString(1, product.getProdName());
		pStmt.setString(2, product.getProdDetail());
		pStmt.setString(3, replaceManuDate);
		pStmt.setInt(4, product.getPrice());
		pStmt.setString(5, product.getFileName());
		pStmt.executeUpdate();
		
		pStmt.close();
		con.close();
	}
	
	public void updateProduct(Product product) throws Exception {
	
		Connection con = DBUtil.getConnection();
		
		String sql =  "UPDATE PRODUCT SET prod_name = ?, prod_detail = ? , manufacture_day = ? , price = ? , image_file = ? WHERE prod_no = ?";
		PreparedStatement pStmt = con.prepareStatement(sql);
		pStmt.setString(1, product.getProdName());
		pStmt.setString(2, product.getProdDetail());
		pStmt.setString(3, product.getManuDate());
		pStmt.setInt(4, product.getPrice());
		pStmt.setString(5, product.getFileName());
		pStmt.setInt(6, product.getProdNo());
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
		
		System.out.println("ProductDAO make SQL : "+ sql);	
		
		return sql;
	}
}
