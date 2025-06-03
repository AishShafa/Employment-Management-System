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
public class VacancyFacade extends AbstractFacade<Vacancy> {

    @PersistenceContext(unitName = "APUEmploymentSystem-ejbPU")
    private EntityManager em;

    @Override
    protected EntityManager getEntityManager() {
        return em;
    }

    public VacancyFacade() {
        super(Vacancy.class);
    }
    
}
