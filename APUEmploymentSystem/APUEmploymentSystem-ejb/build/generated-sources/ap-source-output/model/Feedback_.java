package model;

import java.util.Date;
import javax.annotation.Generated;
import javax.persistence.metamodel.SingularAttribute;
import javax.persistence.metamodel.StaticMetamodel;

@Generated(value="EclipseLink-2.5.2.v20140319-rNA", date="2024-08-31T18:49:20")
@StaticMetamodel(Feedback.class)
public class Feedback_ { 

    public static volatile SingularAttribute<Feedback, String> adminResponse;
    public static volatile SingularAttribute<Feedback, Date> feedbackDate;
    public static volatile SingularAttribute<Feedback, Long> id;
    public static volatile SingularAttribute<Feedback, String> aboutEmployee;
    public static volatile SingularAttribute<Feedback, String> message;
    public static volatile SingularAttribute<Feedback, String> fromEmployer;
    public static volatile SingularAttribute<Feedback, String> feedbackType;
    public static volatile SingularAttribute<Feedback, String> status;

}