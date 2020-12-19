package com.company.database.models;


public class EstateAgent {

  private String name;
  private String addres;
  private String login;
  private String password;

  public EstateAgent(String name, String addres, String login, String password){
    this.name = name;
    this.addres = addres;
    this.login = login;
    this.password = password;
  }

  public String getName() {
    return name;
  }

  public void setName(String name) {
    this.name = name;
  }


  public String getAddres() {
    return addres;
  }

  public void setAddres(String addres) {
    this.addres = addres;
  }


  public String getLogin() {
    return login;
  }

  public void setLogin(String login) {
    this.login = login;
  }


  public String getPassword() {
    return password;
  }

  public void setPassword(String password) {
    this.password = password;
  }

}
