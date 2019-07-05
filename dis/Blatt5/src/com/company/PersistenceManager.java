package com.company;
import java.util.AbstractMap;
import java.util.Hashtable;
import java.util.Map;

public class PersistenceManager {
    private static PersistenceManager pm;
    private LogWriter logWriter = new LogWriter();
    private PersistenceWriter persistenceWriter = new PersistenceWriter();
    private long transactionCounter = 0;
    private long lsnCounter = 0;

    // Pageid -> TransactionID und Data
    private Hashtable<Integer, Map.Entry<Integer, String>> buffer = new Hashtable<>();

    private PersistenceManager(){
    }

    public static PersistenceManager getPersistenceManager(){
        if (PersistenceManager.pm == null) pm = new PersistenceManager();

        return pm;
    }

    public synchronized long beginTransaction(){
        transactionCounter +=1;
        return transactionCounter;
    }

    /*
        Used for Recovery
     */
    public void commitDirectly(LogEntry le) {
        long currentCounter = lsnCounter;
        lsnCounter = le.getLsn();
        persistenceWriter.writeFile(lsnCounter, le.getPageid(), le.getData());
        logWriter.deleteLog(le.getLsn());
        lsnCounter = currentCounter;
    }
    /*
        Used for Recovery
     */
    public void setLastLsn(long lsn){
        lsnCounter = lsn;
    }

    public synchronized void commit(int taid){
        boolean commit = buffer.size() > 5;

        Hashtable<Integer, Map.Entry<Integer, String>> tmpBuffer = (Hashtable<Integer, Map.Entry<Integer, String>>) buffer.clone();
        for (Map.Entry<Integer, Map.Entry<Integer, String >> entry : tmpBuffer.entrySet()) {
            Map.Entry<Integer, String> content = entry.getValue();
            Integer savedTaid = content.getKey();

            if (taid != savedTaid) continue;

            Integer pageid = entry.getKey();
            String data = content.getValue();
            lsnCounter += 1;

            logWriter.writeLog(lsnCounter, taid, pageid, data);
            if (commit) {
                persistenceWriter.writeFile(lsnCounter, pageid, data);
                logWriter.deleteLog(lsnCounter);
                buffer.remove(pageid);
            }
        }
    }

    public void write(int taid, int pageid, String data){
        Map.Entry<Integer, String> tmp = new AbstractMap.SimpleEntry<>(taid, data);
        buffer.put(pageid, tmp);
    }
}
