package com.company.database.models;


import javax.persistence.Entity;
import javax.persistence.Id;

@Entity
public class Estate_Agent {
  //Autogeneration of IDs
  //@GenericGenerator(name="kaugen" , strategy="increment")
  //@GeneratedValue(generator = "kaugen")

  private String NAME;
  private String ADDRES;
  @Id
  private String LOGIN;
  private String PASSWORD;

  public Estate_Agent(String name, String address, String login, String password){
    this.NAME = name;
    this.ADDRES = address;
    this.LOGIN = login;
    this.PASSWORD = password;
  }

  public Estate_Agent(){}

  public String getName() {
    return NAME;
  }

  public void setName(String name) {
    this.NAME = name;
  }


  public String getAddress() {
    return ADDRES;
  }

  public void setAddress(String address) {
    this.ADDRES = address;
  }


  public String getLogin() {
    return LOGIN;
  }

  public void setLogin(String login) {
    this.LOGIN = login;
  }


  public String getPassword() {
    return PASSWORD;
  }

  public void setPassword(String password) {
    this.PASSWORD = password;
  }

}
