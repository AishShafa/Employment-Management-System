package model;

import java.util.Date;
import javax.annotation.Generated;
import javax.persistence.metamodel.SingularAttribute;
import javax.persistence.metamodel.StaticMetamodel;

@Generated(value="EclipseLink-2.5.2.v20140319-rNA", date="2024-08-31T18:49:20")
@StaticMetamodel(Applicants.class)
public class Applicants_ { 

    public static volatile SingularAttribute<Applicants, Long> jobId;
    public static volatile SingularAttribute<Applicants, String> id;
    public static volatile SingularAttribute<Applicants, String> applicantName;
    public static volatile SingularAttribute<Applicants, String> Gender;
    public static volatile SingularAttribute<Applicants, Date> Birthdate;
    public static volatile SingularAttribute<Applicants, String> email;
    public static volatile SingularAttribute<Applicants, Date> applicationDate;

}