package spring.service.product;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Mapper;

import spring.domain.Product;
import spring.domain.Search;



// ��ǰ���� CRUD �߻�ȭ/ĸ��ȭ�� DAO Interface Definition
@Mapper
public interface ProductDao {

	//INSERT
	public void addProduct(Product product) throws Exception;
	
	//SELECT ONE
	public Product getProduct(int prodNo) throws Exception;
	
	//SELECT LIST
	public List<Product> getProductList(Search search) throws Exception;
	
	//UPDATE
	public void updateProduct(Product product) throws Exception;
	
	//�������ø�
	public List<Map<String, Object>> autoComplete(Map<String, Object> params) throws Exception;
	
	//������ ����
	public int getTotalCount(Search search) throws Exception;
	
	//��ǰ���ϱ�
	public void updateDibProduct(Product product) throws Exception;
	
	//���Ѹ��
	public List<Object> getDibProductList(Search search, String userId) throws Exception;
	
}
