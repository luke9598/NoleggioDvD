package dao;

import exception.DAOException;
import model.Film;
import model.FilmList;
import model.Worker;
import model.WorkerList;

import java.sql.CallableStatement;
import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.SQLException;

public class WorkerDAO {
    public void addWorker(String cf, String nome, String cellulare, String telefono, String email, String ruolo) throws DAOException {
        try {
            Connection conn = ConnectionFactory.getConnection();
            CallableStatement cs = conn.prepareCall("{call add_worker(?,?,?,?,?,?)}");
            cs.setString(1, cf);
            cs.setString(2, nome);
            cs.setString(3, cellulare);
            cs.setString(4, telefono);
            cs.setString(5, email);
            cs.setString(6, ruolo);
            cs.execute();
            System.out.print("Aggiunto impiegato con successo.\n");
        } catch (SQLException e) {
            System.out.println("Errore SQL: " + e.getMessage());
            System.out.println("SQLState: " + e.getSQLState());
        }
    }

    public void addWork(String cf, String ruolo) throws DAOException{
        try {
            Connection conn = ConnectionFactory.getConnection();
            CallableStatement cs = conn.prepareCall("{call mod_worker(?,?)}");
            cs.setString(1, cf);
            cs.setString(2, ruolo);
            cs.execute();
            System.out.print("Ruolo cambiato con successo.\n");
        } catch (SQLException e) {
            System.out.println("Errore SQL: " + e.getMessage());
            System.out.println("SQLState: " + e.getSQLState());
        }
    }

    public WorkerList getWorkerList() throws DAOException{
        WorkerList workerList = new WorkerList();
        try {
            Connection conn = ConnectionFactory.getConnection();
            CallableStatement cs = conn.prepareCall("{call all_workers()}");
            boolean status = cs.execute();
            if (status) {
                ResultSet rs = cs.getResultSet();
                while (rs.next()) {
                    Worker worker = new Worker(rs.getString(1), rs.getString(2), rs.getString(3), rs.getString(4),rs.getString(5),rs.getString(6),rs.getString(7));
                    workerList.addWorker(worker);
                }
            }
        }catch(SQLException e){
            System.out.println("Errore SQL: " + e.getMessage());
            System.out.println("SQLState: " + e.getSQLState());
        }
        return workerList;
    }

}
