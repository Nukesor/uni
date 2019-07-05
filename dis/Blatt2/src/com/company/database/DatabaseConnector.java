package com.company.database;
import java.io.File;
import java.io.FileInputStream;
import java.io.FileNotFoundException;
import java.io.IOException;
import java.net.URISyntaxException;
import java.net.URL;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;
import java.util.Properties;

public class DatabaseConnector {
    // instance of Driver Manager
    private static DatabaseConnector _instance = null;

    // DB2 connection
    private Connection _con;

    public DatabaseConnector() {
        try {
            // Holen der Einstellungen aus der db2.properties Datei
            Properties properties = new Properties();
            URL url = ClassLoader.getSystemResource("db2.properties");
            FileInputStream stream = new FileInputStream(new File(url.toURI()));
            properties.load(stream);
            stream.close();

            String jdbcUser = properties.getProperty("jdbc_user");
            String jdbcPass = properties.getProperty("jdbc_pass");
            String jdbcUrl = properties.getProperty("jdbc_url");

            // Verbindung zur DB2 herstellen
            Class.forName("com.ibm.db2.jcc.DB2Driver");
            _con = DriverManager.getConnection(jdbcUrl, jdbcUser, jdbcPass);

        } catch (FileNotFoundException e1) {
            e1.printStackTrace();
        } catch (IOException e) {
            e.printStackTrace();
        } catch (ClassNotFoundException e) {
            e.printStackTrace();
        } catch (SQLException e) {
            e.printStackTrace();
        } catch (URISyntaxException e) {
            e.printStackTrace();
        }

    }

    /**
     * Liefert Instanz des Managers
     *
     * @return DB2ConnectionManager
     */
    public static DatabaseConnector getInstance() {
        if (_instance == null) {
            _instance = new DatabaseConnector();
        }
        return _instance;
    }

    /**
     * Liefert eine Verbindung zur DB2
     *
     * @return Connection
     */
    public Connection getConnection() {
        return _con;
    }
}
