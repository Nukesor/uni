package com.company;

public class Client {
    private PersistenceManager pm = PersistenceManager.getPersistenceManager();
    private long taid;

    public void beginTransaction(){
        taid = pm.beginTransaction();
    }

    public void write(int page, String data) {
        try {
            Thread.sleep(200);
        } catch (InterruptedException e) {
            e.printStackTrace();
        }
        pm.write((int) taid, page, data);
    }

    public void commit(){
        pm.commit((int) taid);
    }
}
