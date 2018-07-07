package dao.impl;

import org.hibernate.Session;
import org.hibernate.SessionFactory;

/**
 * Created by sbx0 on 2017/5/3.
 */
public class BaseDao {
    private SessionFactory sessionFactory;

    public Session getSession() {
        return this.sessionFactory.getCurrentSession();
    }

    public void setSessionFactory(SessionFactory sessionFactory) {
        this.sessionFactory = sessionFactory;
    }
}
