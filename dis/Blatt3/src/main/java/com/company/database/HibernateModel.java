package com.company.database;

import com.company.database.models.*;
import org.hibernate.Session;
import org.hibernate.SessionFactory;
import org.hibernate.boot.registry.StandardServiceRegistryBuilder;
import org.hibernate.cfg.Configuration;
import org.hibernate.query.Query;
import org.hibernate.service.ServiceRegistry;

import java.util.List;


public class HibernateModel implements IDatabaseModel {

    private SessionFactory sessionFactoryObj;

    public HibernateModel(){
        buildSessionFactory();

    }

    private SessionFactory buildSessionFactory() {
        // Creating Configuration Instance & Passing Hibernate Configuration File
        Configuration configObj = new Configuration();
        configObj.configure("hibernate.cfg.xml");
        configObj.addAnnotatedClass(Estate_Agent.class);
        configObj.addAnnotatedClass(Contract.class);
        configObj.addAnnotatedClass(Purchasecontract.class);
        configObj.addAnnotatedClass(Tenancycontract.class);
        configObj.addAnnotatedClass(Person.class);
        configObj.addAnnotatedClass(Estate.class);
        configObj.addAnnotatedClass(Apartment.class);
        configObj.addAnnotatedClass(House.class);
        configObj.addAnnotatedClass(Sells.class);
        configObj.addAnnotatedClass(Rents.class);

        // Since Hibernate Version 4.x, ServiceRegistry Is Being Used
        ServiceRegistry serviceRegistryObj = new StandardServiceRegistryBuilder().applySettings(configObj.getProperties()).build();

        // Creating Hibernate SessionFactory Instance
        sessionFactoryObj = configObj.buildSessionFactory(serviceRegistryObj);
        return sessionFactoryObj;
    }


    private Session getSession(){
        return sessionFactoryObj.openSession();
    }

    public void testListContracts() {
        Session s = getSession();
        s.beginTransaction();
        Query query =  s.createQuery("select p from Purchasecontract p ");
        List<Contract> cl = query.list();
        for(Contract c : cl){
            System.out.println(c.getContractnumber());
        }
        s.close();
    }

    @Override
    public void createContract(Contract contract) {
        Session s = getSession();
        s.beginTransaction();
        s.save(contract);
        s.getTransaction().commit();
    }

    @Override
    public void addEstateAgend(Estate_Agent estateAgent) {
        Session s = getSession();
        s.beginTransaction();
        s.save(estateAgent);
        s.getTransaction().commit();
    }

    @Override
    public void deleteEstateAgend(String login) {
        Session s = getSession();
        s.beginTransaction();
        Query queryPurchase =  s.createQuery("delete from Estate_Agent where LOGIN= :login");
        queryPurchase.setParameter("login", login);
        queryPurchase.executeUpdate();
        s.getTransaction().commit();
    }

    @Override
    public void updateEstateAgend(String oldLogin, Estate_Agent estateAgent) {
        Session s = getSession();
        s.beginTransaction();
        Query queryPurchase =  s.createQuery("update from Estate_Agent set NAME= :name, ADDRES= :address, PASSWORD= :password," +
                " LOGIN= :login where LOGIN= :oldLogin");
        queryPurchase.setParameter("oldLogin", oldLogin);
        queryPurchase.setParameter("login", estateAgent.getLogin());
        queryPurchase.setParameter("name", estateAgent.getName());
        queryPurchase.setParameter("password", estateAgent.getPassword());
        queryPurchase.setParameter("address", estateAgent.getAddress());
        queryPurchase.executeUpdate();
        s.getTransaction().commit();
    }

    @Override
    public void addEstate(Estate estate){
        Session s = getSession();
        s.beginTransaction();
        s.save(estate);
        s.getTransaction().commit();
    }


    @Override
    public void sellHouse(long eid, long cid, long pid){
        Session s = getSession();
        s.beginTransaction();
        Sells sale = new Sells();
        sale.setCid(cid);
        sale.setPid(pid);
        sale.setEid(eid);
        s.save(sale);
        s.getTransaction().commit();
    }

    public void sellHouse(Purchasecontract purchasecontract, Sells sells){
        Session s = getSession();
        s.beginTransaction();
        s.save(purchasecontract);
        s.save(sells);
        s.getTransaction().commit();
    }

    @Override
    public void rentApartment(long eid, long cid, long pid){
        Session s = getSession();
        s.beginTransaction();
        Rents rent = new Rents();
        rent.setCid(cid);
        rent.setPid(pid);
        rent.setEid(eid);
        s.save(rent);
        s.getTransaction().commit();
    }

    public void rentApartment(Tenancycontract tenancycontract, Rents rents){
        Session s = getSession();
        s.beginTransaction();
        s.save(tenancycontract);
        s.save(rents);
        s.getTransaction().commit();
    }

    @Override
    public void deleteEstate(long id) {
        Session s = getSession();
        s.beginTransaction();
        Query queryPurchase =  s.createQuery("delete from Estate where ID= :id");
        queryPurchase.setParameter("id", id);
        queryPurchase.executeUpdate();
        s.getTransaction().commit();
    }

    @Override
    public void updateEstate(Estate estate) {
        Session s = getSession();
        s.beginTransaction();
        //s.update(estate);

        if(estate instanceof House) {
            House h = (House) estate;
            s.update(h);
        } else if(estate instanceof Apartment) {
            Apartment a = (Apartment) estate;
            s.update(a);
        }

        s.getTransaction().commit();
    }


    @Override
    public void addPerson(Person person) {
        Session s = getSession();
        s.beginTransaction();
        s.save(person);
        s.getTransaction().commit();
    }


    @Override
    public List<Contract> allContracts() {
        Session s = getSession();
        s.beginTransaction();
        Query queryPurchase =  s.createQuery("select p from Purchasecontract p ");
        List<Contract> pc = queryPurchase.list();
        Query queryTenancy =  s.createQuery("select p from Purchasecontract p ");
        List<Contract> tc = queryTenancy.list();
        pc.addAll(tc);
        s.close();
        return pc;
    }

    @Override
    public boolean login(String login, String password) {
        try (Session session = getSession()){
            Estate_Agent ea = (Estate_Agent)session.get(Estate_Agent.class, login);
            if (ea.getPassword().equals(password)){
                return true;
            }
        }
        return false;
    }

}
