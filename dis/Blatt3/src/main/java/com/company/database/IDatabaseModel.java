package com.company.database;

import com.company.database.Exceptions.DontKnowException;
import com.company.database.Exceptions.NotDeletableExeption;
import com.company.database.Exceptions.PKExistsException;
import com.company.database.models.*;

import java.util.List;

public interface IDatabaseModel {
    void addEstateAgend(Estate_Agent estateAgent);

    void deleteEstateAgend(String login);

    void updateEstateAgend(String oldLogin, Estate_Agent estateAgent);

    void addEstate(Estate estate);

    void deleteEstate(long id);

    void sellHouse(long eid, long cid, long pid);

    void rentApartment(long eid, long cid, long pid);

    void sellHouse(Purchasecontract purchasecontract, Sells sells);

    void rentApartment(Tenancycontract tenancycontract, Rents rents);

    void updateEstate(Estate estate);

    void addPerson(Person person);

    void createContract(Contract contract);

    List<Contract> allContracts();

    boolean login(String login, String password) throws PKExistsException, NotDeletableExeption, DontKnowException;
}
