package com.company.database.models;


import javax.persistence.Entity;
import javax.persistence.Table;
import java.sql.Date;

@Entity
@Table(name = "CONTRACT")
public class ContractListClass extends Contract{

    public ContractListClass(){}
 public ContractListClass(long contractnumber, Date date, String place) {
    super(contractnumber, date, place);
  }
}
