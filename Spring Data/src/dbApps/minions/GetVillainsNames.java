package dbApps.minions;

import java.sql.*;
import java.util.Properties;
import java.util.Scanner;

public class GetVillainsNames {

    public static final String GET_VILLAINS_MINIONS_COUNT =
            "SELECT v.name, COUNT(DISTINCT mv.minion_id) AS 'minions_count' " +
            "FROM villains AS v " +
            "JOIN minions_villains AS mv ON v.id = mv.villain_id " +
            "GROUP BY v.name " +
            "HAVING minions_count > 15 " +
            "ORDER BY minions_count DESC;";

    public static void main(String[] args) throws SQLException {
        Scanner scanner = new Scanner(System.in);

        Connection connection = getConnection();

        PreparedStatement statement = connection.prepareStatement(GET_VILLAINS_MINIONS_COUNT);

        ResultSet resultSet = statement.executeQuery();

        while (resultSet.next()) {
            String villainName = resultSet.getString(1);
            String minionsCount = resultSet.getString(2);

            System.out.println(villainName + " " + minionsCount);
        }

    }

    private static Connection getConnection() throws SQLException {
        Properties properties = new Properties();
        properties.setProperty("user", "root");
        properties.setProperty("password", "root");

        Connection connection = DriverManager.getConnection(
                "jdbc:mysql://localhost:3306/minions_db", properties
        );
        return connection;
    }

}
