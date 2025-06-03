package model;

import java.util.Date;
import javax.annotation.Generated;
import javax.persistence.metamodel.SingularAttribute;
import javax.persistence.metamodel.StaticMetamodel;

@Generated(value="EclipseLink-2.5.2.v20140319-rNA", date="2024-08-31T18:49:20")
@StaticMetamodel(MyCustomer.class)
public class MyCustomer_ { 

    public static volatile SingularAttribute<MyCustomer, String> password;
    public static volatile SingularAttribute<MyCustomer, Date> birthdate;
    public static volatile SingularAttribute<MyCustomer, String> role;
    public static volatile SingularAttribute<MyCustomer, String> gender;
    public static volatile SingularAttribute<MyCustomer, String> email;
    public static volatile SingularAttribute<MyCustomer, String> username;

}