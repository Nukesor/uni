package test;
import com.company.database.DatabaseConnector;
import com.company.database.DatabaseModel;
import com.company.database.Exceptions.DontKnowException;
import com.company.database.Exceptions.NotDeletableExeption;
import com.company.database.Exceptions.PKExistsException;
import com.company.database.models.*;
import org.junit.jupiter.api.Test;

import java.sql.Date;
import java.text.DateFormat;
import java.text.SimpleDateFormat;
import java.time.LocalDate;
import java.util.List;

public class testDingsiDongso {

    public DatabaseModel testModel;
    public Apartment apartment;
    public House house;
    public Purchasecontract purchasecontract;
    public Tenancycontract tenancycontract;
    public EstateAgent estateAgent;
    public Person person;

    public testDingsiDongso(){
        DatabaseConnector con = new DatabaseConnector();
        testModel = new DatabaseModel(con.getConnection());
        apartment = new Apartment(34,"august", 22666, "augustweg", "9b", 12, "luke", 1, 1, 1, 1, 1);
        house = new House(34,"august", 22666, "augustweg", "9b", 12, "luke", 1, 1, 1);
        estateAgent = new EstateAgent("luke", "augustweg 9c", "luke", "blah");
        person = new Person("luke","tester","augustweg 9 3/4");
        DateFormat dateFormat = new SimpleDateFormat("yyyy/MM/dd");
        java.util.Date date = new java.util.Date();
        purchasecontract = new Purchasecontract(36, new Date(date.getTime()), "blah", 33, 3.3);
        tenancycontract = new Tenancycontract(35, new Date(date.getTime()), "blah", new Date(date.getTime()), 3, 3);
    }

    @Test
    public void createEstateAgent() throws NotDeletableExeption, PKExistsException, DontKnowException {
        testModel.addEstateAgend(estateAgent);
    }

    @Test
    public void updateEstateAgent() throws NotDeletableExeption, PKExistsException, DontKnowException {
        estateAgent.setAddres("augustweg 9d");
        testModel.updateEstateAgend(estateAgent);
    }

    @Test
    public void createApartment() throws NotDeletableExeption, PKExistsException, DontKnowException {
        testModel.addApartment(apartment);
    }

    @Test
    public void createHouse() throws NotDeletableExeption, PKExistsException, DontKnowException {
        testModel.addHouse(house);
    }

    @Test
    public void updateApartment() throws NotDeletableExeption, PKExistsException, DontKnowException {
        apartment.setBalcony(2);
        testModel.updateApartment(apartment);
    }

    @Test
    public void updateHouse() throws NotDeletableExeption, PKExistsException, DontKnowException {
        house.setFloors(2);
        testModel.updateHouse(house);
    }

    @Test
    public void deleteApartment() throws NotDeletableExeption, PKExistsException, DontKnowException {
        testModel.deleteApartment(apartment.getId());
    }

    @Test
    public void deleteHouse() throws NotDeletableExeption, PKExistsException, DontKnowException {
        testModel.deleteHouse(house.getId());
    }

    @Test
    public void deleteEstateAgent() throws NotDeletableExeption, PKExistsException, DontKnowException {
        testModel.deleteEstateAgend("luke");
    }

    @Test
    public void createTenancyContract() throws NotDeletableExeption, PKExistsException, DontKnowException {
        testModel.createTenancyContract(tenancycontract);
    }

    @Test
    public void createPurchaseContract() throws NotDeletableExeption, PKExistsException, DontKnowException {
        testModel.createPurchaseContract(purchasecontract);
    }

    @Test
    public void getAllContracts() throws NotDeletableExeption, PKExistsException, DontKnowException {
        List<Contract> blah = testModel.allContracts();
        assert blah != null;
    }

    @Test
    public void createPerson(){

    }
}
