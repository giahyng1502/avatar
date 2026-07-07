import avatar.item.PartManager;
import java.sql.*;

public class print_farm_items {
    public static void main(String[] args) {
        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
            Connection conn = DriverManager.getConnection("jdbc:mysql://54.255.161.217:3306/avatar?useSSL=false", "admin", "1");
            Statement stmt = conn.createStatement();
            ResultSet rs = stmt.executeQuery("SELECT * FROM avatar_farm_item");
            while (rs.next()) {
                System.out.println("ID: " + rs.getInt("id") + " - Name: " + rs.getString("name"));
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
    }
}
