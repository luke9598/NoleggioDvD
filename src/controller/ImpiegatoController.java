package controller;

import dao.*;
import exception.DAOException;
import model.*;
import view.ImpiegatoView;

import java.io.IOException;
import java.sql.SQLException;

public class ImpiegatoController implements Controller{
    @Override
    public void start() {
        try{
            ConnectionFactory.changeRole(Role.IMPIEGATO);
        }catch(SQLException e){
            throw new RuntimeException(e);
        }
        while(true){
            int choice;
            try{
                choice = ImpiegatoView.showMenu();
            }catch (IOException e){
                throw new RuntimeException(e);
            }

            switch(choice){
                case 0 -> allFilms();
                case 1 -> filmList();
                case 2 -> filmCopyList();
                case 3 -> addCopies();
                case 4 -> customerActiveRentals();
                case 5 -> addRental();
                case 6 -> endRental();
                case 7 -> modCustomerRegistry();
                case 8 -> addCustomer();
                case 9 -> getReportedCopy();
                case 10 -> getReportedCustomer();
                case 11 -> System.exit(0);
                default -> throw new RuntimeException("Invalid choice");
            }
        }
    }

    private void allFilms() {
        FilmList filmList;
        try {
            filmList = new FilmDAO().getFilmList(0);
        } catch(DAOException e) {
            throw new RuntimeException(e);
        }
        System.out.print(filmList);
    }

    public void filmList(){
        FilmList filmList;
        try {
            filmList = new FilmDAO().getFilmList(1);
        } catch(DAOException e) {
            throw new RuntimeException(e);
        }

        System.out.print(filmList);
    }

    public void filmCopyList(){
        Film film;
        FilmCopyList filmCopyList;
        try {
            film = ImpiegatoView.selectFilm();
        } catch(IOException e) {
            throw new RuntimeException(e);
        }try {
            filmCopyList = new FilmCopyDAO().getFilmCopyList(film.getTitolo(), film.getRegista());
        } catch(DAOException e) {
            throw new RuntimeException(e);
        }

        System.out.print(filmCopyList);
    }

    private void addCopies() {
        FilmCopy copy;
        try {
            copy = ImpiegatoView.selectCopy();
        } catch(IOException e) {
            throw new RuntimeException(e);
        }
        try {
            new FilmCopyDAO().addCopies(copy.getTitolo(),copy.getRegista(),copy.getNumero_copia());
        } catch(DAOException e) {
            throw new RuntimeException(e);
        }

    }

    public void customerActiveRentals(){
        Customer customer;
        ActiveRentalList rentalList;

        try {
            customer = ImpiegatoView.selectCard();
        } catch(IOException e) {
            throw new RuntimeException(e);
        }try {
            rentalList = new ActiveRentalDAO().getCustomerActiveRentals(customer.getTessera());
        } catch(DAOException e) {
            throw new RuntimeException(e);
        }

        System.out.print(rentalList);
    }

    private void addRental() {
        ActiveRental rental;
        try {
            rental = ImpiegatoView.selectRental();
        } catch(IOException e) {
            throw new RuntimeException(e);
        }try {
            new ActiveRentalDAO().addRental(rental.getTitoloCopia(), rental.getRegistaCopia(), rental.getTesseraCliente(), rental.getCosto());
        } catch(DAOException e) {
            throw new RuntimeException(e);
        }
    }

    private void endRental(){
        ActiveRental rental;
        try {
            rental = ImpiegatoView.selectEndRental();
        } catch(IOException e) {
            throw new RuntimeException(e);
        }try {
            new EndRenalDAO().endRental(rental.getTitoloCopia(), rental.getRegistaCopia(), rental.getTesseraCliente(), rental.getCosto());
        } catch(DAOException e) {
            throw new RuntimeException(e);
        }
    }

    private void addCustomer() {
        Customer customer;
        try {
            customer = ImpiegatoView.selectCustomer();
        } catch(IOException e) {
            throw new RuntimeException(e);
        }try {
            new CustomerDAO().addCustomer(customer.getTessera(),customer.getCf(),customer.getNome(),customer.getCognome(),customer.getSesso(),customer.getLuogoNascita(),customer.getData(),customer.getCellulare(),customer.getTelefono(),customer.getEmail());
        } catch(DAOException e) {
            throw new RuntimeException(e);
        }
    }

    private void modCustomerRegistry(){
        Customer customer;
        try {
            customer = ImpiegatoView.selectModCustomer();
        } catch(IOException e) {
            throw new RuntimeException(e);
        }try {
            new CustomerDAO().modCustomer(customer.getTessera(),customer.getCf(),customer.getNome(),customer.getCognome(),customer.getSesso(),customer.getLuogoNascita(),customer.getData());
        } catch(DAOException e) {
            throw new RuntimeException(e);
        }
    }

    private void getReportedCopy(){
        FilmCopyList filmCopyList;
      try {
            filmCopyList = new FilmCopyDAO().getReportedFilmCopyList();
        } catch(DAOException e) {
            throw new RuntimeException(e);
        }
        System.out.print(filmCopyList);
    }

    private void getReportedCustomer(){
        CustomerList customerList;
        try {
            customerList = new CustomerDAO().getReportedCustomerList();
        } catch(DAOException e) {
            throw new RuntimeException(e);
        }
        System.out.print(customerList);
    }

}

