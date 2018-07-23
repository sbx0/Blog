package service;

import dao.impl.BugDaoImpl;
import entity.Bug;
import net.sf.json.JSONObject;

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
            sql = "SELECT b.id,b.name,b.grade,b.state FROM BUGS AS b WHERE b.state != '1' ORDER BY b.id DESC";
        } else if (what == 1) {
            allRow = this.countSolvedBugs();
            sql = "SELECT b.id,b.name,b.grade,b.state FROM BUGS AS b WHERE b.state = '1' ORDER BY b.id DESC";
        }
        int totalPage = allRow % size == 0 ? allRow / size : allRow / size + 1;
        if (page < 0) return null;
        if (page > totalPage) return null;
        int offset = size * (page - 1);
        return bugDao.queryByPage(sql, size, offset);
    }

    // toJson
    public JSONObject toJson(Bug bug) {
        JSONObject jsonBug = new JSONObject();
        jsonBug.put("id", bug.getId());
        jsonBug.put("name", bug.getName());
        jsonBug.put("grade", bug.getGrade());
        jsonBug.put("state", bug.getState());
        return jsonBug;
    }

    // 将分级转化成文字
    public String gradeToString(int num) {
        String grade;
        switch (num) {
            case 1:
                grade = "建议";
                break;
            case 2:
                grade = "低级";
                break;
            case 3:
                grade = "一般";
                break;
            case 4:
                grade = "严重";
                break;
            case 5:
                grade = "致命";
                break;
            default:
                grade = "未知";
        }
        return grade;
    }

    // 将状态转化成文字
    public String stateToString(int num) {
        String state;
        switch (num) {
            case 0:
                state = "新提交";
                break;
            case 1:
                state = "已处理";
                break;
            case 2:
                state = "重开";
                break;
            case 3:
                state = "关闭";
                break;
            default:
                state = "未知";
        }
        return state;
    }

}
