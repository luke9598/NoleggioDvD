package model;

import java.util.ArrayList;
import java.util.List;

public class WorkShiftList {

    private List<WorkShift> workShiftList = new ArrayList<>();

    public void addWorkShift(WorkShift workShift) {
        this.workShiftList.add(workShift);
    }

    @Override
    public String toString() {
        if (workShiftList.isEmpty()) {
            return "Nessun turno disponibile.\n";
        }

        // Trova la lunghezza massima dei campi
        int maxCfLength = 0;
        int maxInizioLength = 6;
        int maxFineLength = 4;
        int maxDataLength = 0;

        for (WorkShift workShift : workShiftList) {
            if (workShift.getCf().length() > maxCfLength) {
                maxCfLength = workShift.getCf().length();
            }
            if (workShift.getInizio().length() > maxInizioLength) {
                maxInizioLength = workShift.getInizio().length();
            }
            if (workShift.getFine().length() > maxFineLength) {
                maxFineLength = workShift.getFine().length();
            }
            if (workShift.getData().length() > maxDataLength) {
                maxDataLength = workShift.getData().length();
            }
        }

        // Creazione del formato di output
        String format = "%-" + (maxCfLength) + "s | %-" +
                (maxInizioLength) + "s | %-" + (maxFineLength) + "s | %-" +
                (maxDataLength) + "s%n";
        StringBuilder sb = new StringBuilder();

        sb.append(String.format(format, "CF", "Inizio", "Fine", "Data"));
        sb.append(String.format(format, "-".repeat(maxCfLength), "-".repeat(maxInizioLength),
                "-".repeat(maxFineLength), "-".repeat(maxDataLength)));

        for (int i = 0; i < workShiftList.size(); i++) {
            WorkShift workShift = workShiftList.get(i);
            sb.append(String.format(format, workShift.getCf(), workShift.getInizio(),
                    workShift.getFine(), workShift.getData()));
        }

        return sb.toString();
    }
}

