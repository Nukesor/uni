package com.company.database.models;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.PrimaryKeyJoinColumn;

@Entity
@PrimaryKeyJoinColumn(name = "EID")
public class House extends Estate{

  @Column(name = "FLOORS")
  private long floors;

  @Column(name = "PRICE")
  private long price;

  @Column(name = "GARDEN")
  private long garden;

  public House(int id, String city, long zip, String street, String streetnumber, long squarearea, String login, long floors, long price, long garden) {
    super(id, city, zip, street, streetnumber, squarearea, login);
    this.floors = floors;
    this.price = price;
    this.garden = garden;
  }

  public House(){}


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
}
