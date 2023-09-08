package model;

public class Worker {
    private String cf;
    private String nome;

    private String cellulare;

    private String telefono;

    private String email;
    private String ruolo;
    private String data;

    public Worker(String cf,String ruolo){
        this.cf = cf;
        this.ruolo = ruolo;
    }
    public Worker(String cf, String nome, String cellulare,String telefono, String email, String ruolo){
        this.cf = cf;
        this.nome = nome;
        this.cellulare = cellulare;
        this.telefono = telefono;
        this.email = email;
        this.ruolo = ruolo;
    }

    public Worker(String cf, String nome, String cellulare,String telefono, String email, String ruolo, String data){
        this.cf = cf;
        this.nome = nome;
        this.cellulare = cellulare;
        this.telefono = telefono;
        this.email = email;
        this.ruolo = ruolo;
        this.data = data;
    }


    public String getCf(){
        return this.cf;
    }

    public String getNome(){
        return this.nome;
    }

    public String getRuolo(){return this.ruolo;}
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
