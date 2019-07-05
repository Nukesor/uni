package com.company.database.models;


public class House extends Estate{

  private long floors;
  private long price;
  private long garden;
  private long eid;

  public House(int id, String city, long zip, String street, String streetnumber, long squarearea, String login, long floors, long price, long garden) {
    super(id, city, zip, street, streetnumber, squarearea, login);
    this.floors = floors;
    this.price = price;
    this.garden = garden;
    this.eid = id;
  }


  public long getFloors() {
    return floors;
  }

  public void setFloors(long floors) {
    this.floors = floors;
  }


  public long getPrice() {
    return price;
  }

  public void setPrice(long price) {
    this.price = price;
  }


  public long getGarden() {
    return garden;
  }

  public void setGarden(long garden) {
    this.garden = garden;
  }


  public long getEid() {
    return eid;
  }

  public void setEid(long eid) {
    this.eid = eid;
  }

}
