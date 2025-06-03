package model;

import java.util.Date;
import javax.annotation.Generated;
import javax.persistence.metamodel.SingularAttribute;
import javax.persistence.metamodel.StaticMetamodel;

@Generated(value="EclipseLink-2.5.2.v20140319-rNA", date="2024-08-31T18:49:20")
@StaticMetamodel(Ratings.class)
public class Ratings_ { 

    public static volatile SingularAttribute<Ratings, String> jobId;
    public static volatile SingularAttribute<Ratings, String> towho;
    public static volatile SingularAttribute<Ratings, String> fromwho;
    public static volatile SingularAttribute<Ratings, Integer> rating;
    public static volatile SingularAttribute<Ratings, Date> whatdate;
    public static volatile SingularAttribute<Ratings, String> comment;
    public static volatile SingularAttribute<Ratings, String> id;

}