package com.company;

import java.io.File;
import java.io.FileWriter;
import java.io.IOException;

public class PersistenceWriter {
    private FileWriter fw;

    public PersistenceWriter(){
        File dir = new File("db");
        dir.mkdir();
    }

    public void writeFile(long lsn, int pageid, String data) {
        File databaseEntry = new File("./db/" + pageid + ".txt");
        try {
            fw = new FileWriter(databaseEntry);
            fw.write(lsn + "," + data);
            fw.close();
        } catch (IOException e) {
            e.printStackTrace();
        }
        // Filename = pageid

    }
}
