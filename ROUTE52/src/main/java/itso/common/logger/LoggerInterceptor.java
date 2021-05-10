package itso.common.logger;

import java.util.Enumeration;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.handler.HandlerInterceptorAdapter;

public class LoggerInterceptor extends HandlerInterceptorAdapter {
    protected Log log = LogFactory.getLog(LoggerInterceptor.class);
     
    @Override
    public boolean preHandle(HttpServletRequest request, HttpServletResponse response, Object handler) throws Exception {
    	String requestURI = request.getRequestURI();
    	
        if (log.isDebugEnabled()) {
        	String sLog = "[%s] [%s]";
        	String sParams = "";
        	
        	Enumeration<?> params = request.getParameterNames();
        	
        	boolean firstYn = true;
        	while (params.hasMoreElements()){
        		String name = (String) params.nextElement();
        		
        		if(name.equals("_")) {
        			continue;
        		}
        		
        		if(firstYn) {
        			sParams += String.format("%s : %s", name, request.getParameter(name));
        			firstYn = !firstYn;
        		} else {
        			sParams += String.format(", %s : %s", name, request.getParameter(name));
        		}
            }
        	
            log.debug(String.format(sLog, requestURI, sParams));
        }
        
        return super.preHandle(request, response, handler);
    }
     
    @Override
    public void postHandle(HttpServletRequest request, HttpServletResponse response, Object handler, ModelAndView modelAndView) throws Exception {
        if (log.isDebugEnabled()) {
            
        }
    }
}

