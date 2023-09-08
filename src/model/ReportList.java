package model;
import java.util.ArrayList;
import java.util.List;

public class ReportList {

    private List<Report> reports = new ArrayList<>();

    public void addReport(Report report) {
        this.reports.add(report);
    }

    @Override
    public String toString() {
        if (reports.isEmpty()) {
            return "Nessun report disponibile.\n";
        }

        // Trova la lunghezza massima dei campi CF e Ore
        int maxCfLength = 0;
        int maxOreLength = 0;

        for (Report report : reports) {
            if (report.getCf().length() > maxCfLength) {
                maxCfLength = report.getCf().length();
            }
            if (report.getOre().length() > maxOreLength) {
                maxOreLength = report.getOre().length();
            }
        }

        // Creazione del formato di output
        String format = "%-" + (maxCfLength) + "s | %-" +
                (maxOreLength) + "s%n";
        StringBuilder sb = new StringBuilder();

        sb.append(String.format(format, "CF", "Ore"));
        sb.append(String.format(format, "-".repeat(maxCfLength), "-".repeat(maxOreLength)));

        for (int i = 0; i < reports.size(); i++) {
            Report report = reports.get(i);
            sb.append(String.format(format, report.getCf(), report.getOre()));
        }

        return sb.toString();
    }
}
