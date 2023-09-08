package model;

import java.util.ArrayList;
import java.util.List;

public class FilmCopyList {
    List<FilmCopy> copyList = new ArrayList<>();

    public void addCopy(FilmCopy copy){
        this.copyList.add(copy);
    }

    @Override
    public String toString() {

        if (copyList.isEmpty()) {
            return "Nessuna copia film disponibile.\n";
        }

        int maxTitoloLength = 0;
        int maxRegistaLength = 0;
        int maxNumeroLenght = 6;

        for (FilmCopy copy : copyList) {
            if (copy.getTitolo().length() > maxTitoloLength) {
                maxTitoloLength = copy.getTitolo().length();
            }
            if (copy.getRegista().length() > maxRegistaLength) {
                maxRegistaLength = copy.getRegista().length();
            }
            if (String.valueOf(copy.getNumero_copia()).length() > maxNumeroLenght) {
                maxNumeroLenght = String.valueOf(copy.getNumero_copia()).length();
            }

        }

        String format = "%-" + (maxTitoloLength) + "s | %-" +
                (maxRegistaLength) + "s | %-" + (maxNumeroLenght) + "s%n";
        StringBuilder sb = new StringBuilder();

        sb.append(String.format(format, "Titolo", "Regista", "Numero"));
        sb.append(String.format(format, "-".repeat(maxTitoloLength), "-".repeat(maxRegistaLength), "-".repeat(maxNumeroLenght)));

        for (FilmCopy copy : copyList) {
            sb.append(String.format(format, copy.getTitolo(), copy.getRegista(),
                    copy.getNumero_copia()));
        }

        return sb.toString();
    }
}
