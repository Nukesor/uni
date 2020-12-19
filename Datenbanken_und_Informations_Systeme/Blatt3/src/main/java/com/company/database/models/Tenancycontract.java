package com.company.database.models;


import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.Id;
import javax.persistence.PrimaryKeyJoinColumn;
import java.sql.Date;

@Entity
@PrimaryKeyJoinColumn(name = "FID")
public class Tenancycontract extends Contract{
  public Tenancycontract(){}

  @Column(name = "STARTDATE")
  private java.sql.Date startdate;

  @Column(name = "DURATION")
  private long duration;

  @Column(name = "ACOST")
  private long acost;
  public Tenancycontract(long contractnumber, Date date, String place, Date startdate, long duration, long acost) {
    super(contractnumber, date, place);
    this.startdate = startdate;
    this.duration = duration;
    this.acost = acost;
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

}
