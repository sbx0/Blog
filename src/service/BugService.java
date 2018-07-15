package service;

import dao.impl.BugDaoImpl;
import entity.Bug;

import java.text.NumberFormat;
import java.util.List;

public class BugService {
    private BugDaoImpl bugDao;

    public void setBugDao(BugDaoImpl bugDao) {
        this.bugDao = bugDao;
    }

    // 反馈解决率
    public String rate() {
        double newBugsCount = bugDao.countNewBugs();
        double solvedBugsCount = bugDao.countSolvedBugs();
        double all = newBugsCount + solvedBugsCount;
        double rate = solvedBugsCount / all;
        NumberFormat fmt = NumberFormat.getPercentInstance();
        fmt.setMaximumFractionDigits(2);
        String sRate = fmt.format(rate);
        return sRate;
    }

    // 获取提交的反馈
    public List<Bug> getMySubmitBug(int id) {
        return bugDao.getMySubmitBug(id);
    }

    // 获取任务
    public List<Bug> getMyBug(int id) {
        return bugDao.getMyBug(id);
    }

    // 获取未处理的Bug 按重要程度排列
    public List<Bug> getUnprocessed() {
        return bugDao.getUnprocessed();
    }

    // 移除用户信息
    public int removeUser(int id) {
        try {
            bugDao.removeUser(id);
            return 0;
        } catch (Exception e) {
            return 1;
        }
    }

    // 增 / 改
    public void saveOrUpdate(Bug bug) {
        bugDao.saveOrUpdate(bug);
    }

    // 删除
    public void delete(int id) {
        bugDao.delete(id);
    }

    // 查
    public List<Bug> queryAll() {
        return bugDao.queryAll();
    }

    // 按id查询
    public Bug query(int id) {
        return bugDao.query(id);
    }

    // 按名称模糊查询
    public List<Bug> queryByName(String name) {
        return bugDao.queryByName(name);
    }

    // 按分级查询
    public List<Bug> queryByGrade(String grade) {
        return bugDao.queryByGrade(grade);
    }

    // 按上传者查询
    public List<Bug> queryBySubmitterId(int submitter_id) {
        return bugDao.queryBySubmitterId(submitter_id);
    }

    // 按解决者查询
    public List<Bug> queryBySolverId(int solver_id) {
        return bugDao.queryBySolverId(solver_id);
    }

    // 查询未解决的BUG总数
    public int countNewBugs() {
        return bugDao.countNewBugs();
    }

    // 查询已解决的BUG总数
    public int countSolvedBugs() {
        return bugDao.countSolvedBugs();
    }

    // 分页查询
    public List<Bug> queryByPage(int what, int size, int page) {
        String sql = "";
        int allRow = 0;
        if (what == 0) {
            allRow = this.countNewBugs();
            sql = "SELECT b.id,b.name,b.grade,b.submit_time FROM BUGS AS b WHERE b.state = '0' ORDER BY b.id DESC";
        } else if (what == 1) {
            allRow = this.countSolvedBugs();
            sql = "SELECT b.id,b.name,b.grade,b.submit_time FROM BUGS AS b WHERE b.state != '0' ORDER BY b.id DESC";
        }
        int totalPage = allRow % size == 0 ? allRow / size : allRow / size + 1;
        if (page < 0) return null;
        if (page > totalPage) return null;
        int offset = size * (page - 1);
        return bugDao.queryByPage(sql, size, offset);
    }

//    public Bug getDetail(Bug b) {
//        if (b.getGrade().equals("1")) {
//            b.setGrade("建议");
//        } else if (b.getGrade().equals("2")) {
//            b.setGrade("低级");
//        } else if (b.getGrade().equals("3")) {
//            b.setGrade("一般");
//        } else if (b.getGrade().equals("4")) {
//            b.setGrade("严重");
//        } else if (b.getGrade().equals("5")) {
//            b.setGrade("致命");
//        } else {
//            b.setGrade("未知");
//        }
//        if (b.getState().equals("0")) {
//            b.setState("新提交");
//        } else if (b.getState().equals("1")) {
//            b.setState("已处理");
//        } else if (b.getState().equals("2")) {
//            b.setState("重开");
//        } else if (b.getState().equals("3")) {
//            b.setState("关闭");
//        } else {
//            b.setState("未知");
//        }
//        return b;
//    }

}
