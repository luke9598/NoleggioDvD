package model;

public class EndRental {

    private String titoloCopia;
    private String registaCopia;
    private String numeroCopia;
    private String dataInizio;
    private String tesseraCliente;
    private String costo;
    private String dataLimite;

    public EndRental(String titoloCopia, String registaCopia, String tesseraCliente, String dataInizio){
        this.titoloCopia = titoloCopia;
        this.registaCopia = registaCopia;
        this.tesseraCliente = tesseraCliente;
        this.dataInizio = dataInizio;
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

