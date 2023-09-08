package model;

public class FilmCopy extends Film{
    String numero_copia;

    public FilmCopy(String titolo, String regista, String numero){
        super(titolo,regista,null,null);
        this.numero_copia = numero;
    }

    public String getNumero_copia(){
        return this.numero_copia;
    }

    @Override
    public String toString() {
        return "FILM_COPY{" +
                "titolo='" + titolo +'\''+
                ", regista='"+ regista+'\'' +
                ", numero_copia='"+numero_copia +'\''+
                "}\n" ;
    }
}
