package controller;

import model.Credentials;

import static model.Role.*;

public class ApplicationController implements Controller{

    Credentials credentials;
    @Override
    public void start(){
        LoginController loginController = new LoginController();
        loginController.start();
        credentials = loginController.getCred();

        if(credentials.getRole() == null) {
            throw new RuntimeException("Invalid credentials");
        }

        switch(credentials.getRole()) {
            case PROPRIETARIO -> new ProprietarioController().start();
            case IMPIEGATO -> new ImpiegatoController().start();
        }
    }
}
