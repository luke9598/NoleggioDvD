package dao;

import exception.DAOException;
import model.FilmCopy;
import model.FilmCopyList;

import java.sql.*;

public class FilmCopyDAO {

    public FilmCopyList getFilmCopyList(String titolo,String regista) throws DAOException{
        FilmCopyList copyList = new FilmCopyList();
        try {
            Connection conn = ConnectionFactory.getConnection();
            CallableStatement cs = conn.prepareCall("{call available_copy_list(?,?)}");
            cs.setString(1,titolo);
            cs.setString(2,regista);
            boolean status = cs.execute();
            if (status) {
                ResultSet rs = cs.getResultSet();
                while (rs.next()) {
                    FilmCopy copy = new FilmCopy(rs.getString(1), rs.getString(2), rs.getString(3));
                    copyList.addCopy(copy);
                }
            }
        } catch (SQLException e) {
            System.out.println("Errore SQL: " + e.getMessage());
            System.out.println("SQLState: " + e.getSQLState());
        }
        return copyList;
    }

    public void addCopies(String titolo, String regista, String numero) throws DAOException{
        try {
            Connection conn = ConnectionFactory.getConnection();
            CallableStatement cs = conn.prepareCall("{call add_copy(?,?,?)}");
            cs.setString(1, titolo);
            cs.setString(2, regista);
            cs.setString(3, numero);
            cs.execute();
            System.out.print("Copie film aggiunte con successo.\n");
        } catch (SQLException e) {
            System.out.println("Errore SQL: " + e.getMessage());
            System.out.println("SQLState: " + e.getSQLState());
        }
    }

    public FilmCopyList getReportedFilmCopyList() throws DAOException{
        FilmCopyList copyList = new FilmCopyList();
        try {
            Connection conn = ConnectionFactory.getConnection();
            CallableStatement cs = conn.prepareCall("{call report_copy()}");
            boolean status = cs.execute();
            if (status) {
                ResultSet rs = cs.getResultSet();
                while (rs.next()) {
                    FilmCopy copy = new FilmCopy(rs.getString(1), rs.getString(2), rs.getString(3));
                    copyList.addCopy(copy);
                }
            }
        } catch (SQLException e) {
            System.out.println("Errore SQL: " + e.getMessage());
            System.out.println("SQLState: " + e.getSQLState());
        }
        return copyList;
    }

}