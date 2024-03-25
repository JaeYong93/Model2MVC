package com.model2.mvc.service.product;

import java.util.List;

import com.model2.mvc.common.Search;
import com.model2.mvc.service.domain.Product;

// 상품관리 CRUD 추상화/캡슐화한 DAO Interface Definition
public interface ProductDao {

	//INSERT
	public void addProduct(Product product) throws Exception;
	
	//SELECT ONE
	public Product getProduct(int prodNo) throws Exception;
	
	//SELECT LIST
	public List<Product> getProductList(Search search) throws Exception;
	
	//UPDATE
	public void updateProduct(Product product) throws Exception;
	
	//페이지 구분
	public int getTotalCount(Search search) throws Exception;
}
