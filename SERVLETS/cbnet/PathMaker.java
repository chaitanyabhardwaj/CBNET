package cbnet;

import java.io.*;

public class PathMaker {
    
    public boolean makeNewFolder(String path)throws IOException, InterruptedException { //Assumes 'path' to be absolute
        path = path.trim();
        String folderNames[] = path.split("/"), str = "";
        Process p;
        File folder;
        for(String name : folderNames) {
            str += name;
            p = Runtime.getRuntime().exec("chown tomcat8:tomcat8 /" + str);
            p.waitFor();
            p = Runtime.getRuntime().exec("chmod u+rwx /" + str);
            p.waitFor();
        }
        folder = new File(path);
        return folder.mkdir();
    }
    
    public boolean makeNewFolder(String from, String path)throws IOException, InterruptedException { //Assumes 'path' to be relative to 'from'
        from = from.trim();
        Process p = Runtime.getRuntime().exec("cd " + from);
        return makeNewFolder(path);
    }
    
}
