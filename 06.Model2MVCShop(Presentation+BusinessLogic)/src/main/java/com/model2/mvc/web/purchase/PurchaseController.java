package com.model2.mvc.web.purchase;

import java.util.Map;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;

import com.model2.mvc.common.Page;
import com.model2.mvc.common.Search;
import com.model2.mvc.service.domain.Purchase;
import com.model2.mvc.service.domain.User;
import com.model2.mvc.service.product.ProductService;
import com.model2.mvc.service.purchase.PurchaseService;
import com.model2.mvc.service.user.UserService;

@Controller
public class PurchaseController {

	//Field
	@Autowired
	@Qualifier("purchaseServiceImpl")
	private PurchaseService purchaseService;
	
	@Autowired
	@Qualifier("productServiceImpl")
	private ProductService productService;
	
	@Autowired
	@Qualifier("userServiceImpl")
	private UserService userService;
	
	
	public PurchaseController() {
		System.out.println(this.getClass());
	}
	
	@Value("#{commonProperties['pageUnit']}")
	int pageUnit;
	
	@Value("#{commonProperties['pageSize']}")
	int pageSize;

	@RequestMapping("/addPurchaseView.do")
	public ModelAndView addPurchaseView(@RequestParam("prodNo") int prodNo, HttpSession session) throws Exception {

		System.out.println("/addPurchaseView.do 시작");
		
		ModelAndView model = new ModelAndView();
		
		model.addObject("user", session.getAttribute("user"));
		model.addObject("product", productService.getProduct(prodNo));
		model.setViewName("forward:/purchase/addPurchaseView.jsp");
		
		System.out.println(model);
		
		return model;
	}
	
	@RequestMapping("/addPurchase.do")
	public ModelAndView addPurchase(@ModelAttribute("purchase") Purchase purchase, @RequestParam("userId") String userId, 
									@RequestParam("prodNo") int prodNo) throws Exception {
		
		System.out.println("/addPurchase.do 시작");
	
		purchase.setBuyer(userService.getUser(userId));
		purchase.setPurchaseProd(productService.getProduct(prodNo));
		purchase.setTranCode("2");
		purchaseService.addPurchase(purchase);
		
		System.out.println("purchase : "+purchase);
		
		return new ModelAndView("forward:/purchase/addPurchase.jsp");
	}

	@RequestMapping("/getPurchase.do")
	public ModelAndView getPurchase() throws Exception {
		
		
		
		ModelAndView model = new ModelAndView();
		return model;
		
	}		

	@RequestMapping("/updatePurchaseView.do")
	public ModelAndView updatePurchaseView() throws Exception {
		
		ModelAndView model = new ModelAndView();
		return model;
		
	}	
	
	@RequestMapping("/updatePurchase.do")
	public ModelAndView updatePurchas() throws Exception {
		
		ModelAndView model = new ModelAndView();
		return model;
		
	}		
	
	@RequestMapping("/listPurchase.do")
	public ModelAndView listPurchase(@ModelAttribute("search") Search search, HttpSession session) throws Exception {
		
		System.out.println("/listPurchase.do 시작");
		
		if(search.getCurrentPage() == 0) {
			search.setCurrentPage(1);
		}
		
		search.setPageSize(pageSize);
		
		String userId = ((User)session.getAttribute("user")).getUserId();
		
		Map<String, Object> map = purchaseService.getPurchaseList(search, userId);
		
		Page resultPage = new Page(search.getCurrentPage(), ((Integer)map.get("totalCount")).intValue(), pageUnit, pageSize);
		
		System.out.println("map : "+map);
		System.out.println("resultPage : "+resultPage);
		System.out.println("search : "+search);		
		
		ModelAndView model = new ModelAndView();
		model.addObject("list", map.get("list"));
		model.addObject("resultPage", resultPage);
		model.addObject("search", search);
		model.setViewName("forward:/purchase/listPurchase.jsp");
		
		return model;
	}
	
	@RequestMapping("/listSale.do")
	public ModelAndView listSale(@ModelAttribute("search") Search search) throws Exception {
		
		System.out.println("/listPurchase.do 시작");
		
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
		
		return model;
	}
	
	@RequestMapping("/updateTranCode.do")
	public ModelAndView updateTranCode() throws Exception {
		
		ModelAndView model = new ModelAndView();
		return model;
		
	}
	
	@RequestMapping("/updateTranCodeByProd.do")
	public ModelAndView updateTranCodeByProd() throws Exception {
		
		ModelAndView model = new ModelAndView();
		return model;
		
	}	
	
}
