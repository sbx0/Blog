package entity;

import java.util.*;

/*
    bug实体类
 */
public class Bug {
    private Integer id;
    private String name;
    private Integer grade; // 评级
    private Integer state; // 状态 -1 处理中 0 新提交 1 已处理
    private String bewrite; // 描述
    private String replay; // 解决者回复
    private Date submit_time; // 提交时间
    private Date solve_time; // 解决时间
    private User submitter; // 提交者
    private User solver; // 解决者

    public Integer getId() {
        return id;
    }

    public void setId(Integer id) {
        this.id = id;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public Integer getGrade() {
        return grade;
    }

    public void setGrade(Integer grade) {
        this.grade = grade;
    }

    public Integer getState() {
        return state;
    }

    public void setState(Integer state) {
        this.state = state;
    }

    public String getBewrite() {
        return bewrite;
    }

    public void setBewrite(String bewrite) {
        this.bewrite = bewrite;
    }

    public String getReplay() {
        return replay;
    }

    public void setReplay(String replay) {
        this.replay = replay;
    }

    public Date getSubmit_time() {
        return submit_time;
    }

    public void setSubmit_time(Date submit_time) {
        this.submit_time = submit_time;
    }

    public Date getSolve_time() {
        return solve_time;
    }

    public void setSolve_time(Date solve_time) {
        this.solve_time = solve_time;
    }

    public User getSubmitter() {
        return submitter;
    }

    public void setSubmitter(User submitter) {
        this.submitter = submitter;
    }

    public User getSolver() {
        return solver;
    }

    public void setSolver(User solver) {
        this.solver = solver;
    }

    public Bug() {
        super();
    }

    public Bug(String name, Integer grade, Integer state, String bewrite, String replay, Date submit_time, Date solve_time, User submitter, User solver) {
        this.name = name;
        this.grade = grade;
        this.state = state;
        this.bewrite = bewrite;
        this.replay = replay;
        this.submit_time = submit_time;
        this.solve_time = solve_time;
        this.submitter = submitter;
        this.solver = solver;
    }

    @Override
    public String toString() {
        return "Bug{" +
                "id=" + id +
                ", name='" + name + '\'' +
                ", grade='" + grade + '\'' +
                ", state='" + state + '\'' +
                ", bewrite='" + bewrite + '\'' +
                ", replay='" + replay + '\'' +
                ", submit_time=" + submit_time +
                ", solve_time=" + solve_time +
                ", submitter=" + submitter +
                ", solver=" + solver +
                '}';
    }
}
