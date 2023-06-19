package dbApps.minions;

import java.sql.*;
import java.util.Properties;
import java.util.Scanner;

public class GetMinionNames {

    public static final String GET_VILLAIN_NAME_BY_ID =
            "SELECT name FROM villains WHERE id = ?;";

    public static final String GET_MINIONS_INFO_BY_VILLAIN_ID =
            "SELECT name, age " +
            "FROM minions AS m " +
            "JOIN minions_villains AS mv ON m.id = mv.minion_id " +
            "WHERE mv.villain_id = ?;";

    public static void main(String[] args) throws SQLException {
        Scanner scanner = new Scanner(System.in);

        Connection connection = getConnection();

        PreparedStatement villainsStatement = connection.prepareStatement(GET_VILLAIN_NAME_BY_ID);
        int villainId = Integer.parseInt(scanner.nextLine());
        villainsStatement.setInt(1, villainId);

        ResultSet villainsResultSet = villainsStatement.executeQuery();

        if (!villainsResultSet.next()) {
            System.out.printf("No villain with ID %d exists in the database.", villainId);
            return;
        }

        PreparedStatement minionsInfoStatement = connection.prepareStatement(GET_MINIONS_INFO_BY_VILLAIN_ID);
        minionsInfoStatement.setInt(1, villainId);

        ResultSet minionsResultSet = minionsInfoStatement.executeQuery();

        while (minionsResultSet.next()) {
            System.out.printf("Villain: %s%n", villainsResultSet.getString(1));

        }

        for (int i = 1; minionsResultSet.next(); i++) {
            System.out.println("i.");
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
