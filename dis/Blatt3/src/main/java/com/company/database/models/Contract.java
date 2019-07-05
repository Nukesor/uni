package com.company.database.models;



import javax.persistence.*;
import java.sql.Date;

@Entity
@Inheritance(strategy = InheritanceType.JOINED)
public abstract class Contract {

  @Id
  @Column(name = "CONTRACTNUMBER")
  private long contractnumber;

  @Column(name = "DATE")
  private java.sql.Date date;

  @Column(name = "PLACE")
  private String place;

  public Contract(){

  }
  public Contract(long contractnumber, Date date, String place) {
    this.contractnumber = contractnumber;
    this.date = date;
    this.place = place;
  }

  public long getContractnumber() {
    return contractnumber;
  }

  public void setContractnumber(long contractnumber) {
    this.contractnumber = contractnumber;
  }


  public java.sql.Date getDate() {
    return date;
  }

  public void setDate(java.sql.Date date) {
    this.date = date;
  }


  public String getPlace() {
    return place;
  }

  public void setPlace(String place) {
    this.place = place;
  }

  @Override
  public String toString() {
    return "Contract{" +
            "contractnumber=" + contractnumber +
            ", date=" + date +
            ", place='" + place + '\'' +
            '}';
  }
}
