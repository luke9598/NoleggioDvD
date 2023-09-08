package model;

public class Customer {

    private String tessera;
    private String cf;
    private String nome;
    private String cognome;
    private String sesso;
    private String luogoNascita;
    private String data;

    private String cellulare;

    private String telefono;

    private String email;

    public Customer(String tessera){
        this.tessera = tessera;
    }

    public Customer(String tessera, String cf, String nome, String cognome, String sesso, String luogoNascita, String data,String cellulare,String telefono, String email){
        this.tessera = tessera;
        this.cf = cf;
        this.nome = nome;
        this.cognome = cognome;
        this.sesso = sesso;
        this.luogoNascita = luogoNascita;
        this.data = data;
        this.cellulare = cellulare;
        this.telefono = telefono;
        this.email = email;
    }

    public Customer(String tessera, String cf, String nome, String cognome, String sesso, String luogoNascita, String data){
        this.tessera = tessera;
        this.cf = cf;
        this.nome = nome;
        this.cognome = cognome;
        this.sesso = sesso;
        this.luogoNascita = luogoNascita;
        this.data = data;
    }

    public String getTessera() {
        return this.tessera;
    }

    public String getCf(){
        return this.cf;
    }

    public String getNome(){
        return this.nome;
    }

    public String getCognome(){
        return this.cognome;
    }

    public String getSesso(){
        return this.sesso;
    }

    public String getLuogoNascita(){
        return luogoNascita;
    }

    public String getData(){
        return this.data;
    }

    public String getCellulare(){
        return this.cellulare;
    }

    public String getTelefono(){
        return this.telefono;
    }

    public String getEmail(){
        return this.email;
    }
}
