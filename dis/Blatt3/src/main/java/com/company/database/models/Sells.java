package com.company.database.models;


import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.Id;

@Entity
public class Sells {
  public Sells(){}
  public Sells(long eid, long cid, long pid){
    this.eid = eid;
    this.cid = cid;
    this.pid = pid;
  }

  @Column(name = "EID")
  private long eid;

  @Id
  @Column(name = "CID")
  private long cid;

  @Column(name = "PID")
  private long pid;


  public long getEid() {
    return eid;
  }

  public void setEid(long eid) {
    this.eid = eid;
  }


  public long getCid() {
    return cid;
  }

  public void setCid(long cid) {
    this.cid = cid;
  }

  public void setPid(long pid) {
    this.pid = pid;
  }

  public long getPid() {
    return pid;
  }
}
