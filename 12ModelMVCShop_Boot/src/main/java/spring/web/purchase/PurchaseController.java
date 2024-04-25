package spring.web.purchase;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;

import spring.domain.Page;
import spring.domain.Purchase;
import spring.domain.Search;
import spring.domain.User;
import spring.service.product.ProductService;
import spring.service.purchase.PurchaseService;
import spring.service.user.UserService;



@Controller
@RequestMapping("/purchase/*") 
public class PurchaseController {

	//Field
	@Autowired
	@Qualifier("purchaseService")
	private PurchaseService purchaseService;
	
	@Autowired
	@Qualifier("productService")
	private ProductService productService;
	
	@Autowired
	@Qualifier("userService")
	private UserService userService;
	
	
	public PurchaseController() {
		System.out.println(this.getClass());
	}
	
	@Value("${pageUnit}")
	int pageUnit;
	
	@Value("${pageSize}")
	int pageSize;

	@RequestMapping(value="addPurchaseView")
	public ModelAndView addPurchaseView(@RequestParam("prodNo") int prodNo, HttpSession session) throws Exception {

		System.out.println("/purchase/addPurchaseView : GET");
		
		ModelAndView model = new ModelAndView();
		
		model.addObject("user", session.getAttribute("user"));
		model.addObject("product", productService.getProduct(prodNo));
		model.setViewName("forward:/purchase/addPurchaseView.jsp");
		
		System.out.println(model);
		
		return model;
	}
	
	@RequestMapping("addPurchase")
	public ModelAndView addPurchase(@ModelAttribute("purchase") Purchase purchase, 
									@RequestParam("userId") String userId, 
									@RequestParam("prodNo") int prodNo) throws Exception {
		
		System.out.println("/purchase/addPurchase : POST");
	
		ModelAndView model = new ModelAndView();
				
		purchase.setBuyer(userService.getUser(userId));
		purchase.setPurchaseProd(productService.getProduct(prodNo));
		purchase.setTranCode("2");
		purchaseService.addPurchase(purchase);
		
		model.addObject("purchase", purchase);
		model.setViewName("forward:/purchase/addPurchase.jsp");
		
		System.out.println("purchase : "+purchase);
		System.out.println(model);
		
		return model;
		//return new ModelAndView("forward:/purchase/addPurchase.jsp", "purchase" , purchase);
	}

	@RequestMapping("getPurchase")
	public ModelAndView getPurchase(@RequestParam("tranNo") int tranNo) throws Exception {

		System.out.println("/purchase/getPurchase : POST");
		return new ModelAndView("forward:/purchase/getPurchase.jsp", "purchase", purchaseService.getPurchase(tranNo));
		
	}		

	@RequestMapping(value="updatePurchaseView", method = RequestMethod.GET)
	public ModelAndView updatePurchaseView(@RequestParam("tranNo") int tranNo) throws Exception {

		System.out.println("/purchase/updatePurchaseView : GET");		
		return new ModelAndView("forward:/purchase/updatePurchase.jsp", "purchase", purchaseService.getPurchase(tranNo));
		
	}	
	
	@RequestMapping(value="updatePurchase", method = RequestMethod.POST)
	public ModelAndView updatePurchas(@ModelAttribute("purchase") Purchase purchase, 
										@RequestParam("tranNo") int tranNo) throws Exception {
		
		purchaseService.updatePurchase(purchase);
		
		System.out.println("/purchase/updatePurchase : POST");
			
		return new ModelAndView("forward:/purchase/getPurchase","tranNo" , tranNo);
		 
	}		
	
	@RequestMapping("listPurchase")
	public ModelAndView listPurchase(@ModelAttribute("search") Search search, HttpSession session) throws Exception {
	    
	    System.out.println("/purchase/listPurchase 시작");
	    
	    if(search.getCurrentPage() == 0) {
	        search.setCurrentPage(1);
	    }
	    
	    search.setPageSize(pageSize);
	    
	    String userId = ((User)session.getAttribute("user")).getUserId(); 
	    
	    Map<String, Object> map = purchaseService.getPurchaseList(search, userId); 
	    List<Object> list = (List<Object>) map.get("list");
	            
	    Page resultPage = new Page(search.getCurrentPage(), ((Integer)map.get("totalCount")).intValue(), pageUnit, pageSize);
	    
	    System.out.println("map : "+map);
	    System.out.println("resultPage : "+resultPage);
	    System.out.println("search : "+search);      
	    
	    ModelAndView model = new ModelAndView();
	    model.addObject("list",list);
	    model.addObject("resultPage", resultPage);
	    model.addObject("search", search);
	    model.setViewName("forward:/purchase/listPurchase.jsp");
	    
	    return model;
	}
	
	@RequestMapping("listSale")
	public ModelAndView listSale(@ModelAttribute("search") Search search) throws Exception {
		
		System.out.println("/purchase/listSale 시작");
		
		if(search.getCurrentPage() == 0) {
			search.setCurrentPage(1);
		}
		
		search.setPageSize(pageSize);

		Map<String, Object> map = purchaseService.getSaleList(search);
		
		Page resultPage = new Page(search.getCurrentPage(), ((Integer)map.get("totalCount")).intValue(), pageUnit, pageSize);
		
		System.out.println("map : "+map);
		System.out.println("resultPage : "+resultPage);
		System.out.println("search : "+search);		
		
		ModelAndView model = new ModelAndView();
		model.addObject("list", map.get("list"));
		model.addObject("resultPage", resultPage);
		model.addObject("search", search);
		model.setViewName("forward:/purchase/listSale.jsp");
		
		System.out.println(model);
		
		return model;
	}
	
	@RequestMapping("updateTranCode")
	public ModelAndView updateTranCode(@RequestParam("tranCode") String tranCode, @RequestParam("tranNo") int tranNo) throws Exception {
		
		System.out.println("/purchase/updateTranCode : POST");
		tranCode="4";
		Purchase purchase = purchaseService.getPurchase(tranNo);
		purchase.setTranCode(tranCode);
		purchaseService.updateTranCode(purchase);
		
		return new ModelAndView("redirect:/purchase/listPurchase");
		
	}
	
	@RequestMapping("updateTranCodeByProd")
	public ModelAndView updateTranCodeByProd(@RequestParam("currentPage") int currentPage, @RequestParam("prodNo") int prodNo, 
												@RequestParam("tranCode") String tranCode) throws Exception {
		
		System.out.println("purchase/updateTranCodeByProd 시작");
		tranCode = "3";
		Purchase purchase = purchaseService.getPurchaseByProd(prodNo);
		purchase.setTranCode(tranCode);
		purchaseService.updateTranCode(purchase);

		return new ModelAndView("redirect:/product/listProduct?menu=manage");
	}	
	
}
