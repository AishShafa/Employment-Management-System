/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package model;

import javax.ejb.Stateless;
import javax.persistence.EntityManager;
import javax.persistence.PersistenceContext;
import javax.persistence.TypedQuery;

/**
 *
 * @author aisha
 */
@Stateless
public class NotificationsFacade extends AbstractFacade<Notifications> {

    @PersistenceContext(unitName = "APUEmploymentSystem-ejbPU")
    private EntityManager em;

    @Override
    protected EntityManager getEntityManager() {
        return em;
    }

    public NotificationsFacade() {
        super(Notifications.class);
    }
    public long countWarningsForEmployee(String employeeEmail) {
    try {
        String jpql = "SELECT COUNT(n) FROM Notifications n WHERE CAST(n.towho AS VARCHAR(128)) = :email AND n.message LIKE :message";
        return em.createQuery(jpql, Long.class)
                 .setParameter("email", employeeEmail)
                 .setParameter("message", "Warning:%")
                 .getSingleResult();
    } catch (Exception e) {
        e.printStackTrace();
        return 0;
    }
}

    
    
}
