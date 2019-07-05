package com.company.database.models;


import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.Id;

@Entity
public class Person {

  @Id
  @Column(name = "PERSONID")
  private long personID;

  @Column(name = "SURNAME")
  private String surname;

  @Column(name = "NAME")
  private String name;

  @Column(name = "ADDRESS")
  private String address;

  public Person(Long id, String surname, String name, String address){
    this.personID = id;
    this.surname = surname;
    this.name = name;
    this.address =address;
  }

  public Person(){}

  public String getSurname() {
    return surname;
  }

  public void setSurname(String surname) {
    this.surname = surname;
  }


  public String getName() {
    return name;
  }

  public void setName(String name) {
    this.name = name;
  }


  public String getAddress() {
    return address;
  }

  public void setAddress(String address) {
    this.address = address;
  }

  public long getPersonID() {
    return personID;
  }

  public void setPersonID(long personID) {
    this.personID = personID;
  }
}
