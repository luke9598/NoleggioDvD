package dao;


import exception.DAOException;
import model.Credentials;
import model.Role;

import java.sql.*;

public class LoginDAO {
    public Credentials getCredentials(String username, String password) throws DAOException {
        Role role = null;
        try {
            Connection conn = ConnectionFactory.getConnection();
            CallableStatement cs = conn.prepareCall("{call login(?,?)}");
            cs.setString(1, username);
            cs.setString(2, password);
            ResultSet rs = cs.executeQuery();
            if(rs.next()){
                role = switch (rs.getString(1)){
                    case "proprietario" -> Role.PROPRIETARIO;
                    case "impiegato" -> Role.IMPIEGATO;
                    default -> {
                        DAOException e = new DAOException();
                        throw new DAOException("Wrong role: " + e.getMessage());
                    }
                };
            }
        } catch(SQLException e) {
            System.out.println("Errore SQL: " + e.getMessage());
            System.out.println("SQLState: " + e.getSQLState());
        }
        return new Credentials(username, password , role);
    }
}
