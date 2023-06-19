package dbApps;

import java.sql.*;
import java.util.Properties;
import java.util.Scanner;

public class DataRetrievalApplication {

    private static final String SELECT_USER_GAMES_COUNT_BY_USERNAME =
            "SELECT first_name, last_name, COUNT(ug.game_id) " +
                    "FROM users AS u " +
                    "JOIN users_games AS ug ON u.id = ug.user_id " +
                    "WHERE u.user_name = ? " +
                    "GROUP BY first_name, last_name;";

    public static void main(String[] args) throws SQLException {

        Scanner scanner = new Scanner(System.in);

        Properties properties = new Properties();
        properties.setProperty("user", "root");
        properties.setProperty("password", "root");

        Connection connection = DriverManager.getConnection(
                "jdbc:mysql://localhost:3306/diablo", properties);

        String username = scanner.nextLine();

        PreparedStatement statement = connection.prepareStatement(SELECT_USER_GAMES_COUNT_BY_USERNAME);
        statement.setString(1, username);

        ResultSet resultSet = statement.executeQuery();

        if(resultSet.next()) {
            System.out.println("Username: " + username);
            System.out.printf("%s %s has played %d games",
                    resultSet.getString("first_name"),
                    resultSet.getString("last_name"),
                    resultSet.getInt(3));
        } else {
            System.out.println("No such user exists");
        }

        connection.close();
    }
}
