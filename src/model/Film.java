package model;

import java.util.Date;

public class Film {

    String titolo;
    String regista;
    Date anno;
    String lista_attori;

    public Film(String titolo,String regista, Date anno, String lista_attori){
        this.titolo = titolo;
        this.regista = regista;
        this.anno = anno;
        this.lista_attori = lista_attori;
    }

    public String getTitolo() {
        return titolo;
    }

    public String getRegista() {
        return regista;
    }

    public String getAnno() {
        return anno.toString();
    }

    public String getLista_attori() {
        return lista_attori;
    }


    @Override
    public String toString() {
        return "FILM{" +
                "titolo='" + titolo +'\''+
                ", regista='"+ regista+'\'' +
                ", anno='"+anno +'\''+
                ", attori='"+ lista_attori +'\''+
                "}\n" ;
    }
}
