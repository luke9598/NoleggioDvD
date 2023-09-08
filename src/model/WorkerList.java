package model;

import java.util.ArrayList;
import java.util.List;

public class WorkerList {

    private List<Worker> workerList = new ArrayList<>();

    public void addWorker(Worker worker) {
        this.workerList.add(worker);
    }

    @Override
    public String toString() {
        if (workerList.isEmpty()) {
            return "Nessun lavoratore disponibile.\n";
        }

        // Trova la lunghezza massima dei campi
        int maxCfLength = 0;
        int maxNomeLength = 0;
        int maxCellulareLength = 0;
        int maxTelefonoLength = 0;
        int maxEmailLength = 0;
        int maxRuoloLength = 0;
        int maxDataLength = 0;

        for (Worker worker : workerList) {
            if (worker.getCf().length() > maxCfLength) {
                maxCfLength = worker.getCf().length();
            }
            if (worker.getNome().length() > maxNomeLength) {
                maxNomeLength = worker.getNome().length();
            }
            if (worker.getCellulare().length() > maxCellulareLength) {
                maxCellulareLength = worker.getCellulare().length();
            }
            if (worker.getTelefono().length() > maxTelefonoLength) {
                maxTelefonoLength = worker.getTelefono().length();
            }
            if (worker.getEmail().length() > maxEmailLength) {
                maxEmailLength = worker.getEmail().length();
            }
            if (worker.getRuolo().length() > maxRuoloLength) {
                maxRuoloLength = worker.getRuolo().length();
            }
            if (worker.getData().length() > maxDataLength) {
                maxDataLength = worker.getData().length();
            }
        }

        // Creazione del formato di output
        String format = "%-" + (maxCfLength) + "s | %-" +
                (maxNomeLength) + "s | %-" + (maxCellulareLength) + "s | %-" +
                (maxTelefonoLength) + "s | %-" + (maxEmailLength) + "s | %-" +
                (maxRuoloLength) + "s | %-" + (maxDataLength) + "s%n";
        StringBuilder sb = new StringBuilder();

        sb.append(String.format(format, "CF", "Nome", "Cellulare", "Telefono", "Email", "Ruolo", "Data"));
        sb.append(String.format(format, "-".repeat(maxCfLength), "-".repeat(maxNomeLength),
                "-".repeat(maxCellulareLength), "-".repeat(maxTelefonoLength), "-".repeat(maxEmailLength),
                "-".repeat(maxRuoloLength), "-".repeat(maxDataLength)));

        for (int i = 0; i < workerList.size(); i++) {
            Worker worker = workerList.get(i);
            sb.append(String.format(format, worker.getCf(), worker.getNome(),
                    worker.getCellulare(), worker.getTelefono(),
                    worker.getEmail(), worker.getRuolo(), worker.getData()));
        }

        return sb.toString();
    }
}

