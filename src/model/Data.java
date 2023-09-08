package model;

public class Data {
    private String mese;
    private String anno;
    public Data(String mese, String anno){
        this.mese = mese;
        this.anno = anno;
    }

    public Data( String anno){
        this.anno = anno;
    }

    public String getMese(){return this.mese;}

    public String getAnno(){return this.anno;}
}