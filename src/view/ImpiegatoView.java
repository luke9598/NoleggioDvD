package view;

import model.*;

import java.io.BufferedReader;
import java.io.IOException;
import java.io.InputStreamReader;
import java.util.InputMismatchException;
import java.util.Scanner;

public class ImpiegatoView {
    public static int showMenu() throws IOException {
        System.out.println("*********************************");
        System.out.println("*    IMPIEGATO    *");
        System.out.println("*********************************\n");
        System.out.println("*** What should I do for you? ***\n");
        System.out.println("0) All Films");
        System.out.println("1) Available Films");
        System.out.println("2) Copies Available for a Film");
        System.out.println("3) Add Copies");
        System.out.println("4) Customer Active Rentals");
        System.out.println("5) Add Rental");
        System.out.println("6) End Rental");
        System.out.println("7) Mod Customer Registry");
        System.out.println("8) Register Customer");
        System.out.println("9) Report Expired Copy");
        System.out.println("10) Report Expired Customer");
        System.out.println("11) Quit");


        Scanner input = new Scanner(System.in);
        int choice;
        while (true) {
            System.out.print("Please enter your choice: ");
            try {
                choice = input.nextInt();
                if (choice >= 0 && choice <= 11) {
                    break;
                } else {
                    System.out.println("Invalid option. Please choose a number between 1 and 11.");
                }
            } catch (InputMismatchException e) {
                System.out.println("Invalid input. Please enter a valid number.");
                input.nextLine();
            }
        }

        return choice;
    }

    public static Film selectFilm() throws IOException {
        BufferedReader reader = new BufferedReader(new InputStreamReader(System.in));
        System.out.print("titolo: ");
        String titolo = reader.readLine();
        System.out.print("regista: ");
        String regista = reader.readLine();
        return new Film(titolo, regista, null, null);
    }

    public static Customer selectCard() throws IOException {
        BufferedReader reader = new BufferedReader(new InputStreamReader(System.in));
        System.out.print("Tessera cliente: ");
        String tessera = reader.readLine();
        return new Customer(tessera);
    }

    public static FilmCopy selectCopy() throws IOException{
        BufferedReader reader = new BufferedReader(new InputStreamReader(System.in));
        System.out.print("titolo: ");
        String titolo = reader.readLine();
        System.out.print("regista: ");
        String regista = reader.readLine();
        System.out.print("numero copie: ");
        String numero = reader.readLine();
        return new FilmCopy(titolo, regista, numero);
    }

    public static ActiveRental selectRental() throws IOException {
        BufferedReader reader = new BufferedReader(new InputStreamReader(System.in));
        System.out.print("titolo: ");
        String titolo = reader.readLine();
        System.out.print("regista: ");
        String regista = reader.readLine();
        System.out.print("tessera cliente: ");
        String tessera = reader.readLine();
        System.out.print("costo: ");
        String costo = reader.readLine();
        return new ActiveRental(titolo, regista, tessera, costo);
    }

    public static ActiveRental selectEndRental() throws IOException{
        BufferedReader reader = new BufferedReader(new InputStreamReader(System.in));
        System.out.print("titolo: ");
        String titolo = reader.readLine();
        System.out.print("regista: ");
        String regista = reader.readLine();
        System.out.print("tessera cliente: ");
        String tessera = reader.readLine();
        System.out.print("data inizio: ");
        String data = reader.readLine();
        return new ActiveRental(titolo, regista, tessera, data);
    }

    public static Customer selectCustomer() throws IOException{
        BufferedReader reader = new BufferedReader(new InputStreamReader(System.in));
        System.out.print("tessera: ");
        String tessera = reader.readLine();
        System.out.print("cf: ");
        String cf = reader.readLine();
        System.out.print("nome: ");
        String nome = reader.readLine();
        System.out.print("cognome: ");
        String cognome = reader.readLine();
        System.out.print("sesso: ");
        String sesso = reader.readLine();
        System.out.print("luogo di nascita: ");
        String luogoNascita = reader.readLine();
        System.out.print("data di nascita: ");
        String data = reader.readLine();
        System.out.print("cellulare: ");
        String cellulare = reader.readLine();
        System.out.print("telefono: ");
        String telefono = reader.readLine();
        System.out.print("email: ");
        String email = reader.readLine();
        return new Customer(tessera,cf,nome,cognome,sesso,luogoNascita,data,cellulare,telefono,email);
    }

    public static Customer selectModCustomer() throws IOException{
        BufferedReader reader = new BufferedReader(new InputStreamReader(System.in));
        System.out.print("tessera: ");
        String tessera = reader.readLine();
        System.out.print("cf: ");
        String cf = reader.readLine();
        System.out.print("nome: ");
        String nome = reader.readLine();
        System.out.print("cognome: ");
        String cognome = reader.readLine();
        System.out.print("sesso: ");
        String sesso = reader.readLine();
        System.out.print("luogo di nascita: ");
        String luogoNascita = reader.readLine();
        System.out.print("data di nascita: ");
        String data = reader.readLine();
        return new Customer(tessera,cf,nome,cognome,sesso,luogoNascita,data);
    }
}
