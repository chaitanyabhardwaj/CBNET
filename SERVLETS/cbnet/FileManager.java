package cbnet;

import java.io.*;
import java.text.DateFormat;
import java.text.SimpleDateFormat;
import java.util.Date;

public class FileManager {
    
    final public static int MESSAGE_SEND = 0, MESSAGE_RECEIVE = 1, USER_CREATED = 2, USER_EXSISTS = 3;
    final private static String PATH = "/var/lib/CBNET_user_directory/";
    
    public void writeMessage(int type, String msg, String senderID, String receiverID)throws UnknownTypeException, 
            IOException {
        File folder,file,counter;
        switch (type) {
            case MESSAGE_SEND:
                folder = makeDir(PATH +"messages/"+ senderID +"/sent/"+ receiverID +"/");
                file = new File(folder,"messages.txt");
                write(file,msg);
                break;
            case MESSAGE_RECEIVE:
                folder = makeDir(PATH +"messages/"+ receiverID +"/received/"+ senderID +"/");
                file = new File(folder,"messages_new.txt");
                counter = new File(folder,"count_messages.txt");
                write(file,msg);
                rewrite(counter,"NEW");
                break;
            default:
                throw new UnknownTypeException("The Integer type given in the parameters of the method"
                        + " \'store(int,String,String)\' is incorrect. Use the public static members of "
                        + "FileManager class");
        }
    }
    
    public String readMessage(String senderID, String receiverID)throws IOException {
        File folder = new File(PATH +"messages/"+ receiverID +"/received/"+ senderID +"/");
        if(!folder.exists())
            return null;
        File file = new File(folder,"messages_new.txt");
        String message = read(file);
        if(message == null)
            return null;
        clear(file);
        return message;
    }
    
    public boolean hasNewMessage(String senderID, String receiverID)throws IOException {
        File folder = new File(PATH +"messages/"+ receiverID +"/received/"+ senderID +"/");
        if(!folder.exists())
            return false;
        File file = new File(folder, "count_messages.txt");
        if(!folder.exists()) {
            log("Error Type : RARE. File empty. Filename : " + file.getName() + ". File directory : " 
                    + file.getAbsolutePath());
            return false;
        }
        return (read(file).equals("NEW"));
    }
    
    public String[] listUnreadMessages(String receiverID)throws IOException {
        int count = 0;
        File folder = new File(PATH +"messages/"+ receiverID +"/received/");
        if(!folder.exists())
            return null;
        String innerFolderNames[] = listFileNames(folder);
        String newM[] = new String[innerFolderNames.length];
        for(String name : innerFolderNames) {
            if(hasNewMessage(name,receiverID)) {
                newM[count] = name;
                count++;
            }
        }
        return newM;
    }
    
    public String[] listFileNames(File folder) throws IOException {
        File files[] = folder.listFiles();
        String names[] = new String[files.length];
        int i = 0;
        for(File f : files) {
            names[i] = f.getName();
        }
        return names;
    }
    
    public void rewrite(File file, String str)throws IOException {
        if(!file.exists())
            file.createNewFile();
        BufferedWriter bw = new BufferedWriter(new FileWriter(file));
        bw.write(str);
        bw.flush();
        bw.close();
    }
    
    public void write(File file, String str)throws IOException {
        if(!file.exists())
            file.createNewFile();
        BufferedWriter bw = new BufferedWriter(new FileWriter(file));
        bw.append(str);
        bw.append("\n");
        bw.flush();
        bw.close();
    }
    
    public void write(String path, String str)throws IOException {
        File file = new File(path);
        write(file,str);
    }
    
    public String read(File file)throws IOException {
        if(!file.exists())
            return null;
        BufferedReader reader = new BufferedReader(new FileReader(file));
        String r,msg = "";
        while((r = reader.readLine())!= null)
            msg += r;
        msg = msg.trim();
        if(msg.equals("")) {
            log("Error Type : RARE. File empty. Filename : " + file.getName() + ". File directory : " 
                    + file.getAbsolutePath());
            return null;
        }
        return msg;
    }
    
    public String read(String path)throws IOException {
        File file = new File(path);
        return read(file);
    }
    
    public void remove(File file)throws IOException {
        if(!file.exists())
            file.delete();
    }
    
    public void remove(String path)throws IOException {
        File file = new File(path);
        remove(file);
    }
    
    public void clear(File file)throws IOException {
        FileWriter fw = new FileWriter(file);
        fw.write("");
        fw.flush();
        fw.close();
    }
    
    public void clear(String path)throws IOException {
        File file = new File(path);
        clear(file);
    }
    
    public File makeDir(String path)throws IOException {
        String parts[] = path.split("/");
        parts[0] = "/" + parts[0];
        File d = null;
        String p ="";
        for(String pname : parts) {
            p = p + pname + "/";
            d = new File(p);
            if(!d.exists())
                d.mkdir();
        }
        return d;
    }
    
    public File makeDir(File folder)throws IOException {
        String path = folder.getAbsolutePath();
        return makeDir(path);
    }
    
    public int createUser(String userID, String passwd)throws IOException {
        File folder = makeDir(PATH + "users/");
        File file = new File(folder,userID +".txt");
        if(file.exists()) {
            log("User Event : Logged In. UserID : " + userID);
            return USER_EXSISTS;
        }
        write(file,passwd);
        log("User Event : Signed In. UserID :" + userID);
        return USER_CREATED;
    }
    
    public boolean validatePassword(String userID, String passwd)throws IOException {
        File file = new File(PATH + "users/" + userID +".txt");
        return (passwd.equals(read(file)));
    }
    
    private void log(String str) {
        File folder = null;
        try {
            folder = makeDir(PATH + "logs/");
        }
        catch(IOException ex) {
            ex.printStackTrace();
        }
        File file = new File(folder,"log.txt");
        DateFormat df = new SimpleDateFormat("dd/MM/yyyy HH:mm:ss");
        str = df.format(new Date()) + " - " + str;
        try{
            write(file,str);
        }
        catch(IOException ex) {
            ex.printStackTrace();
        }
    }
    
}
