package model;

import java.util.ArrayList;
import java.util.List;

public class CustomerList {

    List<Customer> customerList = new ArrayList<>();
    public void addCustomer(Customer customer) {
            this.customerList.add(customer);
    }

    public String toString() {

        if (customerList.isEmpty()) {
            return "Nessun cliente da segnalare.\n";
        }

        int maxTessera = 0;
        int maxCf = 0;
        int maxNome = 0;
        int maxCognome = 0;
        int maxSesso = 5;
        int maxLuogo = 13;
        int maxData = 10;
        int maxCellulare = 0;
        int maxTelefono = 0;
        int maxEmail = 0;

        for (Customer customer : customerList) {
            if (customer.getTessera().length() > maxTessera) {
                maxTessera = customer.getTessera().length();
            }
            if (customer.getCf().length() > maxCf) {
                maxCf = customer.getCf().length();
            }
            if (customer.getNome().length() > maxNome) {
                maxNome = customer.getNome().length();
            }
            if (customer.getCognome().length() > maxCognome) {
                maxCognome = customer.getCognome().length();
            }
            if (customer.getSesso().length() > maxSesso) {
                maxSesso = customer.getSesso().length();
            }
            if (customer.getLuogoNascita().length() > maxLuogo) {
                maxLuogo = customer.getLuogoNascita().length();
            }
            if (customer.getData().length() > maxData) {
                maxData = customer.getData().length();
            }
            if (customer.getCellulare().length() > maxCellulare) {
                maxCellulare = customer.getCellulare().length();
            }
            if (customer.getTelefono().length() > maxTelefono) {
                maxTelefono = customer.getTelefono().length();
            }
            if (customer.getEmail().length() > maxEmail) {
                maxEmail = customer.getEmail().length();
            }
        }


        String format = "%-" + (maxTessera) + "s | %-" +
                (maxCf) + "s | %-" + (maxNome) + "s | %-" +
                (maxCognome) + "s | %-" + (maxSesso) + "s | %-" +
                (maxLuogo) + "s | %-" + (maxData) + "s | %-" +
                (maxCellulare) + "s | %-" + (maxTelefono) + "s | %-" +
                (maxEmail) + "s%n";
        StringBuilder sb = new StringBuilder();

        sb.append(String.format(format, "TESSERA", "CF", "NOME", "COGNOME","SESSO","LUOGO NASCITA", "DATA", "CELLULARE","TELEFONO", "E-MAIL"));
        sb.append(String.format(format, "-".repeat(maxTessera), "-".repeat(maxCf), "-".repeat(maxNome), "-".repeat(maxCognome), "-".repeat(maxSesso), "-".repeat(maxLuogo), "-".repeat(maxData), "-".repeat(maxCellulare), "-".repeat(maxTelefono), "-".repeat(maxEmail)));
       // sb.append(String.format(format, "-".repeat(maxTessera), "-".repeat(maxCf), "-".repeat(maxNome), "-".repeat(maxCognome), "-".repeat(maxSesso), "-".repeat(maxLuogo), "-".repeat(maxData), "-".repeat(maxCellulare), "-".repeat(maxTelefono), "-".repeat(maxEmail.length())));

        for (Customer customer : customerList) {
            sb.append(String.format(format, customer.getTessera(), customer.getCf(), customer.getNome(), customer.getCognome(), customer.getSesso(), customer.getLuogoNascita(), customer.getData(), customer.getCellulare(), customer.getTelefono(), customer.getEmail()));
        }

        return sb.toString();
    }
}
