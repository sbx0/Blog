package action;

import entity.Bug;
import entity.User;
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

    public String get() {
        User user = (User) getSession().get("user");
        if (user != null && user.getUser_is_admin() == 1) {
            bug = bugService.getUnprocessed();
            getJson().put("id", bug.getId());
            getJson().put("name", bug.getName());
            getJson().put("grade", bug.getGrade());
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
                b.setState(bug.getState());
                b.setReplay(bug.getReplay());
                b.setSolver(user);
                Date date = new Date();
                b.setSolve_time(date);
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
        getRequest().put("bug", b);
        return "one";
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
