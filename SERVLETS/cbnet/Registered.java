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
        String nom[] = manager.listUnreadMessages(username);
        if(manager.createUser(username,passwd) == FileManager.USER_CREATED)
            view = req.getRequestDispatcher("new_home.jsp");
        else {
            if(manager.validatePassword(username,passwd)) {
                if(nom != null)
                    req.setAttribute("message-count", nom.length);
                else
                    req.setAttribute("message-count", 0);
                view = req.getRequestDispatcher("home.jsp");
            }
            else {
                view = req.getRequestDispatcher("login1.jsp");
            }
        }
        view.forward(req,res);
    }
    
}
