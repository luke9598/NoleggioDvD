package dao;

import exception.DAOException;

import java.sql.CallableStatement;
import java.sql.Connection;
import java.sql.SQLException;

public class EndRenalDAO {

    public void endRental(String titolo, String regista, String tessera, String data_inizio) throws DAOException{
        try {
            Connection conn = ConnectionFactory.getConnection();
            CallableStatement cs = conn.prepareCall("{call end_rental(?,?,?,?)}");
            cs.setString(1, titolo);
            cs.setString(2, regista);
            cs.setString(3, tessera);
            cs.setString(4,data_inizio);
            cs.execute();
            System.out.print("Removed active rental.\n");
        } catch (SQLException e) {
            System.out.println("Errore SQL: " + e.getMessage());
            System.out.println("SQLState: " + e.getSQLState());
        }
    }
}

