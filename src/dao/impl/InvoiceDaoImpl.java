package dao.impl;

import dao.InvoiceDao;
import entity.Invoice;

import java.util.List;

public class InvoiceDaoImpl extends BaseDaoImpl<Invoice> implements InvoiceDao {

    /**
     * 查询某一用户的关于某一产品的所有收据
     *
     * @param p_id 产品ID
     * @param u_id 用户ID
     * @return 所有符合条件的收据
     */
    @Override
    public List<Invoice> query(int p_id, int u_id) {
        String hql = "From Invoice i Where i.product.id = ? And i.buyer.user_id = ?";
        return getSession().createQuery(hql)
                .setParameter(0, p_id)
                .setParameter(1, u_id)
                .list();
    }

    @Override
    public void delete(int id) {

    }

    /**
     * 查询某一收据
     *
     * @param invoice 传入的收据，可根据其不为null的字段查询
     * @return 唯一收据
     */
    @Override
    public Invoice query(Invoice invoice) {
        String hql;
        if (invoice.getId() > 0) {
            hql = "From Invoice i Where i.id = ?";
            return (Invoice) getSession().createQuery(hql)
                    .setParameter(0, invoice.getId())
                    .uniqueResult();
        } else if (invoice.getName() != "" || invoice.getName() != null) {
            hql = "From Invoice i Where i.name = ?";
            return (Invoice) getSession().createQuery(hql)
                    .setParameter(0, invoice.getName())
                    .uniqueResult();
        } else {
            return null;
        }
    }

    @Override
    public List<Invoice> query() {
        return null;
    }

}
