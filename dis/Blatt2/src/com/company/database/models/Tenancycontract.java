package com.company.database.models;


import java.sql.Date;

public class Tenancycontract extends Contract{

  private java.sql.Date startdate;
  private long duration;
  private long acost;
  private long fid;

  public Tenancycontract(long contractnumber, Date date, String place, Date startdate, long duration, long acost) {
    super(contractnumber, date, place);
    this.startdate = startdate;
    this.duration = duration;
    this.acost = acost;
    this.fid = contractnumber;
  }

  public java.sql.Date getStartdate() {
    return startdate;
  }

  public void setStartdate(java.sql.Date startdate) {
    this.startdate = startdate;
  }


  public long getDuration() {
    return duration;
  }

  public void setDuration(long duration) {
    this.duration = duration;
  }


  public long getAcost() {
    return acost;
  }

  public void setAcost(long acost) {
    this.acost = acost;
  }


  public long getFid() {
    return fid;
  }

  public void setFid(long fid) {
    this.fid = fid;
  }

}
