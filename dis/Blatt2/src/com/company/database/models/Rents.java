package com.company.database.models;


public class Rents {

  private long eid;
  private long cid;
  private String firstName;
  private String lastName;
  private String address;


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


  public String getFirstName() {
    return firstName;
  }

  public void setFirstName(String firstName) {
    this.firstName = firstName;
  }


  public String getLastName() {
    return lastName;
  }

  public void setLastName(String lastName) {
    this.lastName = lastName;
  }


  public String getAddress() {
    return address;
  }

  public void setAddress(String address) {
    this.address = address;
  }

}
