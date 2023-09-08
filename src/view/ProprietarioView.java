package view;

import model.Data;
import model.WorkShift;
import model.Worker;

import java.io.BufferedReader;
import java.io.IOException;
import java.io.InputStreamReader;
import java.util.InputMismatchException;
import java.util.Scanner;

public class ProprietarioView {
    public static int showMenu() throws IOException {
        System.out.println("*********************************");
        System.out.println("*    PROPRIETARIO    *");
        System.out.println("*********************************\n");
        System.out.println("*** What should I do for you? ***\n");
        System.out.println("1) Add Worker");
        System.out.println("2) Mod Work");
        System.out.println("3) All Workers");
        System.out.println("4) Add WorkShift");
        System.out.println("5) Update WorkShift");
        System.out.println("6) Delete WorkShift");
        System.out.println("7) Day WorkShifts");
        System.out.println("8) Report monthly hour");
        System.out.println("9) Report yearly hour");
        System.out.println("10) Quit");


        Scanner input = new Scanner(System.in);
        int choice;
        while (true) {
            System.out.print("Please enter your choice: ");
            try {
                choice = input.nextInt();
                if (choice >= 1 && choice <= 10) {
                    break;
                } else {
                    System.out.println("Invalid option. Please choose a number between 1 and 6.");
                }
            } catch (InputMismatchException e) {
                System.out.println("Invalid input. Please enter a valid number.");
                input.nextLine();
            }
        }

        return choice;
    }

    public static Worker selectWorker() throws IOException{
        BufferedReader reader = new BufferedReader(new InputStreamReader(System.in));
        System.out.print("cf: ");
        String cf = reader.readLine();
        System.out.print("nome: ");
        String nome = reader.readLine();
        System.out.print("cellulare: ");
        String cellulare = reader.readLine();
        System.out.print("telefono: ");
        String telefono = reader.readLine();
        System.out.print("email: ");
        String email = reader.readLine();
        System.out.print("ruolo: ");
        String ruolo = reader.readLine();
        return new Worker(cf,nome,cellulare,telefono,email,ruolo);
    }

    public static Worker selectWork() throws IOException{
        BufferedReader reader = new BufferedReader(new InputStreamReader(System.in));
        System.out.print("cf: ");
        String cf = reader.readLine();
        System.out.print("ruolo: ");
        String ruolo = reader.readLine();
        return new Worker(cf,ruolo);
    }

    public static WorkShift selectWorkShift() throws IOException{
        BufferedReader reader = new BufferedReader(new InputStreamReader(System.in));
        System.out.print("cf: ");
        String cf = reader.readLine();
        System.out.print("inizio: ");
        String inizio = reader.readLine();
        System.out.print("fine: ");
        String fine = reader.readLine();
        System.out.print("data: ");
        String data = reader.readLine();
        return new WorkShift(cf,inizio, fine, data);
    }

    public static WorkShift selectNewWorkShift() throws IOException{
        BufferedReader reader = new BufferedReader(new InputStreamReader(System.in));
        System.out.print("cf: ");
        String cf = reader.readLine();
        System.out.print("nuovo orario inizio: ");
        String inizio = reader.readLine();
        System.out.print("nuovo orario fine: ");
        String fine = reader.readLine();
        System.out.print("data: ");
        String data = reader.readLine();
        return new WorkShift(cf,inizio, fine, data);
    }


    public static WorkShift selectDate() throws IOException {
        BufferedReader reader = new BufferedReader(new InputStreamReader(System.in));
        System.out.print("Select a date: ");
        String date = reader.readLine();
        return new WorkShift(date);
    }

    public static Data selectMonth() throws IOException {
        BufferedReader reader = new BufferedReader(new InputStreamReader(System.in));
        System.out.print("mese: ");
        String mese = reader.readLine();
        System.out.print("anno: ");
        String anno = reader.readLine();
        return new Data(mese,anno);
    }

    public static Data selectYear() throws IOException {
        BufferedReader reader = new BufferedReader(new InputStreamReader(System.in));
        System.out.print("anno: ");
        String anno = reader.readLine();
        return new Data(anno);
    }
}
