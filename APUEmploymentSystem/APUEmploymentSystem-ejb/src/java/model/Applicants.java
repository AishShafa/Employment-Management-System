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
import javax.persistence.Temporal;

/**
 *
 * @author aisha
 */
@Entity
public class Applicants implements Serializable {

    private static final long serialVersionUID = 1L;
    @Id
    @GeneratedValue(strategy = GenerationType.AUTO)
    private String id;
    private Long jobId;
    @Column(name = "NAME")
    private String applicantName;
    @Column(name = "EMAIL")
    private String email;
    @Temporal(javax.persistence.TemporalType.DATE)
    @Column(name = "APPLIED_DATE")
    private Date applicationDate;
    @Column(name = "BIRTHDATE")
    private Date Birthdate;
    @Column(name = "GENDER")
    private String Gender;

    public Applicants() {
    }

    public Applicants(String id, Long applicantId, Long jobId, String applicantName, String email, Date applicationDate) {
        this.id = id;
        this.jobId = jobId;
        this.applicantName = applicantName;
        this.email = email;
        this.applicationDate = applicationDate;
    }


    public Long getJobId() {
        return jobId;
    }

    public void setJobId(Long jobId) {
        this.jobId = jobId;
    }

    public String getApplicantName() {
        return applicantName;
    }

    public void setApplicantName(String applicantName) {
        this.applicantName = applicantName;
    }

    public String getEmail() {
        return email;
    }

    public void setEmail(String email) {
        this.email = email;
    }


    public Date getApplicationDate() {
        return applicationDate;
    }

    public void setApplicationDate(Date applicationDate) {
        this.applicationDate = applicationDate;
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
        if (!(object instanceof Applicants)) {
            return false;
        }
        Applicants other = (Applicants) object;
        if ((this.id == null && other.id != null) || (this.id != null && !this.id.equals(other.id))) {
            return false;
        }
        return true;
    }

    @Override
    public String toString() {
        return "model.Applicants[ id=" + id + " ]";
    }

    public void setBirthdate(Date birthdate) {
    this.Birthdate = birthdate;
    }

    public void setGender(String gender) {
        this.Gender = gender;
    }

    
}
