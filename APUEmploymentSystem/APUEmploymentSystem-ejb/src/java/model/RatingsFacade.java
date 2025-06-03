/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package model;

import javax.ejb.Stateless;
import javax.persistence.EntityManager;
import javax.persistence.PersistenceContext;

/**
 *
 * @author aisha
 */
@Stateless
public class RatingsFacade extends AbstractFacade<Ratings> {

    @PersistenceContext(unitName = "APUEmploymentSystem-ejbPU")
    private EntityManager em;

    @Override
    protected EntityManager getEntityManager() {
        return em;
    }

    public RatingsFacade() {
        super(Ratings.class);
    }

    @Override
    public void create(Ratings entity) {
        super.create(entity);
    }
    
}
