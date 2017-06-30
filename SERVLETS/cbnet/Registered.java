package cbnet;

import java.io.*;
import javax.servlet.http.*;
import javax.servlet.*;

public class Registered extends HttpServlet {
    
    @Override
    public void doPost(HttpServletRequest req, HttpServletResponse res)throws IOException, ServletException {
        String username,passwd;
        username = req.getParameter("username");
        passwd = req.getParameter("passwd");
        FileManager manager = new FileManager();
        RequestDispatcher view;
        req.setAttribute("username", username);
        if(manager.createUser(username,passwd) == FileManager.USER_CREATED)
            view = req.getRequestDispatcher("new_home.jsp");
        else {
            if(manager.validatePassword(username,passwd)) {
                req.setAttribute("message-count", manager.listUnreadMessages(username).length);
                view = req.getRequestDispatcher("home.jsp");
            }
            else {
                view = req.getRequestDispatcher("login1.jsp");
            }
        }
        view.forward(req,res);
    }
    
}
