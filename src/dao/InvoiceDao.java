package dao;

import entity.Invoice;

import java.util.List;

public interface InvoiceDao extends BaseDao<Invoice> {
    /**
     * 查询某一用户的关于某一产品的所有收据
     *
     * @param p_id 产品ID
     * @param u_id 用户ID
     * @return 所有符合条件的收据
     */
    List<Invoice> query(int p_id, int u_id);
}