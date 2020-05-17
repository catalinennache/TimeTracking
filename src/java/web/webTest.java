/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package web;

import core.Companie;
import core.DBLinker;
import java.io.IOException;
import java.io.PrintWriter;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

/**
 *
 * @author Enache
 */
@WebServlet(name = "addAP", urlPatterns = {"/addAP"})
public class webTest extends HttpServlet {

    /**
     * Processes requests for both HTTP <code>GET</code> and <code>POST</code>
     * methods.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    
    
    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        try (PrintWriter out = response.getWriter()) {
            /* TODO output your page here. You may use following sample code. */
            out.println("<!DOCTYPE html>");
            out.println("<html>");
            out.println("<head>");
            out.println("<title>Servlet webTest</title>");            
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Testare I/O database " + request.getContextPath() + "</h1>");
           try{ DBLinker.getCompanies().forEach(( Companie comp)->{
                    out.println(comp.id_companie +" "+comp.user+" "+comp.parola+" <br>");
            });
           }catch(Exception e){
               out.println("Exceptie in getCompanies "+e.getLocalizedMessage());
           }
           
           
            out.println("<form method=\"POST\" action=\"\"> <input name=\"user\"> <input name=\"parola\"> <input type=\"submit\">");
            out.println("<h4> Stergere din tabel </h4> ");
            out.println("<form method=\"POST\" action=\"\"> <input name=\"delete\"> <input type=\"submit\">");
            out.println("</body>");
            out.println("</html>");
        }
    }

    // <editor-fold defaultstate="collapsed" desc="HttpServlet methods. Click on the + sign on the left to edit the code.">
    /**
     * Handles the HTTP <code>GET</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        
        
        
        processRequest(request, response);
    }

    /**
     * Handles the HTTP <code>POST</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
       String cod_proiect = request.getParameter("proiect");
       int id_angajat = Integer.parseInt(request.getParameter("angajat"));
       
     boolean scs =  DBLinker.addAngajatProiect(cod_proiect, id_angajat);
        
        response.getWriter().write("{\"scs\":"+scs+"}");
    }

    /**
     * Returns a short description of the servlet.
     *
     * @return a String containing servlet description
     */
    @Override
    public String getServletInfo() {
        return "Short description";
    }// </editor-fold>

}
