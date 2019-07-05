package com.company;

import com.company.database.DatabaseConnector;
import com.company.database.DatabaseModel;
import com.company.database.view.CliClass;

public class Main {

    public static void main(String[] args) {
        CliClass t = new CliClass();
        t.menu_loop();
    }
}
