package action;

import entity.Bug;
import entity.Message;
import entity.User;
import net.sf.json.JSONArray;

import java.util.Date;
import java.util.List;

public class BugAction extends BaseAction {
    private Bug bug;
    private String par;
    private int page;
    private int what;
    private int id;
    private final int pageSize = 10;

    public String job() {
        User user = (User) getSession().get("user");
        if (user != null && user.getUser_is_admin() == 1) {
            int id = Integer.parseInt(par.trim());
            bug = bugService.query(id);
            if (bug.getSolver() == null) {
                // 接受任务
                bug.setSolver(user);
                bug.setReplay(null);
                bug.setSolve_time(null);
                bug.setState(-1);
            } else if (bug.getSolver().getUser_id() == user.getUser_id()) {
                // 放弃任务
                bug.setSolver(null);
                bug.setReplay(null);
                bug.setSolve_time(null);
                bug.setState(0);
            }
            try {
                bugService.saveOrUpdate(bug);
                getJson().put("state", 0);
            } catch (Exception e) {
                getJson().put("state", 1);
            }
        } else {
            getJson().put("state", 1);
        }
        return "json";
    }

    public String check() {
        User user = (User) getSession().get("user");
        if (user != null && user.getUser_is_admin() == 1) {
            int id = Integer.parseInt(par.trim());
            bug = bugService.query(id);
            if (bug.getState() != 1) {
                if (bug.getSolver() == null) getJson().put("solve_state", -1);
                else if (user.getUser_id() == bug.getSolver().getUser_id()) getJson().put("solve_state", 0);
                else getJson().put("solve_state", 1);
            } else {
                getJson().put("solve_state", 2);
            }
            getJson().put("state", 0);
        } else {
            getJson().put("state", 1);
        }
        return "json";
    }

    public String rate() {
        getJson().put("rate", bugService.rate());
        return "json";
    }

    public String mission() {
        User user = (User) getSession().get("user");
        if (user != null && user.getUser_is_admin() == 1) {
            List<Bug> bugs = bugService.getMyBug(user.getUser_id());
            JSONArray jsonArray = new JSONArray();
            for (int i = 0; i < bugs.size(); i++) {
                jsonArray.element(bugService.toJson(bugs.get(i)));
            }
            getJson().put("bugs", jsonArray);
            getJson().put("state", 0);
        } else {
            getJson().put("state", 1);
        }
        return "json";
    }

    public String my() {
        User user = (User) getSession().get("user");
        if (user != null) {
            List<Bug> bugs = bugService.getMySubmitBug(user.getUser_id());
            JSONArray jsonArray = new JSONArray();
            for (int i = 0; i < bugs.size(); i++) {
                jsonArray.element(bugService.toJson(bugs.get(i)));
            }
            getJson().put("bugs", jsonArray);
            getJson().put("state", 0);
        } else {
            getJson().put("state", 1);
        }
        return "json";
    }

    public String get() {
        User user = (User) getSession().get("user");
        if (user != null && user.getUser_is_admin() == 1) {
            List<Bug> bugs = bugService.getUnprocessed();
            JSONArray jsonArray = new JSONArray();
            for (int i = 0; i < bugs.size(); i++) {
                jsonArray.element(bugService.toJson(bugs.get(i)));
            }
            getJson().put("bugs", jsonArray);
            getJson().put("state", 0);
        } else {
            getJson().put("state", 1);
        }
        return "json";
    }

    public String solve() {
        User user = (User) getSession().get("user");
        if (user != null && user.getUser_is_admin() == 1) {
            try {
                Bug b = bugService.query(bug.getId());
                if (bug.getState() != 2) b.setState(bug.getState());
                if (bug.getGrade() != 0) b.setGrade(bug.getGrade());
                if (bug.getReplay().trim().length() != 0 && bug.getReplay() != null) {
                    b.setReplay(bug.getReplay().trim());
                    b.setSolver(user);
                }
                if (bug.getState() != 1) b.setSolve_time(null);
                if (bug.getState() == 0) b.setSolver(null);
                if (bug.getState() == 1) {
                    Date date = new Date();
                    b.setSolve_time(date);
                    if (b.getSubmitter() != null) {
                        // 提示提交者反馈已被解决
                        Message message = new Message();
                        String m = "您的反馈 <a href=\"b?id=" + b.getId() + "\">" + b.getName() + "</a> 已被解决";
                        message.setContent(m);
                        message.setSendTime(new Date());
                        message.setSendUser(b.getSubmitter());
                        message.setReceiveUser(b.getSubmitter());
                        message.setIsRead(0);
                        message.setType(0);
                        messageService.send(message);
                    }
                }
                bugService.saveOrUpdate(b);
                getJson().put("state", 0);
            } catch (Exception e) {
                getJson().put("state", 2);
                e.printStackTrace();
            }
        } else {
            getJson().put("state", 1);
        }
        return "json";
    }

    public String submit() {
        User user = (User) getSession().get("user");
        try {
            bug.setSubmit_time(new Date());
            bug.setState(0);
            bug.setSubmitter(user);
            bugService.saveOrUpdate(bug);
            getJson().put("state", 0);
        } catch (Exception e) {
            getJson().put("state", 2);
            e.printStackTrace();
        }
        return "json";
    }

    public String list() {
        List<Bug> bugs = bugService.queryByPage(what, pageSize, page);
        getJson().put("bugs", bugs);
        return "json";
    }

    public String one() {
        Bug b = bugService.query(id);
        if (b == null) return "error";
        else {
            getRequest().put("bug", b);
            return "one";
        }
    }

    public Bug getBug() {
        return bug;
    }

    public void setBug(Bug bug) {
        this.bug = bug;
    }

    public String getPar() {
        return par;
    }

    public void setPar(String par) {
        this.par = par;
    }

    public int getPage() {
        return page;
    }

    public void setPage(int page) {
        this.page = page;
    }

    public int getWhat() {
        return what;
    }

    public void setWhat(int what) {
        this.what = what;
    }

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public int getPageSize() {
        return pageSize;
    }
}
