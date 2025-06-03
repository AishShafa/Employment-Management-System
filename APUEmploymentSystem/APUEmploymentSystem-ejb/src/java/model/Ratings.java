/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package model;

import static com.sun.org.apache.xalan.internal.xsltc.compiler.util.Type.Int;
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
public class Ratings implements Serializable {

    private static final long serialVersionUID = 1L;
    @Id
    @GeneratedValue(strategy = GenerationType.AUTO)
    private String id;
    private String jobId; 
    @Column(name = "RATING")
    private int rating;
    private String comment;
    private String towho;
    private String fromwho;
    private Date whatdate;

    public Ratings() {
    }

    public Ratings(String id, String jobId,int rating, String comment, String towho, String fromwho, Date whatdate) {
        this.id = id;
        this.jobId = jobId;
        this.rating = rating;
        this.comment = comment;
        this.towho = towho;
        this.fromwho = fromwho;
        this.whatdate = whatdate;
    }

    public String getJobId() {
        return jobId;
    }

    public void setJobId(String jobId) {
        this.jobId = jobId;
    }

    public int getRating() {
        return rating;
    }

    public void setRating(int rating) {
        this.rating = rating;
    }

    public String getComment() {
        return comment;
    }

    public void setComment(String comment) {
        this.comment = comment;
    }

    public String getTowho() {
        return towho;
    }

    public void setTowho(String towho) {
        this.towho = towho;
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

    public String getId() {
        return id;
    }

    public void setId(String id) {
        this.id = id;
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
        if (!(object instanceof Ratings)) {
            return false;
        }
        Ratings other = (Ratings) object;
        if ((this.id == null && other.id != null) || (this.id != null && !this.id.equals(other.id))) {
            return false;
        }
        return true;
    }

    @Override
    public String toString() {
        return "model.Ratings[ id=" + id + " ]";
    }

    public void setjobId(String jobId) {
        throw new UnsupportedOperationException("Not supported yet."); //To change body of generated methods, choose Tools | Templates.
    }
    
}
