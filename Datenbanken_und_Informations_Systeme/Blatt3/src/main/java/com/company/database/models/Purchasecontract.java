package com.company.database.models;


import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.PrimaryKeyJoinColumn;
import java.sql.Date;

@Entity
@PrimaryKeyJoinColumn(name = "FID")
public class Purchasecontract extends Contract{

  @Column(name = "INSTALLMENTNUMBER")
  private long installmentnumber;

  @Column(name = "INTRESTRATE")
  private double intrestrate;

  public Purchasecontract(){

  }
  public Purchasecontract(long contractnumber, Date date, String place, long installmentnumber, double intrestrate) {
    super(contractnumber, date, place);
    this.installmentnumber = installmentnumber;
    this.intrestrate = intrestrate;
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



}
