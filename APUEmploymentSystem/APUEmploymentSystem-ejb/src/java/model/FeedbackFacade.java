/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package model;

import java.util.List;
import javax.ejb.Stateless;
import javax.persistence.EntityManager;
import javax.persistence.PersistenceContext;
import javax.persistence.criteria.CriteriaBuilder;
import javax.persistence.criteria.CriteriaQuery;
import javax.persistence.criteria.Root;

/**
 *
 * @author aisha
 */
@Stateless
public class FeedbackFacade extends AbstractFacade<Feedback> {

    @PersistenceContext(unitName = "APUEmploymentSystem-ejbPU")
    private EntityManager em;

    @Override
    protected EntityManager getEntityManager() {
        return em;
    }

    public FeedbackFacade() {
        super(Feedback.class);
    }
    public List<Feedback> findAllFeedback() {
        CriteriaQuery<Feedback> cq = em.getCriteriaBuilder().createQuery(Feedback.class);
        cq.select(cq.from(Feedback.class));
        return em.createQuery(cq).getResultList();
    }
}
