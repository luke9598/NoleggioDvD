package model;

public class WorkShift {

    private String cf;
    private String inizio;
    private String fine;
    private String data;

    public WorkShift(String cf, String inizio, String fine, String data){
        this.cf = cf;
        this.inizio = inizio;
        this.fine = fine;
        this.data = data;
    }

    public WorkShift(String data){
        this.data = data;
    }

    public String getCf(){
        return this.cf;
    }
    public String getInizio(){
        return this.inizio;
    }

    public String getFine(){
        return this.fine;
    }

    public String getData(){
        return this.data;
    }

}
