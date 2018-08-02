package dao.impl;

import dao.ProductDao;
import entity.Product;

import java.util.List;

public class ProductDaoImpl extends BaseDaoImpl<Product> implements ProductDao {
    @Override
    public void delete(int id) {

    }

    @Override
    public Product query(Product product) {
        return null;
    }

    @Override
    public List<Product> query() {
        String hql = "From Product p ORDER BY p.id DESC";
        return getSession().createQuery(hql).list();
    }
}
