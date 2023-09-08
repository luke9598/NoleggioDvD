package dao;

import exception.DAOException;
import model.Film;
import model.WorkShift;
import model.WorkShiftList;
import model.Worker;

import java.sql.CallableStatement;
import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.SQLException;

public class WorkShiftDAO {
    public void addWorkShift(String cf, String inizio, String fine, String data) throws DAOException {
        try {
            Connection conn = ConnectionFactory.getConnection();
            CallableStatement cs = conn.prepareCall("{call add_workshift(?,?,?,?)}");
            cs.setString(1, cf);
            cs.setString(2, inizio);
            cs.setString(3, fine);
            cs.setString(4, data);
            cs.execute();
            System.out.print("Turno aggiunto con successo.\n");
        } catch (SQLException e) {
            System.out.println("Errore SQL: " + e.getMessage());
            System.out.println("SQLState: " + e.getSQLState());
        }
    }

    public void modWorkShift(String cf, String inizio, String fine, String data)  throws DAOException {
        try {
            Connection conn = ConnectionFactory.getConnection();
            CallableStatement cs = conn.prepareCall("{call mod_workshift(?,?,?,?)}");
            cs.setString(1, cf);
            cs.setString(2, inizio);
            cs.setString(3, fine);
            cs.setString(4, data);
            cs.execute();
            System.out.print("Turno modificato con successo.\n");
        } catch (SQLException e) {
            System.out.println("Errore SQL: " + e.getMessage());
            System.out.println("SQLState: " + e.getSQLState());
        }
    }

    public void deleteWorkShift(String cf, String inizio, String fine, String data)  throws DAOException {
        try {
            Connection conn = ConnectionFactory.getConnection();
            CallableStatement cs = conn.prepareCall("{call delete_workshift(?,?,?,?)}");
            cs.setString(1, cf);
            cs.setString(2, inizio);
            cs.setString(3, fine);
            cs.setString(4, data);
            cs.execute();
            System.out.print("Turno eliminato con successo.\n");
        } catch (SQLException e) {
            System.out.println("Errore SQL: " + e.getMessage());
            System.out.println("SQLState: " + e.getSQLState());
        }
    }


    public WorkShiftList getWorkerShiftList(String date) throws DAOException {
        WorkShiftList workShiftList = new WorkShiftList();
        try {
            Connection conn = ConnectionFactory.getConnection();
            CallableStatement cs = conn.prepareCall("{call day_workshifts(?)}");
            cs.setString(1, date);
            boolean status = cs.execute();
            if (status) {
                ResultSet rs = cs.getResultSet();
                while (rs.next()) {
                    WorkShift workShift = new WorkShift(rs.getString(1), rs.getString(2), rs.getString(3), rs.getString(4));
                    workShiftList.addWorkShift(workShift);
                }
            }
        }catch(SQLException e){
            System.out.println("Errore SQL: " + e.getMessage());
            System.out.println("SQLState: " + e.getSQLState());
        }
        return workShiftList;
    }
}
