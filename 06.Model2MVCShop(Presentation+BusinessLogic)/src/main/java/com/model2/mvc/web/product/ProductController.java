package com.model2.mvc.web.product;


import java.io.File;
import java.io.IOException;
import java.nio.file.Files;
import java.nio.file.Path;
import java.nio.file.Paths;
import java.util.Map;

import javax.servlet.annotation.MultipartConfig;
import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.http.HttpRequest;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;

import com.model2.mvc.common.Page;
import com.model2.mvc.common.Search;
import com.model2.mvc.service.domain.Product;
import com.model2.mvc.service.product.ProductService;
import com.model2.mvc.service.product.impl.ProductServiceImpl;

@Controller
@MultipartConfig
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
	
	/*
	@RequestMapping("/addProduct.do")
	public String addProduct(@ModelAttribute("product") Product product) throws Exception {	
	
		System.out.println("/addProduct.do");
		productService.addProduct(product);
		return "forward:/product/getProduct.jsp";
	}
	*/

    @RequestMapping(value = "/addProduct.do", method = RequestMethod.POST)
    public String addProduct(MultipartHttpServletRequest request) throws Exception {

    	System.out.println("/addProduct.do");
    	
        MultipartFile file = request.getFile("fileName");
        String manuDate = request.getParameter("manuDate");
        String prodName = request.getParameter("prodName");
        String prodDetail = request.getParameter("prodDetail");
        String fileName = null;

        if (file != null && !file.isEmpty()) {
            fileName = file.getOriginalFilename();
            try {
                byte[] bytes = file.getBytes();
                String temDir = request.getServletContext().getRealPath("images/uploadFiles");
                
                Path path = Paths.get(temDir, File.separator + fileName);                
                Files.write(path, bytes);
            } catch (IOException e) {
                e.printStackTrace();
            }
        } else {
            fileName = "../../images/empty.GIF";
        }

        Product product = new Product();
        product.setFileName(fileName);
        product.setManuDate(manuDate);
        product.setProdName(prodName);
        product.setProdDetail(prodDetail);
        product.setPrice(Integer.parseInt(request.getParameter("price")));
        productService.addProduct(product);
        request.setAttribute("product", product);

        return "forward:/product/getProduct.jsp";
    }

	@RequestMapping("/getProduct.do")
	public String getProduct(@RequestParam("menu") String menu,
								@RequestParam("prodNo") int prodNo, Model model) throws Exception {
		
		System.out.println("/getProduct.do");
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
	public String updateProduct(MultipartHttpServletRequest request) throws Exception {
		
		System.out.println("/updateProduct.do");

        MultipartFile file = request.getFile("fileName");
        String manuDate = request.getParameter("manuDate");
        String prodName = request.getParameter("prodName");
        String prodDetail = request.getParameter("prodDetail");
        String fileName = null;

        if (file != null && !file.isEmpty()) {
            fileName = file.getOriginalFilename();
            try {
                byte[] bytes = file.getBytes();
                String temDir = request.getServletContext().getRealPath("images/uploadFiles");
                
                Path path = Paths.get(temDir, File.separator + fileName);                
                Files.write(path, bytes);
            } catch (IOException e) {
                e.printStackTrace();
            }
        } else {
            fileName = "../../images/empty.GIF";
        }

        Product product = new Product();
        product.setFileName(fileName);
        product.setManuDate(manuDate);
        product.setProdName(prodName);
        product.setProdDetail(prodDetail);
        product.setPrice(Integer.parseInt(request.getParameter("price")));
        
        productService.updateProduct(product);
        request.setAttribute("product", product);
        
        return "forward:/product/getProduct.jsp";
		
	}	
		/*
		productService.updateProduct(product);

		model.addAttribute(prodNo);
		model.addAttribute("product", product);

		return "forward:/product/getProduct.jsp";
		
		}
		*/
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
