package model;

import java.util.ArrayList;
import java.util.List;

public class ActiveRentalList {

    List<ActiveRental> activeRentalList = new ArrayList<>();

    public void addActiveRental(ActiveRental rental){
        this.activeRentalList.add(rental);
    }

    @Override
    public String toString(){

    if (activeRentalList.isEmpty()) {
        return "Nessun noleggio attivo al momento.\n";
    }

    int maxTitoloLength = 0;
    int maxRegistaLength = 0;
    int maxNumeroLenght = 6;
    int maxDataLength = 10;
    int maxTesseraLength = 7;
    int maxCostoLength = 5;

        for (ActiveRental activeRental : activeRentalList) {
        if (activeRental.getTitoloCopia().length() > maxTitoloLength) {
            maxTitoloLength = activeRental.getTitoloCopia().length();
        }
        if (activeRental.getRegistaCopia().length() > maxRegistaLength) {
            maxRegistaLength = activeRental.getRegistaCopia().length();
        }
        if (String.valueOf(activeRental.getNumeroCopia()).length() > maxNumeroLenght) {
            maxNumeroLenght = String.valueOf(activeRental.getNumeroCopia()).length();
        }
        if (String.valueOf(activeRental.getCosto()).length() > maxCostoLength) {
            maxCostoLength = String.valueOf(activeRental.getCosto()).length();
        }

    }

    String format = "%-" + (maxTitoloLength) + "s | %-" +
            (maxRegistaLength) + "s | %-" + (maxNumeroLenght) + "s | %-" + (maxDataLength) +"s | %-" + (maxTesseraLength) + "s | %-" + (maxCostoLength) +"s | %-" + (maxDataLength) +"s%n";
    StringBuilder sb = new StringBuilder();

        sb.append(String.format(format, "Titolo", "Regista", "Numero","Inizio","Tessera","Costo","Fine"));
        sb.append(String.format(format, "-".repeat(maxTitoloLength), "-".repeat(maxRegistaLength), "-".repeat(maxNumeroLenght), "-".repeat(maxDataLength), "-".repeat(maxTesseraLength), "-".repeat(maxCostoLength), "-".repeat(maxDataLength)));

        for (int i = 0; i < activeRentalList.size(); i++) {
        ActiveRental rental = activeRentalList.get(i);
        sb.append(String.format(format, rental.getTitoloCopia(), rental.getRegistaCopia(), rental.getNumeroCopia(),
                rental.getDataInizio(),rental.getTesseraCliente(),rental.getCosto(),rental.getDataLimite()));
    }

        return sb.toString();
}
}
