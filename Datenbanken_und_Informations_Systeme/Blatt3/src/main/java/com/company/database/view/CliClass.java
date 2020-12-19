package com.company.database.view;
import com.company.database.HibernateModel;
import com.company.database.IDatabaseModel;
import com.company.database.models.*;

import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.List;
import java.util.Scanner;

public class CliClass {
    public static final String ANSI_RESET = "\u001B[0m";
    public static final String ANSI_RED = "\u001B[31m";
    public static final String ANSI_GREEN = "\u001B[32m";


    public static final String CREATE_AGENT = "create agent";
    public static final String CREATE_AGENT_PARAMS = "name(str),addres(str),login(str),password(str)";

    public static final String DELETE_AGENT = "delete agent";
    public static final String DELETE_AGENT_PARAMS = "login(str)";

    public static final String CHANGE_AGENT = "change agent";
    public static final String CHANGE_AGENT_PARAMS = "login(str),newName(str),newAddres(str),newLogin(str),newPassword(str)";


    public static final String AGENT_LOGIN = "agent login";
    public static final String AGENT_LOGIN_PARAMS = "login(str),password(str)";

    public static final String CREATE_ESTATE = "create estate";
    public static final String CREATE_ESTATE_PARAMS = "id(int),city(str),zip(int),street(str),streetnumber(str)," +
            "squareare(int),agentLogin(str),floors(int),price(int),garden(int)" +
            "\n"  +
            "id(int),city(str),zip(int),street(str),streetnumber(str)," +
            "squareare(int),agentLogin(str),floor(int),rent(int),rooms(int),balcony(int),kitchen(int)";

    public static final String DELETE_ESTATE = "delete estate";
    public static final String DELETE_ESTATE_PARAMS = "id(int)";

    public static final String CHANGE_ESTATE_HOUSE = "change estate house";
    public static final String CHANGE_ESTATE_HOUSE_PARAMS = "id(int),city(str),zip(int),street(str),streetnumber(str)," +
           "squareare(int),agentLogin(str),floors(int),price(int),garden(int)";

    public static final String CHANGE_ESTATE_APPARTMENT = "change estate apartment";
    public static final String CHANGE_ESTATE_APPARTMENT_PARAMS = "id(int),city(str),zip(int),street(str),streetnumber(str)," +
            "squareare(int),agentLogin(str),floor(int),rent(int),rooms(int),balcony(int),kitchen(int)";



    public static final String CREATE_PERSON = "create person";
    public static final String CREATE_PERSON_PARAMS = "surname(str),name(str),address(str),id(int)";

    public static final String CREATE_CONTRACT = "create contract";
    public static final String CREATE_CONTRACT_PARAMS = "contractnumber(int),date(date),place(str)" +
            "installnumber(int),interestrate(int),personId(int),houseId(int)" +
            "\n" +
            "contractnumber(int),date(date),place(str)" +
            "startdate(date),duration(int),cost(int),personId(int),apartementId(int)";

    public static final String VIEW_CONTRACTS = "view contracts";

    public static final String QUIT = "exit";
    public static final String HELP = "help";
    public static final String HELP_PARAMS_AGENT = "Commands are:\n" +
            QUIT + "\n" +
            CREATE_AGENT + "\n" +
            DELETE_AGENT + "\n" +
            CHANGE_AGENT;

    public static final String HELP_PARAMS_CONTRACT = "Commands are:\n" +
            QUIT + "\n" +
            CREATE_PERSON + "\n" +
            CREATE_CONTRACT + "\n" +
            VIEW_CONTRACTS;

    public static final String HELP_PARAMS_ESTATES = "Commands are:\n" +
            AGENT_LOGIN + "\n" +
            CREATE_ESTATE + "\n" +
            DELETE_ESTATE + "\n" +
            CHANGE_ESTATE_HOUSE + "\n" +
            CHANGE_ESTATE_APPARTMENT;

    public static final String ERROR_MESSAGE = "please check if your values are correct";
    private Scanner input = new Scanner(System.in);
    private IDatabaseModel dm = new HibernateModel();


    public void menu_loop() {
        while (true) {
            System.out.println("Choose a mode: ");
            System.out.println("[1] - Management mode of estate agents");
            System.out.println("[2] - Management mode of estates");
            System.out.println("[3] - Management mode of contracts");
            System.out.println("[0] - Quit");

            System.out.print("> ");
            int mode = Integer.parseInt(input.nextLine());

            switch (mode) {
                case 1:
                    login_loop();
                    agent_loop();
                    break;
                case 2:
                    estate_loop();
                    break;
                case 3:
                    contract_loop();
                    break;
                case 0:
                    return;
            }
        }
    }


    public void login_loop() {
        while (true) {
            System.out.print("user: ");
            String user = input.nextLine();
            System.out.print("password: ");
            String password = input.nextLine();

            if (!user.equals("admin") || !password.equals("admin")) {
                System.out.println("Wrong password. Try again!");
            }
            else {
                return;
            }
        }
    }

    public void contract_loop() {
        while (true) {
            System.out.print("> ");
            String command = input.nextLine();
            switch (command) {
                case HELP:
                    System.out.println(HELP_PARAMS_CONTRACT);
                    break;
                //TODO
                case CREATE_PERSON:
                    System.out.println(CREATE_PERSON_PARAMS);
                    System.out.print(ANSI_RED + "create person mode > " + ANSI_RESET);
                    try {
                        String[] form = getInputArray();
                        dm.addPerson(new Person(Long.parseLong(form[3]), form[0], form[1], form[2]));
                    } catch (Exception e) {
                        e.printStackTrace();
                    }
                    break;
                case CREATE_CONTRACT:
                    System.out.println(CREATE_CONTRACT_PARAMS);
                    System.out.print(ANSI_RED + "create contract mode > " + ANSI_RESET);
                    try {
                        String[] form = getInputArray();

                        int id = Integer.parseInt(form[0]);
                        SimpleDateFormat format = new SimpleDateFormat("yyyyMMdd");
                        Date parsed = format.parse(form[1]);
                        java.sql.Date sqlDate = new java.sql.Date(parsed.getTime());
                        int offset = 0;
                        if(form.length == 8){
                            offset = 1;
                        }
                        int param3 = Integer.parseInt(form[offset + 3]);
                        int param4 = Integer.parseInt(form[offset + 4]);
                        int eid = Integer.parseInt(form[offset + 6]);
                        int pid = Integer.parseInt(form[offset + 5]);
                        if (form.length == 7) {
                            dm.sellHouse(new Purchasecontract(
                                    id,
                                    sqlDate,
                                    form[2],
                                    param3,
                                    param4), new Sells(eid, id, pid));
                        }
                        else if (form.length == 8){
                            Date parsedStart = format.parse(form[3]);
                            java.sql.Date sqlDateStart = new java.sql.Date(parsedStart.getTime());
                            dm.rentApartment(new Tenancycontract(
                                    id,
                                    sqlDate,
                                    form[2],
                                    sqlDateStart,
                                    param3,
                                    param4), new Rents(eid, id, pid));
                        }

                    } catch (Exception e) {
                        e.printStackTrace();
                    }
                    break;
                case VIEW_CONTRACTS:
                    try {
                        List<Contract> contractList = dm.allContracts();
                        for (Contract c : contractList) {
                            System.out.println(ANSI_GREEN + c.getContractnumber() + " " + c.getDate() + " " +
                                    c.getPlace() + " " + ANSI_RESET);
                        }
                    } catch (Exception e) {
                        e.printStackTrace();
                    }
                    break;
                case QUIT:
                    return;
            }
        }
    }

    public void agent_loop(){
        while (true) {
            System.out.print("> ");
            String command = input.nextLine();
            switch (command) {
                case HELP:
                    System.out.println(HELP_PARAMS_AGENT);
                    break;
                case CREATE_AGENT:
                    System.out.println(CREATE_AGENT_PARAMS);
                    System.out.print(ANSI_RED + "create agent mode > " + ANSI_RESET);
                    try {
                        String[] form = getInputArray();
                        dm.addEstateAgend(new Estate_Agent(form[0], form[1], form[2], form[3]));
                    } catch (Exception e) {
                        e.printStackTrace();
                    }
                    break;
                //TODO
                case DELETE_AGENT:
                    System.out.println(DELETE_AGENT_PARAMS);
                    System.out.print(ANSI_RED + "delete agent mode > " + ANSI_RESET);
                    try {
                        String form = input.nextLine();
                        dm.deleteEstateAgend(form.trim());
                    } catch (Exception e) {
                        e.printStackTrace();
                    }
                    break;
                //TODO
                case CHANGE_AGENT:
                    System.out.println(CHANGE_AGENT_PARAMS);
                    System.out.print(ANSI_RED + "change agent mode > " + ANSI_RESET);
                    try {
                        String[] form = getInputArray();
                        dm.updateEstateAgend(form[0], new Estate_Agent(form[1], form[2], form[3], form[4]));
                    } catch (Exception e) {
                        e.printStackTrace();
                    }
                    break;

                case QUIT:
                    return;
            }
        }
    }

    public void estate_loop() {
        boolean loggedin = false;

        while (true) {
            System.out.print("> ");
            String command = input.nextLine();
            switch (command){
                case HELP:
                    System.out.println(HELP_PARAMS_ESTATES);
                    break;

                case AGENT_LOGIN:
                    System.out.println(AGENT_LOGIN_PARAMS);
                    System.out.print(ANSI_RED + "agent login mode > " + ANSI_RESET);
                    try {
                        String[] form = getInputArray();
                        loggedin = dm.login(form[0], form[1]);
                        if(!loggedin){
                            System.out.println("Please try again!");
                        } else {
                            System.out.println("Welcome!");
                        }
                    } catch (Exception e) {
                        e.printStackTrace();
                    }
                    break;

                case CREATE_ESTATE:
                    if(!loggedin){
                        System.out.println("Please login first!");
                        break;
                    }

                    System.out.println(CREATE_ESTATE_PARAMS);
                    System.out.print(ANSI_RED + "create estate mode > " + ANSI_RESET);
                    try {
                        String[] form = getInputArray();
                        if (form.length == 10) {
                            System.out.println("House" + form.length);

                            dm.addEstate(new House(
                                    Integer.parseInt(form[0]),
                                    form[1],
                                    Integer.parseInt(form[2]),
                                    form[3],
                                    form[4],
                                    Integer.parseInt(form[5]),
                                    form[6],
                                    Long.parseLong(form[7]),
                                    Long.parseLong(form[8]),
                                    Long.parseLong(form[9])));
                        } else {
                            System.out.println("Apartment" + form.length);
                            dm.addEstate(new Apartment(
                                    Integer.parseInt(form[0]),
                                    form[1],
                                    Integer.parseInt(form[2]),
                                    form[3],
                                    form[4],
                                    Integer.parseInt(form[5]),
                                    form[6],
                                    Long.parseLong(form[7]),
                                    Long.parseLong(form[8]),
                                    Long.parseLong(form[9]),
                                    Long.parseLong(form[10]),
                                    Long.parseLong(form[11])));
                        }

                    } catch (Exception e) {
                        e.printStackTrace();
                    }
                    break;
                //TODO
                case DELETE_ESTATE:
                    if(!loggedin){
                        System.out.println("Please login first!");
                        break;
                    }

                    System.out.println(DELETE_ESTATE_PARAMS);
                    System.out.print(ANSI_RED + "delete estate mode > " + ANSI_RESET);
                    try {
                        String form = input.nextLine();
                        dm.deleteEstate(Integer.parseInt(form.trim()));
                    } catch (Exception e) {
                        e.printStackTrace();
                    }
                    break;

                case CHANGE_ESTATE_HOUSE:
                    if(!loggedin){
                        System.out.println("Please login first!");
                        break;
                    }

                    System.out.println(CHANGE_ESTATE_HOUSE_PARAMS);
                    System.out.print(ANSI_RED + "change house mode > " + ANSI_RESET);
                    try {
                        String[] form = getInputArray();
                        dm.updateEstate(new House(
                                Integer.parseInt(form[0]),
                                form[1],
                                Integer.parseInt(form[2]),
                                form[3],
                                form[4],
                                Integer.parseInt(form[5]),
                                form[6],
                                Long.parseLong(form[7]),
                                Long.parseLong(form[8]),
                                Long.parseLong(form[9])));
                    } catch (Exception e) {
                        e.printStackTrace();
                    }
                    break;

                case CHANGE_ESTATE_APPARTMENT:
                    if(!loggedin){
                        System.out.println("Please login first!");
                        break;
                    }

                    System.out.println(CHANGE_ESTATE_APPARTMENT_PARAMS);
                    System.out.print(ANSI_RED + "change apartment mode > " + ANSI_RESET);

                    try {
                        String[] form = getInputArray();
                        dm.updateEstate(new Apartment(
                                Integer.parseInt(form[0]),
                                form[1],
                                Integer.parseInt(form[2]),
                                form[3],
                                form[4],
                                Integer.parseInt(form[5]),
                                form[6],
                                Long.parseLong(form[7]),
                                Long.parseLong(form[8]),
                                Long.parseLong(form[9]),
                                Long.parseLong(form[10]),
                                Long.parseLong(form[11])));
                    } catch (Exception e) {
                        e.printStackTrace();
                    }
                    break;

                case QUIT:
                    return;
            }
        }
    }

    private String[] getInputArray() {
        String[] form = input.nextLine().split(",");
        for(int i = 0; i < form.length; i++){
            form[i] = form[i].trim();
        }
        return form;
    }


}
