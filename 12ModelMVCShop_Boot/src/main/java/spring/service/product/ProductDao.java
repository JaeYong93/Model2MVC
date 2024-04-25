package spring.service.product;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Mapper;

import spring.domain.Product;
import spring.domain.Search;



// 상품관리 CRUD 추상화/캡슐화한 DAO Interface Definition
@Mapper
public interface ProductDao {

	//INSERT
	public void addProduct(Product product) throws Exception;
	
	//SELECT ONE
	public Product getProduct(int prodNo) throws Exception;
	
	//SELECT LIST
	public List<Product> getProductList(Search search) throws Exception;
	
	//UPDATE
	public void updateProduct(Product product) throws Exception;
	
	//오토컴플릿
	public List<Map<String, Object>> autoComplete(Map<String, Object> params) throws Exception;
	
	//페이지 구분
	public int getTotalCount(Search search) throws Exception;
}
