package dao.impl;

import dao.BugDao;
import entity.Bug;

import java.util.List;

public class BugDaoImpl extends BaseDao implements BugDao {

    @Override
    public List<Bug> getMySubmitBug(int id) {
        String hql = "FROM Bug b WHERE b.submitter.user_id = ? AND b.state != ? ORDER BY b.id DESC";
        return getSession().createQuery(hql).setParameter(0, id).setParameter(1, 1).setMaxResults(20).list();
    }

    @Override
    public List<Bug> getMyBug(int id) {
        String hql = "FROM Bug b WHERE b.solver.user_id = ? AND b.state = ? ORDER BY b.grade DESC";
        return getSession().createQuery(hql).setParameter(0, id).setParameter(1, -1).setMaxResults(10).list();
    }

    @Override
    public List<Bug> getUnprocessed() {
        String hql = "FROM Bug b WHERE b.state = ? AND b.solver.user_id = null ORDER BY b.grade DESC";
        return getSession().createQuery(hql).setParameter(0, 0).setMaxResults(20).list();
    }

    @Override
    public void removeUser(int id) {
        String hql = "UPDATE FROM Bug b SET b.submitter.user_id = null WHERE b.submitter.user_id = ?";
        getSession().createQuery(hql).setParameter(0, id).executeUpdate();
        hql = "UPDATE FROM Bug b SET b.solver.user_id = null WHERE b.solver.user_id = ?";
        getSession().createQuery(hql).setParameter(0, id).executeUpdate();
    }

    @Override
    public void saveOrUpdate(Bug bug) {
        getSession().saveOrUpdate(bug);
    }

    @Override
    public void delete(int id) {
        String hql = "DELETE FROM Bug b WHERE B.id = ?";
        getSession().createQuery(hql).setParameter(0, id).executeUpdate();
    }

    @Override
    public List<Bug> queryAll() {
        String sql = "SELECT b.id,b.name,b.grade,b.submit_time FROM BUGS AS b ORDER BY b.id DESC";
        return getSession().createSQLQuery(sql).list();
    }

    @Override
    public Bug query(int id) {
        String hql = "FROM Bug b WHERE b.id = ?";
        return (Bug) getSession().createQuery(hql).setParameter(0, id).uniqueResult();
    }

    @Override
    public List<Bug> queryByName(String name) {
        String hql = "FROM Bug b WHERE b.name LIKE ?";
        return getSession().createQuery(hql).setParameter(0, "%" + name + "%").list();
    }

    @Override
    public List<Bug> queryByGrade(String grade) {
        String hql = "FROM Bug b WHERE b.grade = ?";
        return getSession().createQuery(hql).setParameter(0, grade).list();
    }

    @Override
    public List<Bug> queryBySubmitterId(int submitter_id) {
        String hql = "FROM Bug b WHERE b.submitter.id = ?";
        return getSession().createQuery(hql).setParameter(0, submitter_id).list();
    }

    @Override
    public List<Bug> queryBySolverId(int solver_id) {
        String hql = "FROM Bug b WHERE b.solver.id = ?";
        return getSession().createQuery(hql).setParameter(0, solver_id).list();
    }

    @Override
    public int countNewBugs() {
        String sql = "select count(*) from BUGS where BUGS.state != '1'";
        int count = Integer.parseInt(getSession().createSQLQuery(sql).uniqueResult().toString());
        return count;
    }

    @Override
    public int countSolvedBugs() {
        String sql = "select count(*) from BUGS where BUGS.state = '1'";
        int count = Integer.parseInt(getSession().createSQLQuery(sql).uniqueResult().toString());
        return count;
    }

    @Override
    public List<Bug> queryByPage(String sql, int size, int offset) {
        return getSession().createSQLQuery(sql).setMaxResults(size).setFirstResult(offset).list();
    }
}
