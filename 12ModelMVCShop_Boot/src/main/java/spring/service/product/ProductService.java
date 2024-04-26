package spring.service.product;

import java.util.List;
import java.util.Map;

import spring.domain.Product;
import spring.domain.Search;



public interface ProductService {

	//상품등록
	public void addProduct(Product product) throws Exception;
	
	//상품검색
	public Product getProduct(int prodNo) throws Exception;
	
	//상품리스트
	public Map<String, Object> getProductList(Search search) throws Exception;
	
	//상품정보 수정
	public void updateProduct(Product product) throws Exception;
	
	//오토컴플릿
	public List<Map<String, Object>> autoComplete(Map<String, Object> parmas) throws Exception;
	
	//상품찜하기
	public void updateDibProduct(Product product) throws Exception;
	
}
