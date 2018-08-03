package service;

import dao.impl.InvoiceDaoImpl;
import entity.Invoice;

public class InvoiceService {
    private InvoiceDaoImpl invoiceDao;


    public void saveOrUpdate(Invoice invoice) {
        invoiceDao.saveOrUpdate(invoice);
    }

    public Invoice query(Invoice i) {
        return invoiceDao.query(i);
    }

    public void setInvoiceDao(InvoiceDaoImpl invoiceDao) {
        this.invoiceDao = invoiceDao;
    }
}
