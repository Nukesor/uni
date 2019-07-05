package com.company.database.models;


public class Apartment extends Estate {

  private long floor;
  private long rent;
  private long rooms;
  private long balcony;
  private long kitchen;
  private long eid;

  public Apartment(int id, String city, long zip, String street, String streetnumber, long squarearea, String login, long floor, long rent, long rooms, long balcony, long kitchen) {
    super(id, city, zip, street, streetnumber, squarearea, login);
    this.floor = floor;
    this.rent = rent;
    this.rooms = rooms;
    this.balcony = balcony;
    this.kitchen = kitchen;
    this.eid = id;
  }


  public long getFloor() {
    return floor;
  }

  public void setFloor(long floor) {
    this.floor = floor;
  }


  public long getRent() {
    return rent;
  }

  public void setRent(long rent) {
    this.rent = rent;
  }


  public long getRooms() {
    return rooms;
  }

  public void setRooms(long rooms) {
    this.rooms = rooms;
  }


  public long getBalcony() {
    return balcony;
  }

  public void setBalcony(long balcony) {
    this.balcony = balcony;
  }


  public long getKitchen() {
    return kitchen;
  }

  public void setKitchen(long kitchen) {
    this.kitchen = kitchen;
  }


  public long getEid() {
    return eid;
  }

  public void setEid(long eid) {
    this.eid = eid;
  }

}
