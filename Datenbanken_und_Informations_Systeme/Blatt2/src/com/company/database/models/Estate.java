package com.company.database.models;


public abstract class Estate {

  private int id;
  private String city;
  private long zip;
  private String street;
  private String streetnumber;
  private long squarearea;
  private String login;

  public Estate(int id, String city, long zip, String street, String streetnumber, long squarearea, String login){
    this.id = id;
    this.city = city;
    this.zip = zip;
    this.street = street;
    this.streetnumber = streetnumber;
    this.squarearea = squarearea;
    this.login = login;
  }

  public int getId() {
    return id;
  }

  public void setId(int id) {
    this.id = id;
  }


  public String getCity() {
    return city;
  }

  public void setCity(String city) {
    this.city = city;
  }


  public long getZip() {
    return zip;
  }

  public void setZip(long zip) {
    this.zip = zip;
  }


  public String getStreet() {
    return street;
  }

  public void setStreet(String street) {
    this.street = street;
  }


  public String getStreetnumber() {
    return streetnumber;
  }

  public void setStreetnumber(String streetnumber) {
    this.streetnumber = streetnumber;
  }


  public long getSquarearea() {
    return squarearea;
  }

  public void setSquarearea(long squarearea) {
    this.squarearea = squarearea;
  }


  public String getLogin() {
    return login;
  }

  public void setLogin(String login) {
    this.login = login;
  }

}
