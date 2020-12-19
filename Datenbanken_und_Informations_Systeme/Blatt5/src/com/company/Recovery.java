package com.company;
import java.io.*;
import java.util.ArrayList;
import java.util.List;

public class Recovery {
    PersistenceManager pm = PersistenceManager.getPersistenceManager();
    private BufferedReader fr;
    private File log = new File("log.txt");

    public Recovery(){
        try {
            fr = new BufferedReader(new FileReader(log));
        } catch (IOException e) {
            e.printStackTrace();
        }
    }

    public void recover(){
        List<LogEntry> recoveryLogs = new ArrayList<>();

        try {
            String currentLine;
            while ((currentLine = fr.readLine()) != null) {
                currentLine = currentLine.trim();
                String[] params = currentLine.split(",");

                LogEntry le = new LogEntry();
                le.setLsn(Long.parseLong(params[0].substring(1)));
                le.setTaid(Integer.parseInt(params[1]));
                le.setPageid(Integer.parseInt(params[2]));
                le.setData(params[3]);

                recoveryLogs.add(le);
            }
        } catch (IOException e){
            e.printStackTrace();
        }

        for (LogEntry le : recoveryLogs) {
            pm.commitDirectly(le);
        }
        log.delete();
    }
}
