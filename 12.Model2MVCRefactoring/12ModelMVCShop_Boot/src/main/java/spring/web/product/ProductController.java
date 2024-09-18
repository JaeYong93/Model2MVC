package spring.web.product;

import java.io.File;
import java.io.IOException;
import java.nio.file.Files;
import java.nio.file.Path;
import java.nio.file.Paths;
import java.util.LinkedHashSet;
import java.util.List;
import java.util.Map;

import javax.servlet.annotation.MultipartConfig;
import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;
import org.springframework.web.servlet.ModelAndView;

import spring.domain.Page;
import spring.domain.Product;
import spring.domain.Purchase;
import spring.domain.Search;
import spring.domain.User;
import spring.service.product.ProductService;



@Controller
@MultipartConfig
@RequestMapping("/product/*")
public class ProductController {

	@Autowired
	@Qualifier("productService")
	private ProductService productService;
	
	public ProductController() {
		System.out.println(this.getClass());
	}
	
	@Value("${pageUnit}")
	int pageUnit;
	
	@Value("${pageSize}")
	int pageSize;
	
	@RequestMapping(value = "addProduct", method = RequestMethod.POST)
    public String addProduct(MultipartHttpServletRequest request) throws Exception {

    	System.out.println("/product/addProduct: GET ����");
    	
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
	
	@RequestMapping( "getProduct")
	public String getProduct(@RequestParam("menu") String menu,
								@RequestParam("prodNo") int prodNo, 
								HttpServletRequest request,
								HttpServletResponse response, Model model) throws Exception {
		
		System.out.println("/product/getProduct ����");
		Product product = productService.getProduct(prodNo);

		model.addAttribute("prodNo", prodNo);
		model.addAttribute("menu",menu);
		model.addAttribute("product", product);
		
		System.out.println(menu);
	
	    Cookie[] cookies = request.getCookies();
	    String history = null;
	    LinkedHashSet<String> historySet = new LinkedHashSet<>();
	    
	    if (cookies != null) {
	        for (Cookie cookie : cookies) {
	            if (cookie.getName().equals("history")) {
	                history = cookie.getValue();
	                String[] items = history.split("\\|");
	                for(String item : items) {
	                	historySet.add(item);
	                }
	                break;
	            }
	        }
	    }
	    
	    historySet.add(String.valueOf(prodNo));

	    StringBuilder historyBuilder = new StringBuilder();
	    
	    for(String item : historySet) {
	    	historyBuilder.append(item).append("|");
	    }
	    history = historyBuilder.toString();
	    
	    if(!history.isEmpty()) {
	        history = history.substring(0, history.length() - 1);
	    }

		Cookie historyCookie = new Cookie("history", history);
		historyCookie.setPath("/");
		historyCookie.setMaxAge(2 * 60 * 60); 
		response.addCookie(historyCookie);	
		
	    
		if(menu !=null) {
			if(menu.equals("manage")) {
				return "forward:/product/updateProduct";
				
			}else if(menu.equals("search")){
				return "forward:/product/readProduct.jsp";
			}
		}
		return "forward:/product/readProduct.jsp";
	}
	
	@RequestMapping(value = "updateProduct", method = RequestMethod.GET)
	public String updateProductView(@RequestParam("prodNo") int prodNo, Model model) throws Exception {
		
		System.out.println("/product/updateProduct : GET");
		Product product = productService.getProduct(prodNo);
		model.addAttribute("product", product);	
		return "forward:/product/updateProduct.jsp";
	}
	
	
	@RequestMapping(value = "updateProduct", method = RequestMethod.POST)
	public String updateProduct(MultipartHttpServletRequest request) throws Exception {
		
		System.out.println("/product/updateProduct : POST");

        MultipartFile file = request.getFile("fileName");
        String manuDate = request.getParameter("manuDate");
        String prodName = request.getParameter("prodName");
        String prodDetail = request.getParameter("prodDetail");
        int prodNo = Integer.parseInt(request.getParameter("prodNo"));
        String fileName = null;

        if (file != null && !file.isEmpty()) {
            fileName = file.getOriginalFilename();
            System.out.println(fileName);
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
        product.setProdNo(prodNo);
        product.setPrice(Integer.parseInt(request.getParameter("price")));
        
        System.out.println(product);
        productService.updateProduct(product);
        System.out.println(product);
        request.setAttribute("product", product);
        
        return "forward:/product/getProduct.jsp";
		
	}
	
	@RequestMapping(value = "listProduct")
	public String listProduct(@RequestParam("menu") String menu, 
								@ModelAttribute("search") Search search, Model model) throws Exception {

		System.out.println("/product/listProduct : GET/POST");
		
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
		
		System.out.println(search);		

		return "forward:/product/listProduct.jsp";
	}

	@RequestMapping(value ="dibProduct")
	public String dibProduct(Model model, @RequestParam("prodNo") int prodNo, @RequestParam("menu") String menu,
							@ModelAttribute("search") Search search) throws Exception {
		
		System.out.println("/product/dibProduct : POST ����");
		
		String dibCode = "1";
		
		Product product = productService.getProduct(prodNo);
		product.setDibCode(dibCode);
		productService.updateDibProduct(product);
		
		System.out.println(product);
				
		return "redirect:/product/listProduct?menu=search";
	}
	
	@RequestMapping(value ="dibCancleProduct")
	public String dibCancleProduct(Model model, @RequestParam("prodNo") int prodNo, @RequestParam("menu") String menu,
							@ModelAttribute("search") Search search) throws Exception {
		
		System.out.println("/product/dibCancleProduct : POST ����");
		
		String dibCode = "";
		
		Product product = productService.getProduct(prodNo);
		product.setDibCode(dibCode);
		productService.updateDibProduct(product);
		
		System.out.println(product);
				
		return "redirect:/product/dibProductList";
		
	}	
	
	
	@RequestMapping(value = "dibProductList")
	public ModelAndView dibProductList(@ModelAttribute("search") Search search, HttpSession session) throws Exception {
		
		System.out.println("dibProductList : ����");
		
		if(search.getCurrentPage() == 0) {
			search.setCurrentPage(1);
		}
		search.setPageSize(pageSize);		
		
	    User currentUser = (User) session.getAttribute("user");
	    
	    String userId = currentUser.getUserId();
	    
	    System.out.println(userId);
	    
	    Map<String, Object> map = productService.getDibProductList(search, userId); 
	    List<Object> list = (List<Object>) map.get("list");
	            
	    Page resultPage = new Page(search.getCurrentPage(), ((Integer)map.get("totalCount")).intValue(), pageUnit, pageSize);
	    
	    System.out.println("map : "+map);
	    System.out.println("resultPage : "+resultPage);
	    System.out.println("search : "+search);      
	    
	    ModelAndView model = new ModelAndView();
	    model.addObject("list",list);
	    model.addObject("resultPage", resultPage);
	    model.addObject("search", search);
	    model.setViewName("forward:/product/dibProduct.jsp");
	    
	    return model;	    
	}
}
