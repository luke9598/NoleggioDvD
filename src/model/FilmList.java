package model;

import java.util.ArrayList;
import java.util.List;

public class FilmList {
    List<Film> filmList = new ArrayList<>();

    public void addFilm(Film film){
        this.filmList.add(film);
    }

    @Override
    public String toString() {

        if (filmList.isEmpty()) {
            return "Nessun film disponibile.\n";
        }

        // Trova la lunghezza massima dei titoli, registi, anni e attori
        int maxTitoloLength = 0;
        int maxRegistaLength = 0;
        int maxAnnoLength = 0;
        int maxAttoriLength = 0;

        for (Film film : filmList) {
            if (film.getTitolo().length() > maxTitoloLength) {
                maxTitoloLength = film.getTitolo().length();
            }
            if (film.getRegista().length() > maxRegistaLength) {
                maxRegistaLength = film.getRegista().length();
            }
            if (String.valueOf(film.getAnno()).length() > maxAnnoLength) {
                maxAnnoLength = String.valueOf(film.getAnno()).length();
            }
            if (film.getLista_attori().length() > maxAttoriLength) {
                maxAttoriLength = film.getLista_attori().length();
            }
        }

        // Creazione del formato di output
        String format = "%-" + (maxTitoloLength) + "s | %-" +
                (maxRegistaLength) + "s | %-" + (maxAnnoLength) + "s | %-" +
                (maxAttoriLength) + "s%n";
        StringBuilder sb = new StringBuilder();

        sb.append(String.format(format, "Titolo", "Regista", "Anno", "Attori"));
        sb.append(String.format(format, "-".repeat(maxTitoloLength), "-".repeat(maxRegistaLength), "-".repeat(maxAnnoLength), "-".repeat(maxAttoriLength)));

        for (int i = 0; i < filmList.size(); i++) {
            Film film = filmList.get(i);
            sb.append(String.format(format, film.getTitolo(), film.getRegista(),
                    film.getAnno(), film.getLista_attori()));
        }

        return sb.toString();
    }
}
