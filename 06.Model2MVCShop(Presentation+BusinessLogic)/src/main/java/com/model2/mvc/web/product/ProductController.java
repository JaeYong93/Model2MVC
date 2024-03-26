package com.model2.mvc.web.product;

import java.io.File;
import java.io.IOException;
import java.nio.file.Files;
import java.nio.file.Path;
import java.nio.file.Paths;
import java.util.Map;

import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.WebDataBinder;
import org.springframework.web.bind.annotation.InitBinder;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MultipartFile;

import com.model2.mvc.common.Page;
import com.model2.mvc.common.Search;
import com.model2.mvc.service.domain.Product;
import com.model2.mvc.service.product.ProductService;

@Controller
public class ProductController {

	@Autowired
	@Qualifier("productServiceImpl")
	private ProductService productService;
	
	public ProductController() {
		System.out.println(this.getClass());
	}
	
	@Value("#{commonProperties['pageUnit']}")
	int pageUnit;
	
	@Value("#{commonProperties['pageSize']}")
	int pageSize;

	@RequestMapping("/addProduct.do")
	public String addProduct(@ModelAttribute("product") Product product) throws Exception {

		System.out.println("/addProduct.do");
		productService.addProduct(product);
		return "forward:/product/getProduct.jsp";
	}

	
	@RequestMapping("/getProduct.do")
	public String getProduct(@RequestParam("menu") String menu,
								@RequestParam("prodNo") int prodNo, Model model, HttpServletRequest request) throws Exception {
		
		System.out.println("/getProduct.do");
	    Cookie[] cookies = request.getCookies();
	    String history = null;
	    if (cookies != null) {
	        for (Cookie cookie : cookies) {
	            if (cookie.getName().equals("history")) {
	                history = cookie.getValue();
	                break;
	            }
	        }
	    }

	    // 새로운 상품 조회 기록을 추가합니다.
	    if (history == null) {
	        history = String.valueOf(prodNo);
	    } else {
	        history += "|" + prodNo;
	    }		
		
		Product product = productService.getProduct(prodNo);

		model.addAttribute("prodNo", prodNo);
		model.addAttribute("menu",menu);
		model.addAttribute("product", product);
		
		System.out.println(menu);
		
		if(menu !=null) {
			if(menu.equals("manage")) {
				return "forward:/updateProductView.do";
				
			}else if(menu.equals("search")){
				return "forward:/product/readProduct.jsp";
			}
		}
		return "forward:/product/readProduct.jsp";
	}
	
	@RequestMapping("/updateProductView.do")
	public String updateProductView(@RequestParam("prodNo") int prodNo, Model model) throws Exception {
		
		System.out.println("/updateProductView.do");
		Product product = productService.getProduct(prodNo);
		model.addAttribute("product", product);	
		return "forward:/product/updateProduct.jsp";
	}
	
	
	@RequestMapping("/updateProduct.do")
	public String updateProduct(@RequestParam("prodNo") int prodNo,
								@ModelAttribute("product") Product product, Model model,
								@RequestParam("fileName") MultipartFile file, HttpServletRequest request) throws Exception {
		
		System.out.println("/updateProduct.do");
		if(!file.isEmpty()) {
			try {
				byte[] bytes = file.getBytes();
				String temDir = request.getServletContext().getRealPath("images/uploadFiles");
				Path path = Paths.get(temDir, File.separator + file.getOriginalFilename());
				Files.write(path, bytes);
				product.setFileName(file.getOriginalFilename());
			} catch(IOException e) {
				product.setFileName("../../images/empty.GIF");
			}
		}
		
		productService.updateProduct(product);

		model.addAttribute(prodNo);
		model.addAttribute("product", product);

		return "forward:/product/getProduct.jsp";
	}
	
	@RequestMapping("/listProduct.do")
	public String listProduct(@RequestParam("menu") String menu, 
								@ModelAttribute("search") Search search, Model model) throws Exception {

		System.out.println("/listProduct.do");
		
		if(search.getCurrentPage() == 0) {
			search.setCurrentPage(1);
		}
		search.setPageSize(pageSize);
		
		Map<String, Object> map = productService.getProductList(search);
		
		Page resultPage = new Page(search.getCurrentPage(), 
									((Integer)map.get("totalCount")).intValue(), pageUnit, pageSize);
		System.out.println(resultPage);

		model.addAttribute("menu", menu);
		model.addAttribute("list",map.get("list"));
		model.addAttribute("resultPage", resultPage);
		model.addAttribute("search", search);
		
		return "forward:/product/listProduct.jsp";
	}

}
