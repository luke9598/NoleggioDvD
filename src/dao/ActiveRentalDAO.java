package dao;

import exception.DAOException;
import model.ActiveRental;
import model.ActiveRentalList;

import java.sql.CallableStatement;
import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.SQLException;

public class ActiveRentalDAO {

    public ActiveRentalList getCustomerActiveRentals(String tessera) throws DAOException {

        ActiveRentalList rentals = new ActiveRentalList();
        try {
            Connection conn = ConnectionFactory.getConnection();
            CallableStatement cs = conn.prepareCall("{call available_rents(?)}");
            cs.setString(1, tessera);
            boolean status = cs.execute();
            if (status) {
                ResultSet rs = cs.getResultSet();
                while (rs.next()) {
                    ActiveRental active = new ActiveRental(rs.getString(1), rs.getString(2), rs.getString(3), rs.getString(4),rs.getString(5), rs.getString(6)+ " €", rs.getString(7));
                    rentals.addActiveRental(active);
                }
            }
        } catch (SQLException e) {
            System.out.println("Errore SQL: " + e.getMessage());
            System.out.println("SQLState: " + e.getSQLState());
        }
        return rentals;
    }

    public void addRental(String titolo, String regista, String tessera, String costo) throws DAOException{
        try {
            Connection conn = ConnectionFactory.getConnection();
            CallableStatement cs = conn.prepareCall("{call add_rental(?,?,?,?)}");
            cs.setString(1, titolo);
            cs.setString(2, regista);
            cs.setString(3, tessera);
            cs.setString(4,costo);
            cs.execute();
            System.out.print("Noleggio eseguito con successo.\n");
        } catch (SQLException e) {
            System.out.println("Errore SQL: " + e.getMessage());
            System.out.println("SQLState: " + e.getSQLState());
        }
    }
}