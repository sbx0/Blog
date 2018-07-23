package action;

import entity.Bug;
import entity.User;
import net.sf.json.JSONArray;
import service.BugService;

import java.util.Date;
import java.util.List;

public class BugAction extends BaseAction {
    private BugService bugService;
    private Bug bug;
    private String par;
    private int page;
    private int what;
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
                    Date date = new Date();
                    b.setSolve_time(date);
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
        Bug b = bugService.query(Integer.parseInt(par));
        if (b == null) return "error";
        else {
            getRequest().put("bug", b);
            return "one";
        }
    }

    public void setWhat(int what) {
        this.what = what;
    }

    public int getWhat() {
        return what;
    }

    public int getPage() {
        return page;
    }

    public void setPage(int page) {
        this.page = page;
    }

    public String getPar() {
        return par;
    }

    public void setPar(String par) {
        this.par = par;
    }

    public void setBugService(BugService bugService) {
        this.bugService = bugService;
    }

    public Bug getBug() {
        return bug;
    }

    public void setBug(Bug bug) {
        this.bug = bug;
    }
}
