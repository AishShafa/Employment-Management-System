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
import javax.persistence.TemporalType;
import javax.persistence.criteria.CriteriaQuery;

/**
 *
 * @author aisha
 */
@Entity
public class Feedback implements Serializable {

    private static final long serialVersionUID = 1L;
    @Id
    @GeneratedValue(strategy = GenerationType.AUTO)
    private Long id;
    @Column(name = "FROMEMPLOYER")
    private String fromEmployer;

    @Column(name = "ABOUTEMPLOYEE")
    private String aboutEmployee;

    @Temporal(TemporalType.TIMESTAMP)
    @Column(name = "FEEDBACKDATE")
    private Date feedbackDate;

    @Column(name = "FEEDBACKTYPE")
    private String feedbackType;

    @Column(name = "MESSAGE")
    private String message;

    @Column(name = "STATUS")
    private String status = "Pending";

    @Column(name = "ADMINRESPONSE")
    private String adminResponse;

    public Feedback() {
    }

    public Feedback(Long id, String fromEmployer, String aboutEmployee, Date feedbackDate, String feedbackType, String message, String adminResponse) {
        this.id = id;
        this.fromEmployer = fromEmployer;
        this.aboutEmployee = aboutEmployee;
        this.feedbackDate = feedbackDate;
        this.feedbackType = feedbackType;
        this.message = message;
        this.adminResponse = adminResponse;
    }

    public String getFromEmployer() {
        return fromEmployer;
    }

    public void setFromEmployer(String fromEmployer) {
        this.fromEmployer = fromEmployer;
    }

    public String getAboutEmployee() {
        return aboutEmployee;
    }

    public void setAboutEmployee(String aboutEmployee) {
        this.aboutEmployee = aboutEmployee;
    }

    public Date getFeedbackDate() {
        return feedbackDate;
    }

    public void setFeedbackDate(Date feedbackDate) {
        this.feedbackDate = feedbackDate;
    }

    public String getFeedbackType() {
        return feedbackType;
    }

    public void setFeedbackType(String feedbackType) {
        this.feedbackType = feedbackType;
    }

    public String getMessage() {
        return message;
    }

    public void setMessage(String message) {
        this.message = message;
    }

    public String getStatus() {
        return status;
    }

    public void setStatus(String status) {
        this.status = status;
    }

    public String getAdminResponse() {
        return adminResponse;
    }

    public void setAdminResponse(String adminResponse) {
        this.adminResponse = adminResponse;
    }

    public Long getId() {
        return id;
    }

    public void setId(Long id) {
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
        if (!(object instanceof Feedback)) {
            return false;
        }
        Feedback other = (Feedback) object;
        if ((this.id == null && other.id != null) || (this.id != null && !this.id.equals(other.id))) {
            return false;
        }
        return true;
    }

    @Override
    public String toString() {
        return "model.Feedback[ id=" + id + " ]";
    }
    
}
