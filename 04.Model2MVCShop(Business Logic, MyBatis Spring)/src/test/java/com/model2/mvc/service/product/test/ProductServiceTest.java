package com.model2.mvc.service.product.test;

import java.util.List;
import java.util.Map;

import org.junit.Assert;
import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;

import com.model2.mvc.common.Search;
import com.model2.mvc.service.domain.Product;
import com.model2.mvc.service.product.ProductService;



@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration(locations = {"classpath:config/commonservice.xml"})
public class ProductServiceTest {

	@Autowired
	@Qualifier("productServiceImpl")
	private ProductService productService;

	//@Test
	public void testAddProduct() throws Exception {
		
		Product product = new Product();

		product.setProdNo(10032);
		product.setProdName("갈치");
		product.setProdDetail("제주은갈치");
		product.setPrice(10000);
		product.setFileName("갈치사진");
		product.setManuDate("2024-03-01");
		
		productService.addProduct(product);
		product = productService.getProduct(10032);
		
		System.out.println(product);

		Assert.assertEquals(10032, product.getProdNo());		
		Assert.assertEquals("갈치", product.getProdName());
		Assert.assertEquals("제주은갈치", product.getProdDetail());
		Assert.assertEquals(10000, product.getPrice());
		Assert.assertEquals("갈치사진", product.getFileName());
		Assert.assertEquals("2024-03-01", product.getManuDate());		
	}

	//@Test
	public void testGetProduct() throws Exception {
		
		Product product = new Product();
		
		product = productService.getProduct(10032);
		
		System.out.println(product);
		
		Assert.assertEquals(10032, product.getProdNo());		
		Assert.assertEquals("갈치", product.getProdName());
		Assert.assertEquals("제주은갈치", product.getProdDetail());
		Assert.assertEquals(10000, product.getPrice());
		Assert.assertEquals("갈치사진", product.getFileName());
		Assert.assertEquals("2024-03-01", product.getManuDate());
		
		Assert.assertNotNull(productService.getProduct(10010));
		Assert.assertNotNull(productService.getProduct(10012));		
	}
	
	//@Test
	public void testUpdateProduct() throws Exception {
	
		Product product = productService.getProduct(10032);
		Assert.assertNotNull(product);
		
		Assert.assertEquals("갈치", product.getProdName());
		Assert.assertEquals("제주은갈치", product.getProdDetail());
		Assert.assertEquals("2024-03-01", product.getManuDate());
		Assert.assertEquals(10000, product.getPrice());
		Assert.assertEquals("갈치사진", product.getFileName());
		
		product.setProdName("고등어");
		product.setProdDetail("노르웨이고등어");
		product.setManuDate("2024-02-28");
		product.setPrice(8000);
		product.setFileName("고등어사진");
		
		productService.updateProduct(product);
		
		product = productService.getProduct(10032);
		Assert.assertNotNull(product);
		
		System.out.println(product);
		
		Assert.assertEquals("고등어", product.getProdName());
		Assert.assertEquals("노르웨이고등어", product.getProdDetail());
		Assert.assertEquals("2024-02-28", product.getManuDate());
		Assert.assertEquals(8000, product.getPrice());
		Assert.assertEquals("고등어사진", product.getFileName());		
	}
	
	//@Test
	public void testGetProductListAll() throws Exception {

		Search search = new Search();
		search.setCurrentPage(1);
		search.setPageSize(3);
		Map<String, Object> map = productService.getProductList(search);
		
		List<Object> list = (List<Object>)map.get("list");
		Assert.assertEquals(3, list.size());
		
		System.out.println(list);
		
		Integer totalCount = (Integer)map.get("totalCount");
		System.out.println(totalCount);
		
		System.out.println("====================");
		
		search.setCurrentPage(1);
		search.setPageSize(3);
		search.setSearchCondition("0");
		search.setSearchKeyword("");
		map = productService.getProductList(search);
		
		list = (List<Object>)map.get("list");
		Assert.assertEquals(3, list.size());
		
		System.out.println(list);
		
		totalCount = (Integer)map.get("totalCount");
		System.out.println(totalCount);
	}
}//end of class