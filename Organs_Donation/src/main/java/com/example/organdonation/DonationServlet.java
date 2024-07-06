package com.example.organdonation;

import java.io.IOException;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

@WebServlet("/DonationServlet")
public class DonationServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        HttpSession session = request.getSession();
        Integer userId = (Integer) session.getAttribute("user_id");
        if (userId == null) {
            response.sendRedirect("login.jsp");
            return;
        }

        String action = request.getParameter("action");

        if ("add".equals(action)) {
            addDonation(request, response, userId);
        } else if ("update".equals(action)) {
            updateDonation(request, response);
        } else if ("delete".equals(action)) {
            deleteDonation(request, response);
        }
    }

    private void addDonation(HttpServletRequest request, HttpServletResponse response, Integer userId) throws ServletException, IOException {
        String name = request.getParameter("name");
        String organName = request.getParameter("organ_name");
        String bloodGroup = request.getParameter("blood_group");

        Connection conn = null;
        PreparedStatement selectStmt = null;
        PreparedStatement updateStmt = null;
        ResultSet rs = null;

        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
            conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/OrganDonation", "root", "Soniya@777");

            // Check if the donor with the same name has donated before
            String selectSQL = "SELECT * FROM donors WHERE name = ? AND user_id = ?";
            selectStmt = conn.prepareStatement(selectSQL);
            selectStmt.setString(1, name);
            selectStmt.setInt(2, userId);
            rs = selectStmt.executeQuery();

            if (rs.next()) {
                // Donor has donated before
                int id = rs.getInt("id");
                String existingOrganName = rs.getString("organ_name");

                if (!existingOrganName.equals(organName)) {
                    // Update the existing donation with the another organ
                    String anotherOrganName = existingOrganName + ", " + organName;

                    String updateSQL = "UPDATE donors SET organ_name = ? WHERE id = ?";
                    updateStmt = conn.prepareStatement(updateSQL);
                    updateStmt.setString(1, anotherOrganName);
                    updateStmt.setInt(2, id);
                    updateStmt.executeUpdate();
                }
            } else {
                // Donor is donating for the first time
                String insertSQL = "INSERT INTO donors (user_id, name, organ_name, blood_group) VALUES (?, ?, ?, ?)";
                PreparedStatement insertStmt = conn.prepareStatement(insertSQL);
                insertStmt.setInt(1, userId);
                insertStmt.setString(2, name);
                insertStmt.setString(3, organName);
                insertStmt.setString(4, bloodGroup);
                insertStmt.executeUpdate();
            }

            response.sendRedirect("index.jsp?message=add_success");

        } catch (Exception e) {
            e.printStackTrace();
            throw new ServletException("Database operation failed", e);
        } finally {
            try {
                if (rs != null) rs.close();
                if (selectStmt != null) selectStmt.close();
                if (updateStmt != null) updateStmt.close();
                if (conn != null) conn.close();
            } catch (SQLException e) {
                e.printStackTrace();
            }
        }
    }

    private void updateDonation(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        int id = Integer.parseInt(request.getParameter("id"));
        String organName = request.getParameter("organ_name");

        Connection conn = null;
        PreparedStatement updateStmt = null;

        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
            conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/OrganDonation", "root", "Soniya@777");

            String updateSQL = "UPDATE donors SET organ_name = ? WHERE id = ?";
            updateStmt = conn.prepareStatement(updateSQL);
            updateStmt.setString(1, organName);
            updateStmt.setInt(2, id);
            updateStmt.executeUpdate();

            response.sendRedirect("index.jsp?message=update_success");
        } catch (Exception e) {
            e.printStackTrace();
            throw new ServletException("Database operation failed", e);
        } finally {
            try {
                if (updateStmt != null) updateStmt.close();
                if (conn != null) conn.close();
            } catch (SQLException e) {
                e.printStackTrace();
            }
        }
    }

    private void deleteDonation(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        int id = Integer.parseInt(request.getParameter("id"));

        Connection conn = null;
        PreparedStatement deleteStmt = null;

        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
            conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/OrganDonation", "root", "Soniya@777");

            String deleteSQL = "DELETE FROM donors WHERE id = ?";
            deleteStmt = conn.prepareStatement(deleteSQL);
            deleteStmt.setInt(1, id);
            deleteStmt.executeUpdate();

            response.sendRedirect("index.jsp?message=delete_success");
        } catch (Exception e) {
            e.printStackTrace();
            throw new ServletException("Database operation failed", e);
        } finally {
            try {
                if (deleteStmt != null) deleteStmt.close();
                if (conn != null) conn.close();
            } catch (SQLException e) {
                e.printStackTrace();
            }
        }
    }
}
