package com.company.database.models;


import java.sql.Date;

public class Purchasecontract extends Contract{

  private long installmentnumber;
  private double intrestrate;
  private long fid;

  public Purchasecontract(long contractnumber, Date date, String place, long installmentnumber, double intrestrate) {
    super(contractnumber, date, place);
    this.installmentnumber = installmentnumber;
    this.intrestrate = intrestrate;
    this.fid = contractnumber;
  }

  public long getInstallmentnumber() {
    return installmentnumber;
  }

  public void setInstallmentnumber(long installmentnumber) {
    this.installmentnumber = installmentnumber;
  }


  public double getIntrestrate() {
    return intrestrate;
  }

  public void setIntrestrate(double intrestrate) {
    this.intrestrate = intrestrate;
  }


  public long getFid() {
    return fid;
  }

  public void setFid(long fid) {
    this.fid = fid;
  }

}
