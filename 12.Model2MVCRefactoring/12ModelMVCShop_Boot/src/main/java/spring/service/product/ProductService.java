package spring.service.product;

import java.util.List;
import java.util.Map;

import spring.domain.Product;
import spring.domain.Search;



public interface ProductService {

	//��ǰ���
	public void addProduct(Product product) throws Exception;
	
	//��ǰ�˻�
	public Product getProduct(int prodNo) throws Exception;
	
	//��ǰ����Ʈ
	public Map<String, Object> getProductList(Search search) throws Exception;
	
	//��ǰ���� ����
	public void updateProduct(Product product) throws Exception;
	
	//�������ø�
	public List<Map<String, Object>> autoComplete(Map<String, Object> parmas) throws Exception;
	
	//��ǰ���ϱ�
	public void updateDibProduct(Product product) throws Exception;
	
	//���Ѹ��
	public Map<String, Object> getDibProductList(Search search, String userId) throws Exception;
	
}
