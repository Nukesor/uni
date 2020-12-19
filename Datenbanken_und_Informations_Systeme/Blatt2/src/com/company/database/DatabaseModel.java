package com.company.database;

import com.company.database.Exceptions.DontKnowException;
import com.company.database.Exceptions.NotDeletableExeption;
import com.company.database.Exceptions.PKExistsException;
import com.company.database.models.*;
import com.ibm.db2.jcc.b.SqlException;

import java.io.ByteArrayInputStream;
import java.io.IOException;
import java.io.ObjectInputStream;
import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.List;

public class DatabaseModel {
    private Connection connection;
    public DatabaseModel(Connection c) {
        connection = c;
    }

    public void test(){

    }

    public void addEstateAgend(EstateAgent estateAgent) throws NotDeletableExeption, PKExistsException, DontKnowException {
        addEstateAgend(estateAgent.getName(), estateAgent.getAddres(), estateAgent.getLogin(), estateAgent.getPassword());
    }
    public void addEstateAgend(String name, String address, String login, String password) throws PKExistsException, NotDeletableExeption, DontKnowException {
        try {
            Statement stmt = connection.createStatement();
            String query = "INSERT INTO ESTATE_AGENT (Name, Addres, Login, Password)" +
                    " VALUES ('"+name+"', '"+address+"', '"+login+"', '"+password+"')";
            stmt.executeUpdate(query);
        } catch (SQLException e) {
            switch (e.getSQLState()){
                case "23505": throw new PKExistsException();
                case "23504" : throw new NotDeletableExeption();
                default: throw new DontKnowException();
            }        }

    }

    public void deleteEstateAgend(EstateAgent estateAgent) throws NotDeletableExeption, PKExistsException, DontKnowException {
        deleteEstateAgend(estateAgent.getLogin());
    }

    public void deleteEstateAgend(String login) throws PKExistsException, NotDeletableExeption, DontKnowException {
        try {
            Statement stmt = connection.createStatement();
            String query = "DELETE from ESTATE_AGENT WHERE LOGIN='"+login+"'";
            stmt.executeUpdate(query);
        } catch (SQLException e) {
            switch (e.getSQLState()){
                case "23505": throw new PKExistsException();
                case "23504" : throw new NotDeletableExeption();
                default: throw new DontKnowException();
            }
        }
    }

    public void updateEstateAgend(EstateAgent estateAgent) throws NotDeletableExeption, PKExistsException, DontKnowException {
        updateEstateAgend(estateAgent.getName(), estateAgent.getAddres(), estateAgent.getPassword(), estateAgent.getLogin(), null);
    }

    public void updateEstateAgend(EstateAgent estateAgent, String newName) throws NotDeletableExeption, PKExistsException, DontKnowException {
        updateEstateAgend(estateAgent.getName(), estateAgent.getAddres(), estateAgent.getPassword(), estateAgent.getLogin(), newName);
    }

    public void updateEstateAgend(String name, String address, String password, String currentLogin, String newLoginName) throws PKExistsException, NotDeletableExeption, DontKnowException {
        if(newLoginName == null){
            newLoginName = currentLogin;
        }
        try {
            Statement stmt = connection.createStatement();
            String query = "UPDATE ESTATE_AGENT SET name = '"+name+"', addres ='"+address+"', password='"+password+"', login='"+newLoginName+"' WHERE LOGIN='"+currentLogin+"'";
            stmt.executeUpdate(query);
        } catch (SQLException e) {
            switch (e.getSQLState()){
                case "23505": throw new PKExistsException();
                case "23504" : throw new NotDeletableExeption();
                default: throw new DontKnowException();
            }        }

    }

    public void addEstate(Estate estate) throws NotDeletableExeption, PKExistsException, DontKnowException {
        addEstate(estate.getId(), estate.getCity(), estate.getZip(), estate.getStreet(), estate.getStreetnumber(), estate.getSquarearea(), estate.getLogin());
    }

    public void addHouse(House estate) throws PKExistsException, NotDeletableExeption, DontKnowException {
        try {
            addEstate(estate.getId(), estate.getCity(), estate.getZip(), estate.getStreet(), estate.getStreetnumber(), estate.getSquarearea(), estate.getLogin());

            Statement stmt = connection.createStatement();
            String query = "INSERT INTO HOUSE (EID, FLOORS, PRICE, GARDEN)" +
                    " VALUES ("+estate.getEid()+", "+estate.getFloors()+", "+estate.getPrice()+", "+estate.getGarden()+")";
            stmt.executeUpdate(query);
            } catch (SQLException e) {
            switch (e.getSQLState()){
                case "23505": throw new PKExistsException();
                case "23504" : throw new NotDeletableExeption();
                default: throw new DontKnowException();
            }        }
    }

    public void addApartment(Apartment estate) throws PKExistsException, NotDeletableExeption, DontKnowException {
        try {
            addEstate(estate.getId(), estate.getCity(), estate.getZip(), estate.getStreet(), estate.getStreetnumber(), estate.getSquarearea(), estate.getLogin());

            Statement stmt = connection.createStatement();
            String query = "INSERT INTO APARTMENT (EID, FLOOR, RENT, ROOMS, BALCONY, KITCHEN)" +
                    " VALUES ("+estate.getEid()+", "+estate.getFloor()+", "+estate.getRent()+", "+estate.getRooms()+", "+estate.getBalcony()+", "+estate.getKitchen()+")";
            stmt.executeUpdate(query);
            } catch (SQLException e) {
            switch (e.getSQLState()){
                case "23505": throw new PKExistsException();
                case "23504" : throw new NotDeletableExeption();
                default: throw new DontKnowException();
            }        }
    }

    public void addEstate(long id,
                String city,
                long zip,
                String street,
                String streetnumber,
                long squarearea,
                String login
    ) throws PKExistsException, NotDeletableExeption, DontKnowException {
        try {
            Statement stmt = connection.createStatement();
            String query = "INSERT INTO ESTATE (id, city, zip, street, streetnumber, squarearea, login)" +
                    " VALUES ("+id+", '"+city+"', "+zip+", '"+street+"', '"+streetnumber+"', "+squarearea+", '"+login+"')";
            stmt.executeUpdate(query);
        } catch (SQLException e) {
            switch (e.getSQLState()){
                case "23505": throw new PKExistsException();
                case "23504" : throw new NotDeletableExeption();
                default: throw new DontKnowException();
            }        }
    }

    public void deleteHouse(int id) throws PKExistsException, NotDeletableExeption, DontKnowException {
        try {
            Statement stmt = connection.createStatement();
            String query = "DELETE from HOUSE WHERE EID="+id;
            stmt.executeUpdate(query);
            deleteEstate(id);
        } catch (SQLException e) {
            switch (e.getSQLState()){
                case "23505": throw new PKExistsException();
                case "23504" : throw new NotDeletableExeption();
                default: throw new DontKnowException();
            }        }
    }

    public void deleteApartment(int id) throws PKExistsException, NotDeletableExeption, DontKnowException {
        try {
            Statement stmt = connection.createStatement();
            String query = "DELETE from APARTMENT WHERE EID="+id;
            stmt.executeUpdate(query);
            deleteEstate(id);
        } catch (SQLException e) {
            switch (e.getSQLState()){
                case "23505": throw new PKExistsException();
                case "23504" : throw new NotDeletableExeption();
                default: throw new DontKnowException();
            }        }
    }

    public void deleteEstate(Estate estate) throws NotDeletableExeption, PKExistsException, DontKnowException {
        deleteEstate(estate.getId());
    }

    public void deleteEstate(int id) throws PKExistsException, NotDeletableExeption, DontKnowException {
        try {
            Statement stmt = connection.createStatement();
            String query = "DELETE from  ESTATE WHERE ID="+id;
            stmt.executeUpdate(query);
        } catch (SQLException e) {
            switch (e.getSQLState()){
                case "23505": throw new PKExistsException();
                case "23504" : throw new NotDeletableExeption();
                default: throw new DontKnowException();
            }        }
    }

    public void updateEstate(int id,
                                String city,
                             long zip,
                             String street,
                             String streetnumber,
                             long squarearea,
                             String login) throws PKExistsException, NotDeletableExeption, DontKnowException {
        try {
            Statement stmt = connection.createStatement();
            String query = "UPDATE ESTATE SET city = '"+city+"', zip ="+zip+", street='"+street+"', streetnumber='"+streetnumber+"', squarearea="+squarearea+", login='"+login+"' WHERE ID="+id;
            stmt.executeUpdate(query);
        } catch (SQLException e) {
            switch (e.getSQLState()){
                case "23505": throw new PKExistsException();
                case "23504" : throw new NotDeletableExeption();
                default: throw new DontKnowException();
            }        }
    }

    public void updateEstate(Estate estate) throws NotDeletableExeption, PKExistsException, DontKnowException {
        updateEstate(estate.getId(),estate.getCity(), estate.getZip(), estate.getStreet(), estate.getStreetnumber(), estate.getSquarearea(), estate.getLogin());
    }

    public void updateApartment(Apartment estate) throws PKExistsException, NotDeletableExeption, DontKnowException {
        try {
            Statement stmt = connection.createStatement();
            String query = "UPDATE APARTMENT SET " +
                    "FLOOR = "+estate.getFloor()+", " +
                    "RENT = "+estate.getRent()+", " +
                    "ROOMS = "+estate.getRooms()+", " +
                    "BALCONY = "+estate.getBalcony()+", " +
                    "KITCHEN = "+estate.getKitchen()+" " +
                    "WHERE EID = "+estate.getEid();
            stmt.executeUpdate(query);
        } catch (SQLException e) {
            switch (e.getSQLState()){
                case "23505": throw new PKExistsException();
                case "23504" : throw new NotDeletableExeption();
                default: throw new DontKnowException();
            }        }
        updateEstate(estate.getId(),estate.getCity(), estate.getZip(), estate.getStreet(), estate.getStreetnumber(), estate.getSquarearea(), estate.getLogin());
    }

    public void updateHouse(House estate) throws PKExistsException, NotDeletableExeption, DontKnowException {
        try {
            Statement stmt = connection.createStatement();
            String query = "UPDATE HOUSE SET " +
                    "FLOORS = "+estate.getFloors()+", " +
                    "PRICE = "+estate.getPrice()+", " +
                    "GARDEN = "+estate.getGarden()+ " " +
                    "WHERE EID = "+estate.getEid();
            stmt.executeUpdate(query);
        } catch (SQLException e) {
            switch (e.getSQLState()){
                case "23505": throw new PKExistsException();
                case "23504" : throw new NotDeletableExeption();
                default: throw new DontKnowException();
            }        }
        updateEstate(estate.getId(),estate.getCity(), estate.getZip(), estate.getStreet(), estate.getStreetnumber(), estate.getSquarearea(), estate.getLogin());
    }

    public void addPerson(Person person) throws NotDeletableExeption, PKExistsException, DontKnowException {
        addPerson(person.getSurname(), person.getName(), person.getAddress());
    }

    public void addPerson(String surname,
            String name,
            String address) throws PKExistsException, NotDeletableExeption, DontKnowException {
        try {
            Statement stmt = connection.createStatement();
            String query = "INSERT INTO PERSON (Surname, Name, Address)" +
                    " VALUES ('"+surname+"', '"+name+"', '"+address+"')";
            stmt.executeUpdate(query);
        } catch (SQLException e) {
            switch (e.getSQLState()){
                case "23505": throw new PKExistsException();
                case "23504" : throw new NotDeletableExeption();
                default: throw new DontKnowException();
            }        }
    }


    public void createContract(Contract contract) throws NotDeletableExeption, PKExistsException, DontKnowException {
        createContract(contract.getContractnumber(), contract.getDate(), contract.getPlace());
    }

    public void createTenancyContract(Tenancycontract contract) throws PKExistsException, NotDeletableExeption, DontKnowException {
        try {
            createContract(contract.getContractnumber(), contract.getDate(), contract.getPlace());
            Statement stmt = connection.createStatement();
            String query = "INSERT INTO TENANCYCONTRACT (STARTDATE, DURATION, ACOST, FID)" +
                    " VALUES ('"+contract.getStartdate()+"', "+contract.getDuration()+", "+contract.getAcost()+", "+contract.getFid()+")";
            stmt.executeUpdate(query);

        } catch (SQLException e) {
            switch (e.getSQLState()){
                case "23505": throw new PKExistsException();
                case "23504" : throw new NotDeletableExeption();
                default: throw new DontKnowException();
            }        }
    }

    public void createPurchaseContract(Purchasecontract contract) throws PKExistsException, NotDeletableExeption, DontKnowException {
        try {
            createContract(contract.getContractnumber(), contract.getDate(), contract.getPlace());
            Statement stmt = connection.createStatement();
            String query = "INSERT INTO PURCHASECONTRACT (INSTALLMENTNUMBER, INTRESTRATE, FID)" +
                    " VALUES ("+contract.getInstallmentnumber()+", "+contract.getIntrestrate()+", "+contract.getFid()+")";
            stmt.executeUpdate(query);

        } catch (SQLException e) {
            switch (e.getSQLState()){
                case "23505": throw new PKExistsException();
                case "23504" : throw new NotDeletableExeption();
                default: throw new DontKnowException();
            }        }

    }
    public void createContract(long contractnumber,
            java.sql.Date date,
            String place) throws PKExistsException, NotDeletableExeption, DontKnowException {
        try {
            Statement stmt = connection.createStatement();
            String query = "INSERT INTO CONTRACT (contractnumber, date, place)" +
                    " VALUES ("+contractnumber+", '"+date+"', '"+place+"')";
            stmt.executeUpdate(query);
        } catch (SQLException e) {
            switch (e.getSQLState()){
                case "23505": throw new PKExistsException();
                case "23504" : throw new NotDeletableExeption();
                default: throw new DontKnowException();
            }        }
    }

    public List<Contract> allContracts() throws PKExistsException, NotDeletableExeption, DontKnowException {
        List<Contract> contracts = new ArrayList<>();
        try {
            Statement stmt = connection.createStatement();
            String query = "SELECT * FROM CONTRACT ORDER BY CONTRACTNUMBER ASC";
            ResultSet rs = stmt.executeQuery(query);

            while (rs.next()) {
                ContractListClass c = new ContractListClass(rs.getLong("CONTRACTNUMBER"), rs.getDate("DATE"), rs.getString("PLACE"));
                contracts.add(c);
            }
        } catch (java.sql.SQLException e) {
            switch (e.getSQLState()){
                case "23505": throw new PKExistsException();
                case "23504" : throw new NotDeletableExeption();
                default: throw new DontKnowException();
            }
        }
        return contracts;
    }

    public boolean login(String login, String password) throws PKExistsException, NotDeletableExeption, DontKnowException {
        try {
            Statement stmt = connection.createStatement();
            String query = "SELECT * FROM ESTATE_AGENT WHERE login = '" +login+ "' and password = '" + password + "'";
            ResultSet rs = stmt.executeQuery(query);

            while (rs.next()) {
                return true;
            }
        } catch (java.sql.SQLException e) {
            switch (e.getSQLState()){
                case "23505": throw new PKExistsException();
                case "23504" : throw new NotDeletableExeption();
                default: throw new DontKnowException();
            }
        }
        return false;
    }

}
