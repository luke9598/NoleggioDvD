package dao;

import exception.DAOException;
import model.Report;
import model.ReportList;

import java.sql.CallableStatement;
import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.SQLException;

public class ReportDAO {


    public ReportList monthlyReport(String mese, String anno) throws DAOException {
        ReportList reportList = new ReportList();
        try {
            Connection conn = ConnectionFactory.getConnection();
            CallableStatement cs = conn.prepareCall("{call report_monthly_hours(?,?)}");
            cs.setString(1,mese);
            cs.setString(2,anno);
            boolean status = cs.execute();
            if (status) {
                ResultSet rs = cs.getResultSet();
                while (rs.next()) {
                    Report report = new Report(rs.getString(1), rs.getString(2));
                    reportList.addReport(report);
                }
            }
        } catch (SQLException e) {
            System.out.println("Errore SQL: " + e.getMessage());
            System.out.println("SQLState: " + e.getSQLState());
        }
        return reportList;
    }

    public ReportList yearlyReport(String anno)throws DAOException {
        ReportList reportList = new ReportList();
        try {
            Connection conn = ConnectionFactory.getConnection();
            CallableStatement cs = conn.prepareCall("{call report_yearly_hours(?)}");
            cs.setString(1,anno);
            boolean status = cs.execute();
            if (status) {
                ResultSet rs = cs.getResultSet();
                while (rs.next()) {
                    Report report = new Report(rs.getString(1), rs.getString(2));
                    reportList.addReport(report);
                }
            }
        } catch (SQLException e) {
            System.out.println("Errore SQL: " + e.getMessage());
            System.out.println("SQLState: " + e.getSQLState());
        }
        return reportList;
    }
}
