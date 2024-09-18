package spring.service.product.impl;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Service;

import spring.domain.Product;
import spring.domain.Search;
import spring.service.product.ProductDao;
import spring.service.product.ProductService;



// 상품관리 서비스 구현
@Service("productService")
public class ProductServiceImpl implements ProductService{

	//Field
	@Autowired
	@Qualifier("productDao")
	private ProductDao productDao;
	
	public void setProductDao(ProductDao productDao) {
		this.productDao = productDao;
	}
	
	//Constructor
	public ProductServiceImpl() {
		System.out.println(this.getClass());
	}

	//Method
	@Override
	public void addProduct(Product product) throws Exception {
		productDao.addProduct(product);
	}

	@Override
	public Product getProduct(int prodNo) throws Exception {
		return productDao.getProduct(prodNo);
	}

	@Override
	public Map<String, Object> getProductList(Search search) throws Exception {
		List<Product> list = productDao.getProductList(search);
		System.out.println(list);
		int totalCount = productDao.getTotalCount(search);
		
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("list", list);
		map.put("totalCount", new Integer(totalCount));
		return map;
	}

	@Override
	public void updateProduct(Product product) throws Exception {
		productDao.updateProduct(product);
		
	}

	@Override
	public List<Map<String, Object>> autoComplete(Map<String, Object> params) throws Exception {

		return productDao.autoComplete(params);
	}

	@Override
	public void updateDibProduct(Product product) throws Exception {
		productDao.updateDibProduct(product);
	}

	@Override
	public Map<String, Object> getDibProductList(Search search, String userId) throws Exception {
		List<Object> list = productDao.getDibProductList(search, userId);
		int totalCount = productDao.getTotalCount(search);
		
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("list", list);
		map.put("totalCount", new Integer(totalCount));
		
		return map;
	}

}
