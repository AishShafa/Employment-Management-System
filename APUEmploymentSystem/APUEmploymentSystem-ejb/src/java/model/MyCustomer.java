/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package model;

import java.io.Serializable;
import java.util.Date;
import javax.persistence.Entity;
import javax.persistence.Id;
import javax.persistence.Column;
import javax.persistence.NamedQueries;
import javax.persistence.NamedQuery;
import javax.persistence.Table;

/**
 *
 * @author aisha
 */
@Entity
@NamedQueries({
    @NamedQuery(name = "MyCustomer.findByEmail", query = "SELECT m FROM MyCustomer m WHERE m.email = :email")
})

@Table(name="MyCustomer")
public class MyCustomer implements Serializable {

    private static final long serialVersionUID = 1L;

    @Id
    @Column(name = "email", nullable = false, unique = true)
    private String email;
    private String password;
    private String username;
    private String gender;
    private Date birthdate;
    
    @Column(name = "role", nullable = false)
    private String role;  // Added role field

    public MyCustomer() {
    }

    public MyCustomer(String email, String password, String username, String gender, Date birthdate, String role) {
        this.email = email;
        this.password = password;
        this.username = username;
        this.gender = gender;
        this.birthdate = birthdate;
        this.role = role;
    }
    

    public String getEmail() {
        return email;
    }

    public void setEmail(String email) {
        this.email = email;
    }

    public String getPassword() {
        return password;
    }

    public void setPassword(String password) {
        this.password = password;
    }

    public String getUsername() {
        return username;
    }

    public void setUsername(String username) {
        this.username = username;
    }

    public String getGender() {
        return gender;
    }

    public void setGender(String gender) {
        this.gender = gender;
    }

    public Date getBirthdate() {
        return birthdate;
    }

    public void setBirthdate(Date birthdate) {
        this.birthdate = birthdate;
    }
    
    public String getRole() { 
        return role;
    }

    public void setRole(String role) {
        this.role = role;
    }

    @Override
    public int hashCode() {
        int hash = 0;
        hash += (email != null ? email.hashCode() : 0);
        return hash;
    }

    @Override
    public boolean equals(Object object) {
        if (!(object instanceof MyCustomer)) {
            return false;
        }
        MyCustomer other = (MyCustomer) object;
        if ((this.email == null && other.email != null) || (this.email != null && !this.email.equals(other.email))) {
            return false;
        }
        return true;
    }

    @Override
    public String toString() {
        return "model.MyCustomer[ email=" + email + " ]";
    }


}



    
