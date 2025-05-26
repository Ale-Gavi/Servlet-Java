package com.example.java_project_servlet;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;

public class DBConnection {

    // JDBC driver class name (note: currently not used in code, just a constant)
    private static final String DB_DRIVER = "com.mysql.jdbc.Driver";

    // Database connection URL (MariaDB on localhost with specified schema)
    private static final String DB_CONNECTION = "jdbc:mariadb://localhost:3306/dbServlet";

    // Database credentials
    private static final String DB_USER = "root";
    private static final String DB_PASSWORD = "";

    // Static connection object shared among all instances
    static Connection dbConnection = null;

    // Constructor - attempts to load JDBC driver and open connection to DB
    public DBConnection() {
        String url;
        Connection con = null;
        System.out.println("Inizio Connessione...");

        try {
            System.out.println("Cerco i driver...");
            // Load the MariaDB JDBC driver class into memory
            Class.forName("org.mariadb.jdbc.Driver");
            System.out.println("Driver trovati");
        } catch (Exception ex) {
            // If driver not found or other error loading it, print message
            System.out.println("errore JDBC");
        }

        try {
            System.out.println("Provo a connettermi al Database...");
            // Establish connection to the database using provided URL and credentials
            dbConnection = DriverManager.getConnection(DB_CONNECTION, DB_USER, DB_PASSWORD);

            System.out.println("SQL Connection to DB eseguita correttamente!");
        } catch (SQLException e) {
            // If connection fails, print error code and message
            System.out.println("Connection to dbmio database failed");
            System.out.println(e.getErrorCode() + ":" + e.getMessage());
        }
    }

    /**
     * Executes a SELECT SQL query and returns the ResultSet.
     * @param select the SELECT SQL statement as a String
     * @return ResultSet containing query results or null if error occurs
     */
    public static ResultSet selectQuery(String select) {
        Statement stmt = null;
        try {
            // Create a new statement object from the connection
            stmt = dbConnection.createStatement();
            // Execute the query and return the results
            ResultSet UtentiList = stmt.executeQuery(select);
            return UtentiList;

        } catch (SQLException sqle) {
            // Print error if SELECT fails
            System.out.println("SELECT ERROR");
            return null;
        } catch (Exception err) {
            // Catch any other exceptions generically
            System.out.println("GENERIC ERROR");
            return null;
        }
    }

    /**
     * Executes an INSERT SQL statement.
     * @param query the INSERT SQL statement as a String
     * @return true if successful, otherwise exception is thrown
     */
    public static boolean insertQuery(String query) {
        Statement stmt = null;

        try {
            // Create statement object
            stmt = dbConnection.createStatement();
            // Execute the INSERT query
            stmt.executeQuery(query);

            return true;
        } catch (SQLException e) {
            // On SQL error, throw a runtime exception
            throw new RuntimeException(e);
        }
    }

    /**
     * Executes an UPDATE SQL statement.
     * @param query the UPDATE SQL statement as a String
     * @return true if successful, otherwise exception is thrown
     */
    public static boolean updateQuery(String query) {
        Statement stmt = null;

        try {
            // Create statement object
            stmt = dbConnection.createStatement();
            // Execute the UPDATE query
            stmt.executeQuery(query);

            return true;
        } catch (SQLException e) {
            // On SQL error, throw a runtime exception
            throw new RuntimeException(e);
        }
    }
}
