package model;

import java.util.Date;
import javax.annotation.Generated;
import javax.persistence.metamodel.SingularAttribute;
import javax.persistence.metamodel.StaticMetamodel;

@Generated(value="EclipseLink-2.5.2.v20140319-rNA", date="2024-08-31T18:49:20")
@StaticMetamodel(Notifications.class)
public class Notifications_ { 

    public static volatile SingularAttribute<Notifications, String> towho;
    public static volatile SingularAttribute<Notifications, String> fromwho;
    public static volatile SingularAttribute<Notifications, Date> whatdate;
    public static volatile SingularAttribute<Notifications, String> id;
    public static volatile SingularAttribute<Notifications, String> message;

}