package com.model2.mvc.view.product;

import java.io.File;
import java.io.IOException;
import java.util.List;
import java.util.StringTokenizer;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.commons.fileupload.DiskFileUpload;
import org.apache.commons.fileupload.FileItem;
import org.apache.commons.fileupload.FileUpload;

import com.model2.mvc.framework.Action;
import com.model2.mvc.service.product.ProductService;
import com.model2.mvc.service.product.impl.ProductServiceImpl;
import com.model2.mvc.service.product.vo.ProductVO;

public class AddProductAction extends Action {

	@Override
	public String execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
		//ProductVO productVO = new ProductVO();
		
		if(FileUpload.isMultipartContent(request)) {
			//request.getServletContext().getRealPath("images/uploadFiles");
			String temDir = "C:\\Users\\hyt93\\git\\03.Model2MVCRefactorig\\03.Model2MVCShop(EL,JSTL)\\src\\main\\webapp\\images\\uploadFiles";
			//String temDir = "C:\\workspace\\.metadata\\.plugins\\org.eclipse.wst.server.core\\tmp0\\wtpwebapps\\01.Model2MVCShop(stu)\\images\\uploadFiles";
			
			//String temDir2 = "/uploadFiles/";

			DiskFileUpload fileUpload = new DiskFileUpload();
			fileUpload.setRepositoryPath(temDir);
			
			fileUpload.setSizeMax(1024*1024*10);
			
			fileUpload.setSizeThreshold(1024*100);;
			
			if(request.getContentLength() < fileUpload.getSizeMax()) {
				ProductVO productVO = new ProductVO();
				
				StringTokenizer token = null;
				
				List fileItemList = fileUpload.parseRequest(request);
				int Size = fileItemList.size();
				for(int i = 0 ; i < Size ; i++) {
					FileItem fileItem = (FileItem)fileItemList.get(i);
					
					if(fileItem.isFormField()) {
						if(fileItem.getFieldName().equals("manuDate")) {
							token = new StringTokenizer(fileItem.getString("EUC-KR"),"-");
							String manuDate = token.nextToken()+token.nextToken()+token.nextToken();
							productVO.setManuDate(manuDate);
						}
						else if(fileItem.getFieldName().equals("prodName"))
							productVO.setProdName(fileItem.getString("EUC-KR"));
						else if(fileItem.getFieldName().equals("prodDetail"))
							productVO.setProdDetail(fileItem.getString("EUC-KR"));
						else if(fileItem.getFieldName().equals("price"))
							productVO.setPrice(Integer.parseInt(fileItem.getString("EUC-KR")));	
					}else {

						if(fileItem.getSize()>0) {
							int idx = fileItem.getName().lastIndexOf("\\");
							
							if(idx == -1) {
								idx = fileItem.getName().lastIndexOf("/");
							}
							
							String fileName = fileItem.getName().substring(idx+1);
							productVO.setFileName(fileName);
							try {
								File uploadedFile = new File(temDir, fileName);
								fileItem.write(uploadedFile);
							} catch(IOException e) {
								System.out.println(e);
							}
						} else {
							productVO.setFileName("../../images/empty.GIF");
						}
					}
				}
				
				ProductServiceImpl service = new ProductServiceImpl();
				service.addProduct(productVO);
				request.setAttribute("productVO", productVO);
				System.out.println(productVO);
			} else {
				int overSize = (request.getContentLength() / 1000000);
				
				System.out.println("<script>alert('파일의 크기는 1MB까지입니다. 올리신 파일 용량은 "+overSize+"MB 입니다');");
				
				System.out.println("history.back();</script>");
			}
			
		} else {
			System.out.println("인코딩 타입이 muultipart/form-data가 아닙니다");
		}
		
		return "forward:/product/getProduct.jsp";
		
		
		//이미지 업로드 구현 전 코드
		/*
		int price = Integer.parseInt(request.getParameter("price"));
		
		productVO.setProdName(request.getParameter("prodName"));
		productVO.setProdDetail(request.getParameter("prodDetail"));
		productVO.setManuDate(request.getParameter("manuDate"));		
		productVO.setPrice(price);
		productVO.setFileName(request.getParameter("fileName"));
		
		System.out.println(productVO);
		
		ProductService service = new ProductServiceImpl();
		service.addProduct(productVO);
		
		System.out.println(productVO);
		
		request.setAttribute("productVO", productVO);
		
		return "forward:/product/getProduct.jsp";
		*/
	}

}
