package com.company.database.models;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.Id;

@Entity
public class Rents {
  public Rents(){}
  public Rents(long eid, long cid, long pid){
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

  public long getPid() {
    return pid;
  }

  public void setPid(long pid) {
    this.pid = pid;
  }
}
