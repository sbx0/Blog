package service;

import dao.impl.ProductDaoImpl;
import entity.Product;

import java.util.List;

public class ProductService {
    private ProductDaoImpl productDao;

    public List<Product> query() {
        return productDao.query();
    }

    public void saveOrUpdate(Product p) {
        productDao.saveOrUpdate(p);
    }

    public void setProductDao(ProductDaoImpl productDao) {
        this.productDao = productDao;
    }

}
