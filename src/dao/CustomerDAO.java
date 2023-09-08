package dao;

import exception.DAOException;
import model.Customer;
import model.CustomerList;

import java.sql.CallableStatement;
import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.SQLException;

public class CustomerDAO {

    public void addCustomer(String tessera, String cf, String nome, String cognome, String sesso, String luogoNascita, String data, String cellulare, String telefono, String email) throws DAOException {
        try {
            Connection conn = ConnectionFactory.getConnection();
            CallableStatement cs = conn.prepareCall("{call add_customer(?,?,?,?,?,?,?,?,?,?)}");
            cs.setString(1, tessera);
            cs.setString(2, cf);
            cs.setString(3, nome);
            cs.setString(4, cognome);
            cs.setString(5, sesso);
            cs.setString(6, luogoNascita);
            cs.setString(7, data);
            cs.setString(8, cellulare);
            cs.setString(9, telefono);
            cs.setString(10, email);
            cs.execute();
        } catch (SQLException e) {
            System.out.println("Errore SQL: " + e.getMessage());
            System.out.println("SQLState: " + e.getSQLState());
        }
    }

    public void modCustomer(String tessera, String cf, String nome, String cognome, String sesso, String luogoNascita, String data) throws DAOException {
        try {
            Connection conn = ConnectionFactory.getConnection();
            CallableStatement cs = conn.prepareCall("{call mod_customer_registry(?,?,?,?,?,?,?)}");
            cs.setString(1, tessera);
            cs.setString(2, cf);
            cs.setString(3, nome);
            cs.setString(4, cognome);
            cs.setString(5, sesso);
            cs.setString(6, luogoNascita);
            cs.setString(7, data);
            cs.execute();
        } catch (SQLException e) {
            System.out.println("Errore SQL: " + e.getMessage());
            System.out.println("SQLState: " + e.getSQLState());
        }
    }

    public CustomerList getReportedCustomerList() throws DAOException{
        CustomerList customerList = new CustomerList();
        try {
            Connection conn = ConnectionFactory.getConnection();
            CallableStatement cs = conn.prepareCall("{call report_customer()}");
            boolean status = cs.execute();
            if (status) {
                ResultSet rs = cs.getResultSet();
                while (rs.next()) {
                    Customer customer = new Customer(rs.getString(1),rs.getString(2),rs.getString(3),rs.getString(4),rs.getString(5),rs.getString(6),rs.getString(7),rs.getString(8),rs.getString(9),rs.getString(10));
                    customerList.addCustomer(customer);
                }
            }
        } catch (SQLException e) {
            System.out.println("Errore SQL: " + e.getMessage());
            System.out.println("SQLState: " + e.getSQLState());
        }
        return customerList;
    }

}

