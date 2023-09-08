package controller;

import dao.LoginDAO;
import exception.DAOException;
import model.Credentials;
import view.LoginView;

import java.io.IOException;

public class LoginController implements Controller{
    Credentials credentials = null;

    @Override
    public void start() {
        try {
            credentials = LoginView.authenticate();
        } catch(IOException e) {
            throw new RuntimeException(e);
        }
        try {
            credentials = new LoginDAO().getCredentials(credentials.getUsername(), credentials.getPassword());
        } catch(DAOException e) {
            throw new RuntimeException(e);
        }
    }

    public Credentials getCred() {
        return credentials;
    }
}
