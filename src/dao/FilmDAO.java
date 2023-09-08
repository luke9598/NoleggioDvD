package dao;

import exception.DAOException;
import model.Film;
import model.FilmList;
import java.sql.*;

public class FilmDAO {

    public FilmList getFilmList(int num)  throws DAOException {
        FilmList filmList = new FilmList();
        String sql = null;
        try {
            Connection conn = ConnectionFactory.getConnection();
            switch (num){
                case 0 -> sql = "{call film_list()}";
                case 1 -> sql = "{call available_film_list()}";
            }
            CallableStatement cs = conn.prepareCall(sql);
            boolean status = cs.execute();
            if (status) {
                ResultSet rs = cs.getResultSet();
                while (rs.next()) {
                    Film film = new Film(rs.getString(1), rs.getString(2), rs.getDate(3), rs.getString(4));
                    filmList.addFilm(film);
                }
            }
        }catch(SQLException e){
            System.out.println("Errore SQL: " + e.getMessage());
            System.out.println("SQLState: " + e.getSQLState());
        }
        return filmList;
    }
}
