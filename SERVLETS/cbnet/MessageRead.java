package cbnet;

import java.io.*;
import javax.servlet.http.*;
import javax.servlet.*;

public class MessageRead extends HttpServlet{
    
    @Override
    public void doPost(HttpServletRequest req, HttpServletResponse res)throws IOException, ServletException {
        String sender, receiver, message = "";
        sender = req.getParameter("senderID");
        receiver = req.getParameter("receiverID");
        FileManager manager = new FileManager();
        if(manager.hasNewMessage(sender, receiver)) {
            message = manager.readMessage(sender, receiver);
            if(message == null)
                message = "";
        }
        message = message.trim();
        req.setAttribute("message", message);
        RequestDispatcher view;
        if(message.equals(""))
            view = req.getRequestDispatcher("nomessage.html");
        else
            view = req.getRequestDispatcher("readmessages.jsp");
        view.forward(req, res);
    }
    
}
