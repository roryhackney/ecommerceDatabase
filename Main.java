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
                case 1:
                    System.out.println("You selected: View Inventory");
                    System.out.print(viewInventory(scan, conn));
                    System.out.println("Inventory complete.");
                    break;
                case 2:
                    System.out.println("You selected: Add New Product");
                    addProduct(scan, conn);
                    break;
                case 3:
                    System.out.println("You selected: Update Quantity");
                    updateQuantity(conn, scan);
                    break;
            }
            displayMenu();
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
        System.out.println("\nWelcome to the Dragon's Hoard Management System.");
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
        String query = "SELECT Product.SKU_ID AS SKU, WarehouseName, Count, IsSynthetic " +
                    ", Product.Name AS ProductName, Crystal.Name AS CrystalName " +
                    "FROM INVENTORY " +
                    "INNER JOIN PRODUCT ON INVENTORY.SKU_ID = PRODUCT.SKU_ID " +
                    "INNER JOIN CRYSTAL ON PRODUCT.CrystalID = CRYSTAL.ID " +
                    "ORDER BY WarehouseName, Count DESC";
        StringBuilder result = new StringBuilder("Count\tWarehouse Name\tSKU\t\tProduct Name\tIs Synthetic\tCrystal Name\n");
        //execute the query
        try {
            Statement statement = conn.createStatement();
            ResultSet results = statement.executeQuery(query);
            boolean hasNext = results.next();
            while (hasNext) {
                result.append(results.getString("Count")).append("\t\t");
                result.append(results.getString("WarehouseName")).append("\t\t");
                result.append(results.getString("SKU")).append("\t\t");
                result.append(results.getString("ProductName")).append("\t\t");
                result.append(results.getBoolean("IsSynthetic")).append("\t\t\t");
                result.append(results.getString("CrystalName")).append("\n");
                hasNext = results.next();
            }
            statement.close();
        } catch (SQLException e) {
            System.out.println("Database error. Please try again later.");
            System.out.println(e.getMessage());
            return "Database error.";
        }
        return result.toString();
    }

    public static void addProduct(Scanner scan, Connection conn) {
        int crystalId = getValidFK(conn, scan, "CRYSTAL", "ID", "Name");

        System.out.println("What should this product be named?");
        String name = "";
        while (name.isBlank()) {
            name = scan.nextLine().strip();
        }

        System.out.println("Describe the product in detail.");
        String description = "";
        while (description.isBlank()) {
            description = scan.nextLine().strip();
        }

        System.out.println("How much should this product cost?");
        double price = getDouble(scan, 0.01, 999.99);
        System.out.println("How wide is this product in inches?");
        double width = getDouble(scan, 0.01, 999.99);
        System.out.println("How tall is this product in inches?");
        double height = getDouble(scan, 0.01, 999.99);
        System.out.println("How heavy is this product in pounds?");
        double weight = getDouble(scan, 0.01, 999.99);
        System.out.println("How many crystals in this product?");
        int count = getChoice(scan, 1, 999);

        String insertQuery = String.format("INSERT INTO PRODUCT " +
                "(CrystalID, Name, Description, Price, WidthSize, HeightSize, Weight, PackCount) " +
                "VALUES (%d, %s,    %s,         %.2f,   %.2f,       %.2f,       %.2f,   %d);",
                crystalId, name, description, price, width,      height,     weight, count);
        System.out.println("Inserting: " + insertQuery);
        try {
            Statement statement = conn.createStatement();
            int updatedRows = statement.executeUpdate(insertQuery);
            if (updatedRows == 0) {
                System.out.println("Unable to insert into database.");
            } else {
                System.out.println("Successfully inserted into database.");
            }
            statement.close();
        } catch (SQLException e) {
            System.out.println("Unable to insert into database. " + e.getMessage());
        }
    }

    public static double getDouble(Scanner scan, double min, double max) {
        System.out.printf("Enter a double %.2f-%.2f ", min, max);
        Double choice = min - 1;
        while (choice.compareTo(min) < 0 || choice.compareTo(max) > 0) {
            while (!scan.hasNextDouble()) {
                scan.nextLine();
            }
            choice = scan.nextDouble();
            scan.nextLine();
        }
        return choice;
    }

    public static void updateQuantity(Connection conn, Scanner scan) {
        //print products and get id
        int productFK = getValidFK(conn, scan, "PRODUCT", "SKU_ID", "Name");

        //print warehouses and get warehouse
        String warehouse = getValidWarehouse(conn, scan);

        //if product not in warehouse, add to inventory table
        String currQty = "SELECT Count FROM INVENTORY " +
                         "WHERE SKU_ID = " + productFK +
                        " AND WarehouseName = '" + warehouse + "';";
        //if product in warehouse, update quantity
        try {
            Statement s = conn.createStatement();
            ResultSet r = s.executeQuery(currQty);
            int qty = 0;
            if (r.next()) {
                qty = r.getInt("Count");
            }
            System.out.println("There are currently " + qty + " of this product at " + warehouse);
            System.out.println("What should the quantity be set to? ");
            int quantity = getChoice(scan, 0, 999);
            String query = "";
            if (qty == 0) {
                query = String.format("INSERT INTO INVENTORY (SKU_ID, WarehouseName, Count) "
                        + "VALUES (%d, '%s', %d);", productFK, warehouse, quantity);
            } else {
                query = "UPDATE INVENTORY SET Count = " + quantity +
                        " WHERE SKU_ID = " + productFK +
                        " AND WarehouseName = '" + warehouse + "';";
            }
            int affectedRows = s.executeUpdate(query);
            if (affectedRows > 0) {
                System.out.println("Quantity successfully updated.");
            } else {
                System.out.println("Unable to update quantity. Please try again later.");
            }
        } catch (SQLException e) {
            System.out.println("Database error: " + e.getMessage());
        }
    }

    public static int getValidFK(Connection conn, Scanner scan, String table, String pk, String name) {
        // print options
        String query = String.format("SELECT %s, %s FROM %s ORDER BY %s", pk, name, table, pk);
        try {
            Statement s = conn.createStatement();
            ResultSet res = s.executeQuery(query);
            System.out.println(pk + "\t" + name);
            int max = 0;
            int min = 0;
            boolean hasNext = res.next();
            if (hasNext) min = res.getInt(pk);
            while (hasNext) {
                max = res.getInt(pk);
                System.out.print(max + "\t");
                System.out.println(res.getString(name));
                hasNext = res.next();
            }

            //get valid fk
            int fk = -1;
            boolean validId = false;
            System.out.println("Which " + table.toLowerCase() + " is this connected to?");
            while (! validId) {
                //validate chosen id
                fk = getChoice(scan, min, max);
                //if the number is not in the db, try again
                String checkID = String.format("SELECT %s FROM %s WHERE %s = %d", name, table, pk, fk);
                res = s.executeQuery(checkID);
                validId = res.next();
                if (! validId) {
                    System.out.println("ID not found in database. Please try again.");
                } else {
                    System.out.println("You selected " + res.getString(name));
                }
            }
            s.close();
            return fk;
        } catch (SQLException e) {
            System.out.println("Could not connect to database: " + e.getMessage());
        }
        return -1;
    }

    public static String getValidWarehouse(Connection conn, Scanner scan) {
        String query = "SELECT WarehouseName FROM WAREHOUSE";
        try {
            // print options
            Statement s = conn.createStatement();
            ResultSet res = s.executeQuery(query);
            System.out.println("Warehouse Name");
            while (res.next()) {
                System.out.println(res.getString("WarehouseName"));
            }

            //get valid warehouse
            System.out.println("Which warehouse would you like to select?");
            String warehouse = scan.nextLine().strip();
            String base = "SELECT * FROM WAREHOUSE WHERE WarehouseName = '";
            String checkQuery = base + warehouse + "';";
            res = s.executeQuery(checkQuery);
            while (! res.next()) {
                warehouse = scan.nextLine().strip();
                checkQuery = base + warehouse + "';";
                res = s.executeQuery(checkQuery);
            }
            return warehouse;
        } catch (SQLException e) {
            System.out.println("Database error: " + e.getMessage());
        }
        return "";
    }
}
