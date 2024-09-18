package spring.web.product;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.bind.annotation.RestController;

import spring.domain.Page;
import spring.domain.Product;
import spring.domain.Search;
import spring.service.product.ProductService;



@RestController
@RequestMapping("/product/*")
public class ProductRestController {

	@Autowired
	@Qualifier("productService")
	private ProductService productService;
	
	public ProductRestController() {
		System.out.println(this.getClass());
	}
	
	@Value("${pageUnit}")
	int pageUnit;
	
	@Value("${pageSize}")
	int pageSize;	
	
	@RequestMapping(value="json/getProduct/{prodNo}", method = RequestMethod.GET)
	public Product getProduct(@PathVariable int prodNo) throws Exception{
		
		System.out.println("/product/json/getProduct : GET 시작");
		
		Product product = productService.getProduct(prodNo);
		
		System.out.println(product);
		
		return productService.getProduct(prodNo);
	}
	
	@RequestMapping(value = "json/listProduct")
	public Map<String, Object> listProduct(@RequestBody Search search, Model model) throws Exception {

		System.out.println("json/listProduct 시작 ");
		
		if(search.getCurrentPage() == 0) {
			search.setCurrentPage(1);
		}
		search.setPageSize(pageSize);
		
		Map<String, Object> map = productService.getProductList(search);
		
		Page resultPage = new Page(search.getCurrentPage(), 
									((Integer)map.get("totalCount")).intValue(), pageUnit, pageSize);
		System.out.println(resultPage);

		model.addAttribute("list",map.get("list"));
		model.addAttribute("resultPage", resultPage);
		model.addAttribute("search", search);
		
		System.out.println(search);
		
		return map;
	}
	
	@RequestMapping(value= "json/autoComplete")
	public @ResponseBody Map<String, Object> autoComplete(@RequestBody Map<String, Object> params) throws Exception {		
		
		System.out.println("json/autoComplete POST 시작");
		
		System.out.println("params :"+params);
		
		List<Map<String, Object>> list = productService.autoComplete(params); 
		
		params.put("list", list);
		
		System.out.println("params :"+params);		
		return params;
	}
	
}
