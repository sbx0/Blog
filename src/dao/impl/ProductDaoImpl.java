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
        String hql;
        if (product.getId() > 0) {
            hql = "From Product p Where p.id = ?";
            return (Product) getSession().createQuery(hql)
                    .setParameter(0, product.getId())
                    .uniqueResult();
        } else if (product.getName() != "" || product.getName() != null) {
            hql = "From Product p Where p.name = ?";
            return (Product) getSession().createQuery(hql)
                    .setParameter(0, product.getName())
                    .uniqueResult();
        } else {
            return null;
        }
    }

    @Override
    public List<Product> query() {
        String hql = "From Product p ORDER BY p.id DESC";
        return getSession().createQuery(hql).list();
    }
}
