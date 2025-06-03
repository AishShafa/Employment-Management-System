/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package model;

import java.io.Serializable;
import java.util.Date;
import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;

/**
 *
 * @author aisha
 */
@Entity
public class Notifications implements Serializable {

    private static final long serialVersionUID = 1L;
    @Id
    @GeneratedValue(strategy = GenerationType.AUTO)
    private String id;
    private String message;
    private String fromwho;
    @Column(name = "TOWHO")
    private String towho;
    private Date whatdate;

    public Notifications() {
    }

    public Notifications(String id, String message, String from, Date date) {
        this.id = id;
        this.message = message;
        this.fromwho = fromwho;
        this.towho = towho;
        this.whatdate = whatdate;
    }

    public String getTowho() {
        return towho;
    }

    public void setTowho(String towho) {
        this.towho = towho;
    }

    public String getId() {
        return id;
    }

    public void setId(String id) {
        this.id = id;
    }

    public String getMessage() {
        return message;
    }

    public void setMessage(String message) {
        this.message = message;
    }

    public String getFromwho() {
        return fromwho;
    }

    public void setFromwho(String fromwho) {
        this.fromwho = fromwho;
    }

    public Date getWhatdate() {
        return whatdate;
    }

    public void setWhatdate(Date whatdate) {
        this.whatdate = whatdate;
    }



    @Override
    public int hashCode() {
        int hash = 0;
        hash += (id != null ? id.hashCode() : 0);
        return hash;
    }

    @Override
    public boolean equals(Object object) {
        // TODO: Warning - this method won't work in the case the id fields are not set
        if (!(object instanceof Notifications)) {
            return false;
        }
        Notifications other = (Notifications) object;
        if ((this.id == null && other.id != null) || (this.id != null && !this.id.equals(other.id))) {
            return false;
        }
        return true;
    }

    @Override
    public String toString() {
        return "model.Notifications[ id=" + id + " ]";
    }
    
}
