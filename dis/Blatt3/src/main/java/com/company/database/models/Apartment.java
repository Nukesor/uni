package com.company.database.models;


import javax.persistence.*;

@Entity
@Table(name = "APARTMENT")
@PrimaryKeyJoinColumn(name = "EID")
public class Apartment extends Estate {

  @Column(name = "FLOOR")
  private long floor;

  @Column(name = "RENT")
  private long rent;

  @Column(name = "ROOMS")
  private long rooms;

  @Column(name = "BALCONY")
  private long balcony;

  @Column(name = "KITCHEN")
  private long kitchen;


  public Apartment(int id, String city, long zip, String street, String streetnumber, long squarearea, String login,
                   long floor, long rent, long rooms, long balcony, long kitchen) {
    super(id, city, zip, street, streetnumber, squarearea, login);
    this.floor = floor;
    this.rent = rent;
    this.rooms = rooms;
    this.balcony = balcony;
    this.kitchen = kitchen;
  }

  public Apartment(){}


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
}
