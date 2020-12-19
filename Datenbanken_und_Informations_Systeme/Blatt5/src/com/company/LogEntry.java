package com.company;
public class LogEntry {
    private long lsn;
    private int taid;
    private int pageid;
    private String data;


    public long getLsn() {
        return lsn;
    }

    public void setLsn(long lsn) {
        this.lsn = lsn;
    }

    public int getTaid() {
        return taid;
    }

    public void setTaid(int taid) {
        this.taid = taid;
    }

    public int getPageid() {
        return pageid;
    }

    public void setPageid(int pageid) {
        this.pageid = pageid;
    }

    public String getData() {
        return data;
    }

    public void setData(String data) {
        this.data = data;
    }
}
