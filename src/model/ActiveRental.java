package model;

public class ActiveRental{

    private String titoloCopia;
    private String registaCopia;
    private String numeroCopia;
    private String dataInizio;
    private String tesseraCliente;
    private String costo;
    private String dataLimite;

    public ActiveRental(String titoloCopia, String registaCopia, String numeroCopia,
                          String dataInizio, String tesseraCliente, String costo, String dataLimite) {
        this.titoloCopia = titoloCopia;
        this.registaCopia = registaCopia;
        this.numeroCopia = numeroCopia;
        this.dataInizio = dataInizio;
        this.tesseraCliente = tesseraCliente;
        this.costo = costo;
        this.dataLimite = dataLimite;
    }

    public ActiveRental(String titoloCopia, String registaCopia, String tesseraCliente, String costo){
        this.titoloCopia = titoloCopia;
        this.registaCopia = registaCopia;
        this.tesseraCliente = tesseraCliente;
        this.costo = costo;
    }

    public String getTitoloCopia() {
        return titoloCopia;
    }

    public void setTitoloCopia(String titoloCopia) {
        this.titoloCopia = titoloCopia;
    }

    public String getRegistaCopia() {
        return registaCopia;
    }

    public void setRegistaCopia(String registaCopia) {
        this.registaCopia = registaCopia;
    }

    public String getNumeroCopia() {
        return numeroCopia;
    }

    public void setNumeroCopia(String numeroCopia) {
        this.numeroCopia = numeroCopia;
    }

    public String getDataInizio() {
        return dataInizio;
    }

    public void setDataInizio(String dataInizio) {
        this.dataInizio = dataInizio;
    }

    public String getTesseraCliente() {
        return tesseraCliente;
    }

    public void setTesseraCliente(String tesseraCliente) {
        this.tesseraCliente = tesseraCliente;
    }

    public String getCosto() {
        return costo;
    }

    public void setCosto(String costo) {
        this.costo = costo;
    }

    public String getDataLimite() {
        return dataLimite;
    }

    public void setDataLimite(String dataLimite) {
        this.dataLimite = dataLimite;
    }
}

