package model;

public class Report {

    private String cf;
    private String ore;
    public Report(String cf, String ore){
        this.cf = cf;
        this.ore = ore;
    }

    public String getCf(){return this.cf;}

    public String getOre(){return this.ore;}
}
