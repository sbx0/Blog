package service;

import dao.impl.InvoiceDaoImpl;
import entity.Invoice;

import java.util.List;

public class InvoiceService {
    private InvoiceDaoImpl invoiceDao;

    /**
     * 判断用户已购买的某一产品的总数，用于检验限制购买数
     *
     * @param p_id 产品ID
     * @param u_id 用户ID
     * @return 总数
     */
    public int countHaveProduct(int p_id, int u_id) {
        // 所有符合条件的收据list
        List<Invoice> invoices = invoiceDao.query(p_id, u_id);
        // 统计所有收据中的number字段
        int count = 0;
        for (int i = 0; i < invoices.size(); i++) {
            count += invoices.get(i).getNumber();
        }
        if (count < 0) count = 0;
        return count;
    }

    /**
     * 保存 或 修改 收据
     *
     * @param invoice 收据
     */
    public void saveOrUpdate(Invoice invoice) {
        invoiceDao.saveOrUpdate(invoice);
    }

    /**
     * 查询某一收据
     *
     * @param i 传入的收据，可根据其不为null的字段查询
     * @return 唯一收据
     */
    public Invoice query(Invoice i) {
        return invoiceDao.query(i);
    }

    public void setInvoiceDao(InvoiceDaoImpl invoiceDao) {
        this.invoiceDao = invoiceDao;
    }
}
