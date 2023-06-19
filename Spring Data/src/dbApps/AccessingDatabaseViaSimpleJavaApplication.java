package dbApps;

import java.sql.*;
import java.util.Properties;
import java.util.Scanner;

public class AccessingDatabaseViaSimpleJavaApplication {
    public static void main(String[] args) throws SQLException {

        Scanner scanner = new Scanner(System.in);

        Properties properties = new Properties();
        properties.setProperty("user", "root");
        properties.setProperty("password", "root");

        Connection connection = DriverManager.getConnection(
                "jdbc:mysql://localhost:3306/soft_uni", properties
        );

        PreparedStatement statement = connection.prepareStatement(
                "SELECT first_name, last_name FROM employees WHERE salary > ?;");
        String salary = scanner.nextLine();
        statement.setDouble(1, Double.parseDouble(salary));

        ResultSet resultSet = statement.executeQuery();

        while (resultSet.next()) {
            String fullName = resultSet.getString("first_name")
                     + " " + resultSet.getString("last_name");
            System.out.println(fullName);
        }

        connection.close();
    }
}
