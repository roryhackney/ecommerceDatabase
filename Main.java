import java.sql.*;
import java.util.Scanner;

public class Main {
    public static void main(String[] args) {
        //open database
        Connection conn = null;
        try {
            conn = DriverManager.getConnection("jdbc:mysql://127.0.0.1/dragons_hoard_shop?"
            + "user=root&password=Givsri7h");
        } catch (SQLException e) {
            System.out.println("Could not connect to database, exiting:" + e.getMessage());
            return;
        }

        //do stuff in the database
        runMenu(conn);

        //close database
        try {
            conn.close();
        } catch (SQLException e) {
            System.out.println(e.getMessage());
        }
    }
    public static void runMenu(Connection conn) {
        displayMenu();
        Scanner scan = new Scanner(System.in);
        int choice = getChoice(scan, 1, 8);
        while (choice != 8) {
            switch (choice) {
                case 1: {
                    viewInventory(scan, conn);
                }
            }
            choice = getChoice(scan, 1, 8);
        }
        System.out.println("Have a nice day.");
    }
    public static int getChoice(Scanner scan, int min, int max) {
        int choice = min - 1;
        System.out.print("What would you like to do? Enter a number " + min + "-" + max + ": ");
        while (choice < min || choice > max) {
            while (! scan.hasNextInt()) {
                scan.nextLine();
            }
            choice = scan.nextInt();
            scan.nextLine();
        }
        System.out.println();
        return choice;
    }

    public static void displayMenu() {
        System.out.println("Welcome to the Dragon's Hoard Management System.");
        System.out.println("\t1. View inventory\n" +
                        "\t2. Add new product\n" +
                        "\t3. Update quantity of a product\n" +
                        "\t4. Delete / discontinue a product\n" +
                        "\t5. Get most popular products during date range\n" +
                        "\t6. Get least popular products during date range\n" +
                        "\t7. Get users for promo and their favorite products\n\n" +
                        "\t8. Quit");
    }

    public static String viewInventory(Scanner scan, Connection conn) {
        System.out.println("You selected: View Inventory");
        System.out.print("Enter Y to view by Warehouse or N for global quantities: ");
        String choice = scan.nextLine().strip();

        //write the query
        String query;
        if (choice.equals("Y")) {
            query = "SELECT SKU_ID, Count, WarehouseName" +
                    "FROM INVENTORY ORDER BY WarehouseName, Count";
            query = "DESCRIBE INVENTORY";
        } else {
            query = "SELECT SKU_ID, Count";
        }

        //execute the query
        try {
            Statement statement = conn.createStatement();
            ResultSet results = statement.executeQuery(query);
            boolean hasNext = results.next();
            while (hasNext) {
                System.out.println(results.getString(1));
                hasNext = results.next();
            }
            statement.close();
        } catch (SQLException e) {
            System.out.println("Database error. Please try again later.");
            System.out.println(e.getMessage());
            return "Database error.";
        }
        return "";
    }
}
