package com.model2.mvc.view.product;

import java.io.File;
import java.io.IOException;
import java.util.Date;
import java.util.List;
import java.util.StringTokenizer;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.apache.commons.fileupload.DiskFileUpload;
import org.apache.commons.fileupload.FileItem;
import org.apache.commons.fileupload.FileUpload;

import com.model2.mvc.framework.Action;
import com.model2.mvc.service.product.ProductService;
import com.model2.mvc.service.product.impl.ProductServiceImpl;
import com.model2.mvc.service.domain.Product;

public class UpdateProductAction extends Action{

	@Override
	public String execute(HttpServletRequest request, HttpServletResponse response) throws Exception {

		int prodNo = 0;
		
		String menu = request.getParameter("menu");		
		
		if(FileUpload.isMultipartContent(request)) {
			request.getServletContext().getRealPath("images/uploadFiles");
			String temDir = "C:\\workspace\\02.Model2MVCShop(stu)\\src\\main\\webapp\\images\\uploadFiles";
			//String temDir = "/uploadFiles/";
			
			DiskFileUpload fileUpload = new DiskFileUpload();
			fileUpload.setRepositoryPath(temDir);
			
			fileUpload.setSizeMax(1024*1024*10);
			
			fileUpload.setSizeThreshold(1024*100);
			
			if(request.getContentLength() < fileUpload.getSizeMax()) {
				Product product = new Product();
				StringTokenizer token = null;
				
				ProductServiceImpl service = new ProductServiceImpl();
				
				List fileItemList = fileUpload.parseRequest(request);
				int Size = fileItemList.size();
				for(int i = 0 ; i < Size ; i++) {
					FileItem fileItem = (FileItem)fileItemList.get(i);
					
					if(fileItem.isFormField()) {
						if(fileItem.getFieldName().equals("manuDate")) {
							
							token = new StringTokenizer(fileItem.getString("EUC-KR"),"-");
							String manuDate = token.nextToken();
							while(token.hasMoreTokens())
								manuDate +=token.nextToken();
							product.setManuDate(manuDate);	
						}else if(fileItem.getFieldName().equals("prodName"))
							product.setProdName(fileItem.getString("EUC-KR"));

						 else if(fileItem.getFieldName().equals("prodDetail"))
							product.setProdDetail(fileItem.getString("EUC-KR"));

						 else if(fileItem.getFieldName().equals("price"))
							product.setPrice(Integer.parseInt(fileItem.getString("EUC-KR")));
						
						 else if(fileItem.getFieldName().equals("prodNo")) {
							prodNo = Integer.parseInt(fileItem.getString("EUC-KR"));
							product.setProdNo(prodNo);

						}
					} else {
				
					if(fileItem.getSize() > 0) {
						int idx = fileItem.getName().lastIndexOf("\\");
						
						if(idx == -1) {
							idx = fileItem.getName().lastIndexOf("/");	
						}
						
						String fileName = fileItem.getName().substring(idx+1);
						product.setFileName(fileName);
						try {
							File uploadFile = new File(temDir, fileName);
							fileItem.write(uploadFile);
						} catch(IOException e) {
							System.out.println(e);
						}
					}else {
						product.setFileName("../../images/empty.GIF");
					}	
				}
			}
			service.updateProduct(product);
			
			request.setAttribute("product", product);
			
			System.out.println(product);
			}else {
				int overSize = (request.getContentLength() / 1000000);
			
				System.out.println("<script>alert('파일의 크기는 1MB까지입니다. 올리신 파일 용량은 "+overSize+"MB 입니다');");
			
				System.out.println("history.back();</script>");
			}
		}else {
			System.out.println("인코딩 타입이 muultipart/form=data가 아닙니다");
		}
		return "forwardt:/getProduct.do?prodNo="+prodNo+"&menu="+menu;			
		/*
		Product product = new Product();
		
		int price = Integer.parseInt(request.getParameter("price"));
		int prodNo = Integer.parseInt(request.getParameter("prodNo"));
		String menu = request.getParameter("menu");
		
		product.setProdNo(prodNo);
		
		product.setProdName(request.getParameter("prodName"));
		product.setProdDetail(request.getParameter("prodDetail"));
		product.setManuDate(request.getParameter("manuDate"));		
		product.setPrice(price);
		product.setFileName(request.getParameter("fileName"));

		ProductService service = new ProductServiceImpl();
		service.updateProduct(product);
		
		request.setAttribute("product", product);
		
		request.getParameter("menu");
		
		System.out.println(product);
		System.out.println(request.getParameter("menu"));
		
		return "forward:/getProduct.do?prodNo="+prodNo+"&menu="+menu;
		*/
	}

}