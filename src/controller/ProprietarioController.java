package controller;

import dao.*;
import exception.DAOException;
import model.*;
import view.ProprietarioView;

import java.io.IOException;
import java.sql.SQLException;

public class ProprietarioController implements Controller{
    @Override
    public void start(){
        try{
            ConnectionFactory.changeRole(Role.PROPRIETARIO);
        }catch(SQLException e){
            throw new RuntimeException(e);
        }
        while(true){
            int choice;
            try{
                choice = ProprietarioView.showMenu();
            }catch (IOException e){
                throw new RuntimeException(e);
            }

            switch(choice){
                case 1 -> addWorker();
                case 2 -> modWork();
                case 3 -> allWorkers();
                case 4 -> addWorkShift();
                case 5 -> updateWorkshift();
                case 6 -> deleteWorkshift();
                case 7 -> dayWarkshift();
                case 8 -> reportMonthly();
                case 9 -> reportYearly();
                case 10 -> System.exit(0);
                default -> throw new RuntimeException("Invalid choice");
            }
        }
    }

    private void reportYearly() {
        ReportList reportList;
        Data data;
        try {
            data = ProprietarioView.selectYear();
        } catch(IOException e) {
            throw new RuntimeException(e);
        }try {
            reportList = new ReportDAO().yearlyReport(data.getAnno());
        } catch(DAOException e) {
            throw new RuntimeException(e);
        }
        System.out.print(reportList);
    }

    private void reportMonthly() {
        ReportList reportList;
        Data data;
        try {
            data = ProprietarioView.selectMonth();
        } catch(IOException e) {
            throw new RuntimeException(e);
        }try {
            reportList = new ReportDAO().monthlyReport(data.getMese(),data.getAnno());
        } catch(DAOException e) {
            throw new RuntimeException(e);
        }
        System.out.print(reportList);
    }

    private void dayWarkshift() {
        WorkShiftList workShiftList;
        WorkShift date;
        try {
            date = ProprietarioView.selectDate();
        } catch(IOException e) {
            throw new RuntimeException(e);
        }try {
            workShiftList = new WorkShiftDAO().getWorkerShiftList(date.getData());
        } catch(DAOException e) {
            throw new RuntimeException(e);
        }
        System.out.print(workShiftList);
    }

    private void allWorkers() {
        WorkerList workerList;
        try {
            workerList = new WorkerDAO().getWorkerList();
        } catch(DAOException e) {
            throw new RuntimeException(e);
        }
        System.out.print(workerList);
    }




    private void deleteWorkshift() {
        WorkShift workShift;
        try {
            workShift = ProprietarioView.selectWorkShift();
        } catch(IOException e) {
            throw new RuntimeException(e);
        }try {
            new WorkShiftDAO().deleteWorkShift(workShift.getCf(), workShift.getInizio(), workShift.getFine(), workShift.getData());
        } catch(DAOException e) {
            throw new RuntimeException(e);
        }
    }


    private void updateWorkshift() {
        WorkShift workShift;
        try {
            workShift = ProprietarioView.selectNewWorkShift();
        } catch(IOException e) {
            throw new RuntimeException(e);
        }try {
            new WorkShiftDAO().modWorkShift(workShift.getCf(), workShift.getInizio(), workShift.getFine(), workShift.getData());
        } catch(DAOException e) {
            throw new RuntimeException(e);
        }
    }

    private void addWorkShift() {
        WorkShift workShift;
        try {
            workShift = ProprietarioView.selectWorkShift();
        } catch(IOException e) {
            throw new RuntimeException(e);
        }try {
            new WorkShiftDAO().addWorkShift(workShift.getCf(), workShift.getInizio(), workShift.getFine(), workShift.getData());
        } catch(DAOException e) {
            throw new RuntimeException(e);
        }
    }

    private void modWork() {
        Worker worker;
        try {
            worker = ProprietarioView.selectWork();
        } catch(IOException e) {
            throw new RuntimeException(e);
        }try {
            new WorkerDAO().addWork(worker.getCf(),worker.getRuolo());
        } catch(DAOException e) {
            throw new RuntimeException(e);
        }
    }

    private void addWorker() {
        Worker worker;
        try {
            worker = ProprietarioView.selectWorker();
        } catch(IOException e) {
            throw new RuntimeException(e);
        }try {
            new WorkerDAO().addWorker(worker.getCf(),worker.getNome(),worker.getCellulare(),worker.getTelefono(),worker.getEmail(),worker.getRuolo());
        } catch(DAOException e) {
            throw new RuntimeException(e);
        }
    }
}
