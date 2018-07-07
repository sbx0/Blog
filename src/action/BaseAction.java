package action;

import com.opensymphony.xwork2.ActionSupport;
import net.sf.json.JSONObject;
import org.apache.struts2.interceptor.RequestAware;
import org.apache.struts2.interceptor.ServletResponseAware;
import org.apache.struts2.interceptor.SessionAware;
import org.apache.struts2.util.ServletContextAware;

import javax.servlet.ServletContext;
import javax.servlet.http.HttpServletResponse;
import java.util.Map;

public class BaseAction extends ActionSupport implements ServletContextAware,ServletResponseAware, RequestAware, SessionAware {
    public ServletContext context;
    public HttpServletResponse response;
    private Map<String, Object> request;
    private Map<String, Object> session;
    private JSONObject json = new JSONObject();

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