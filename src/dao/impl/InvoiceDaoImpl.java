package dao.impl;

import dao.InvoiceDao;
import entity.Invoice;

import java.util.List;

public class InvoiceDaoImpl extends BaseDaoImpl<Invoice> implements InvoiceDao {

    @Override
    public void delete(int id) {

    }

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
