import java.util.Properties;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.ResultSet;

public class KerberosConnect {

    // set the krb5.conf and jaas.conf path
    static {
        System.setProperty("java.security.krb5.conf",
                "/home/ubuntu/krb5/conf/krb5.conf");
        System.setProperty("javax.security.auth.useSubjectCredsOnly", "false");
        System.setProperty("java.security.auth.login.config",
                "/home/ubuntu/krb5/conf/jaas.conf");
    }

    public static void main(String... args) {

        // setting the db url
        String url = "jdbc:postgresql://postgres.ONPREM.LOCAL:5432/postgres";

        // setting the jaasconfig
        Properties properties = new Properties();
        properties.setProperty("JAASConfigName", "pgjdbc");
        properties.setProperty("user", "HTTP/devaz@ONPREM.LOCAL");

        // creating a new connection
        try (Connection conn = DriverManager.getConnection(url, properties)) {
            // executing the query
            ResultSet resultSet = conn.createStatement().executeQuery("Select current_user");
            resultSet.next();
            System.out.println("The username is : " + resultSet.getString(1));
        } catch (Exception e) {
            e.printStackTrace();
        }
    }
}