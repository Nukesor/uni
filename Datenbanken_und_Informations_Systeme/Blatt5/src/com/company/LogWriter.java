package com.company;

import java.io.*;
import java.util.ArrayList;
import java.util.List;

public class LogWriter {
    private FileWriter fw;
    private File log = new File("log.txt");

    private BufferedWriter tmpLogWriter;
    private BufferedReader fr;

    public LogWriter(){
        try {
            fw = new FileWriter(log, true);
        } catch (IOException e) {
            e.printStackTrace();
        }
    }

    public void writeLog(long lsn, int taid, int pageid, String data) {
        try {
            fw.write("L" + lsn + "," + taid + "," + pageid + "," + data + "\n");
            fw.flush();
        } catch (IOException e) {
            e.printStackTrace();
        }
    }

    public void deleteLog(long lsn) {
        try {
            fr = new BufferedReader(new FileReader(log));
        } catch (IOException e) {
            e.printStackTrace();
        }

        List<String> lines = new ArrayList<>();
        String currentLine;
        try {
            while ((currentLine = fr.readLine()) != null) {
                if (currentLine.contains("L"+lsn+",")) continue;

                lines.add(currentLine);
            }

            tmpLogWriter = new BufferedWriter(new FileWriter(log, false));
            for (String line : lines){
                tmpLogWriter.write(line + "\n");
            }

            fr.close();
            tmpLogWriter.close();


        } catch (IOException e){
            e.printStackTrace();
        }
    }
}
