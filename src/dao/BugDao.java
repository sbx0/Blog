package dao;

import entity.Bug;

import java.util.List;

public interface BugDao {

    // 获取提交的反馈
    public List<Bug> getMySubmitBug(int id);

    // 获取任务
    public List<Bug> getMyBug(int id);

    // 获取未处理的Bug 按重要程度排序
    public List<Bug> getUnprocessed();

    // 移除用户信息
    public void removeUser(int id);

    // 增 / 改
    public void saveOrUpdate(Bug bug);

    // 删除
    public void delete(int id);

    // 查
    // 查全部
    public List<Bug> queryAll();

    // 按id查询
    public Bug query(int id);

    // 按名称模糊查询
    public List<Bug> queryByName(String name);

    // 按分级查询
    public List<Bug> queryByGrade(String grade);

    // 按上传者查询
    public List<Bug> queryBySubmitterId(int submitter_id);

    // 按解决者查询
    public List<Bug> queryBySolverId(int solver_id);

    // 查询未解决的BUG总数
    public int countNewBugs();

    // 查询已解决的BUG总数
    public int countSolvedBugs();

    // 分页查询
    public List<Bug> queryByPage(String sql, int size, int offset);
}
