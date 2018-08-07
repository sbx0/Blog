package action;

import com.opensymphony.xwork2.ActionSupport;
import entity.User;
import net.sf.json.JSONObject;
import org.apache.struts2.interceptor.RequestAware;
import org.apache.struts2.interceptor.ServletResponseAware;
import org.apache.struts2.interceptor.SessionAware;
import org.apache.struts2.util.ServletContextAware;
import service.*;

import javax.servlet.ServletContext;
import javax.servlet.http.HttpServletResponse;
import java.util.Map;

public class BaseAction extends ActionSupport implements ServletContextAware, ServletResponseAware, RequestAware, SessionAware {
    protected ServletContext context;
    protected HttpServletResponse response;
    private Map<String, Object> request;
    private Map<String, Object> session;
    private JSONObject json = new JSONObject();
    protected UserService userService;
    protected ArticleService articleService;
    protected CommentService commentService;
    protected MessageService messageService;
    protected StatusService statusService;
    protected DataService dataService;
    protected CodeService codeService;
    protected BugService bugService;
    protected InvoiceService invoiceService;
    protected ProductService productService;
    protected TagService tagService;
    protected TagLinkService tagLinkService;

    // 是否登陆
    protected boolean isLogin() {
        User user = (User) getSession().get("user");
        if (user != null) return true;
        else return false;
    }

    // 获取登陆的用户
    protected User loginUser() {
        User user = (User) getSession().get("user");
        if (user != null) return userService.getUser(user.getUser_id());
        else return null;
    }

    public void setTagService(TagService tagService) {
        this.tagService = tagService;
    }

    public void setTagLinkService(TagLinkService tagLinkService) {
        this.tagLinkService = tagLinkService;
    }

    public void setInvoiceService(InvoiceService invoiceService) {
        this.invoiceService = invoiceService;
    }

    public void setProductService(ProductService productService) {
        this.productService = productService;
    }

    public void setArticleService(ArticleService articleService) {
        this.articleService = articleService;
    }

    public void setCommentService(CommentService commentService) {
        this.commentService = commentService;
    }

    public void setMessageService(MessageService messageService) {
        this.messageService = messageService;
    }

    public void setStatusService(StatusService statusService) {
        this.statusService = statusService;
    }

    public void setDataService(DataService dataService) {
        this.dataService = dataService;
    }

    public void setCodeService(CodeService codeService) {
        this.codeService = codeService;
    }

    public void setBugService(BugService bugService) {
        this.bugService = bugService;
    }

    public void setUserService(UserService userService) {
        this.userService = userService;
    }

    public void setJson(JSONObject json) {
        this.json = json;
    }

    public JSONObject getJson() {
        return json;
    }

    public void setRequest(Map<String, Object> request) {
        this.request = request;
    }

    public Map<String, Object> getRequest() {
        return request;
    }

    public void setSession(Map<String, Object> session) {
        this.session = session;
    }

    public Map<String, Object> getSession() {
        return session;
    }

    @Override
    public void setServletResponse(HttpServletResponse httpServletResponse) {
        this.response = httpServletResponse;
    }

    @Override
    public void setServletContext(ServletContext servletContext) {
        this.context = servletContext;
    }
}