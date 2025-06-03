/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package model;

import java.io.IOException;
import java.util.List;
import javax.ejb.Stateless;
import javax.persistence.EntityManager;
import javax.persistence.PersistenceContext;
import javax.persistence.TypedQuery;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

/**
 *
 * @author aisha
 */
@Stateless
public class MyCustomerFacade extends AbstractFacade<MyCustomer> {

    @PersistenceContext(unitName = "APUEmploymentSystem-ejbPU")
    private EntityManager em;

    @Override
    protected EntityManager getEntityManager() {
        return em;
    }

    public MyCustomerFacade() {
        super(MyCustomer.class);
    }
    
    
    
    public MyCustomer findByEmail(String email) {
        try {
            return em.createNamedQuery("MyCustomer.findByEmail", MyCustomer.class)
                     .setParameter("email", email)
                     .getSingleResult();
        } catch (Exception e) {
            return null;
        }
    }
    
    public List<MyCustomer> searchCustomers(String role, String username, String gender, String email) {
        StringBuilder queryStr = new StringBuilder("SELECT m FROM MyCustomer m WHERE 1=1");

        if (role != null && !role.isEmpty()) {
            queryStr.append(" AND m.role = :role");
        }
        if (username != null && !username.isEmpty()) {
            queryStr.append(" AND m.username LIKE :username");
        }
        if (gender != null && !gender.isEmpty()) {
            queryStr.append(" AND m.gender = :gender");
        }
        if (email != null && !email.isEmpty()) {
            queryStr.append(" AND m.email LIKE :email");
        }

        TypedQuery<MyCustomer> query = em.createQuery(queryStr.toString(), MyCustomer.class);

        if (role != null && !role.isEmpty()) {
            query.setParameter("role", role);
        }
        if (username != null && !username.isEmpty()) {
            query.setParameter("username", "%" + username + "%");
        }
        if (gender != null && !gender.isEmpty()) {
            query.setParameter("gender", gender);
        }
        if (email != null && !email.isEmpty()) {
            query.setParameter("email", "%" + email + "%");
        }

        return query.getResultList();
    }
    
}