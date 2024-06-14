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
                    System.out.println("You selected: View Inventory (By Warehouse)");
                    System.out.print(viewInventory(scan, conn));
                    System.out.println("Inventory complete.");
                    break;
                case 2:
                    System.out.println("You selected: Add New Product");
                    addProduct(scan, conn);
                    break;
                case 3:
                    System.out.println("You selected: Update Quantity of a Product");
                    updateProductQuantity(scan, conn);
                    break;
                case 4:
                    System.out.println("You selected: Delete Product");
                    deleteProduct(scan, conn);
                    break;
                case 5:
                    System.out.println("You selected: Get Most Popular Products During Date Range");
                    getMostPopularProducts(scan, conn);
                    break;
                case 6:
                    System.out.println("You selected: Get Least Popular Products During Date Range");
                    getLeastPopularProducts(scan, conn);
                    break;
                case 7:
                    System.out.println("You selected: Get Users for Promo and Their Favorite Products");
                    getUsersForPromo(scan, conn);
                    break;
                default:
                    System.out.println("Invalid choice.");
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
            while (!scan.hasNextInt()) {
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
        // print crystal names and ids
        System.out.println("Which crystal is this product made with?");
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

        // call the stored procedure to add the new product
        try {
            CallableStatement stmt = conn.prepareCall("{CALL AddNewProduct(?, ?, ?, ?, ?, ?, ?, ?)}");
            stmt.setInt(1, crystalId);
            stmt.setString(2, name);
            stmt.setString(3, description);
            stmt.setDouble(4, price);
            stmt.setDouble(5, width);
            stmt.setDouble(6, height);
            stmt.setDouble(7, weight);
            stmt.setInt(8, count);
            stmt.execute();
            stmt.close();
            System.out.println("Product added successfully.");
        } catch (SQLException e) {
            System.out.println("Database error. Please try again later.");
            System.out.println(e.getMessage());
        }
    }

    public static void updateProductQuantity(Scanner scan, Connection conn) {
        System.out.println("Enter the SKU of the product you want to update:");
        int sku = getValidFK(conn, scan, "PRODUCT", "SKU_ID", "Name");
        System.out.println("Enter the warehouse where the product is located:");
        String warehouse = getValidWarehouse(conn, scan);

        System.out.println("Enter the new quantity:");
        int newQuantity = getChoice(scan, 0, 999);

        // Check if the product exists in the given warehouse
        String checkQuery = "SELECT Count FROM INVENTORY WHERE SKU_ID = ? AND WarehouseName = ?";

        try {
            PreparedStatement checkStmt = conn.prepareStatement(checkQuery);
            checkStmt.setInt(1, sku);
            checkStmt.setString(2, warehouse);
            ResultSet rs = checkStmt.executeQuery();

            if (rs.next()) {
                // If the product exists in the warehouse, update the quantity
                String updateQuery = "UPDATE INVENTORY SET Count = ? WHERE SKU_ID = ? AND WarehouseName = ?";
                PreparedStatement updateStmt = conn.prepareStatement(updateQuery);
                updateStmt.setInt(1, newQuantity);
                updateStmt.setInt(2, sku);
                updateStmt.setString(3, warehouse);
                updateStmt.executeUpdate();
                updateStmt.close();
                System.out.println("Inventory updated successfully.");
            } else {
                // If the product does not exist in the warehouse, insert a new record
                String insertQuery = "INSERT INTO INVENTORY (SKU_ID, WarehouseName, Count) VALUES (?, ?, ?)";
                PreparedStatement insertStmt = conn.prepareStatement(insertQuery);
                insertStmt.setInt(1, sku);
                insertStmt.setString(2, warehouse);
                insertStmt.setInt(3, newQuantity);
                insertStmt.executeUpdate();
                insertStmt.close();
                System.out.println("Inventory record created and updated successfully.");
            }

            checkStmt.close();
        } catch (SQLException e) {
            System.out.println("Database error. Please try again later.");
            System.out.println(e.getMessage());
        }
    }


    public static void deleteProduct(Scanner scan, Connection conn) {
        System.out.println("Enter the SKU of the product you want to delete:");
        int sku = getValidFK(conn, scan, "PRODUCT", "SKU_ID", "Name");

        String deleteQuery = "DELETE FROM PRODUCT WHERE SKU_ID = ?";

        try {
            PreparedStatement stmt = conn.prepareStatement(deleteQuery);
            stmt.setInt(1, sku);
            stmt.executeUpdate();
            stmt.close();
            System.out.println("Product deleted successfully.");
        } catch (SQLException e) {
            System.out.println("Database error. Please try again later.");
            System.out.println(e.getMessage());
        }
    }

    public static void getMostPopularProducts(Scanner scan, Connection conn) {
        System.out.println("Enter the start date (YYYY-MM-DD):");
        String startDate = scan.nextLine();
        System.out.println("Enter the end date (YYYY-MM-DD):");
        String endDate = scan.nextLine();

        String query = "SELECT p.Name, SUM(pt.Quantity) AS TotalSold " +
                "FROM PRODUCT_TRANSACTION pt " +
                "JOIN PRODUCT p ON pt.SKU_ID = p.SKU_ID " +
                "JOIN `TRANSACTION` t ON pt.TransID = t.TransID " +
                "WHERE t.OrderDate BETWEEN ? AND ? " +
                "GROUP BY p.Name " +
                "ORDER BY TotalSold DESC";

        try {
            PreparedStatement stmt = conn.prepareStatement(query);
            stmt.setString(1, startDate);
            stmt.setString(2, endDate);
            ResultSet rs = stmt.executeQuery();

            System.out.println("Most Popular Products:");
            while (rs.next()) {
                if (rs.getInt("TotalSold") > 5) {
                    System.out.println(rs.getString("Name") + " - " + rs.getInt("TotalSold") + " sold");
                }
            }

            rs.close();
            stmt.close();
        } catch (SQLException e) {
            System.out.println("Database error. Please try again later.");
            System.out.println(e.getMessage());
        }
    }

    public static void getLeastPopularProducts(Scanner scan, Connection conn) {
        System.out.println("Enter the start date (YYYY-MM-DD):");
        String startDate = scan.nextLine();
        System.out.println("Enter the end date (YYYY-MM-DD):");
        String endDate = scan.nextLine();

        String query = "SELECT p.Name, SUM(pt.Quantity) AS TotalSold " +
                "FROM PRODUCT_TRANSACTION pt " +
                "JOIN PRODUCT p ON pt.SKU_ID = p.SKU_ID " +
                "JOIN `TRANSACTION` t ON pt.TransID = t.TransID " +
                "WHERE t.OrderDate BETWEEN ? AND ? " +
                "GROUP BY p.Name " +
                "ORDER BY TotalSold ASC";

        try {
            PreparedStatement stmt = conn.prepareStatement(query);
            stmt.setString(1, startDate);
            stmt.setString(2, endDate);
            ResultSet rs = stmt.executeQuery();

            System.out.println("Least Popular Products:");
            while (rs.next()) {
                if (rs.getInt("TotalSold") < 5) {
                    System.out.println(rs.getString("Name") + " - " + rs.getInt("TotalSold") + " sold");
                }
            }

            rs.close();
            stmt.close();
        } catch (SQLException e) {
            System.out.println("Database error. Please try again later.");
            System.out.println(e.getMessage());
        }
    }

    public static void getUsersForPromo(Scanner scan, Connection conn) {
        System.out.println("Enter the number of months without a purchase:");
        int months = scan.nextInt();
        scan.nextLine(); // Consume newline

        String query = "SELECT c.FirstName, c.LastName, c.EmailURL, GROUP_CONCAT(DISTINCT p.Name ORDER BY p.Name SEPARATOR ', ') AS FavoriteProducts " +
                "FROM CUSTOMER c " +
                "JOIN TRANSACTION t ON c.CustomerID = t.CustomerID " +
                "JOIN PRODUCT_TRANSACTION pt ON t.TransID = pt.TransID " +
                "JOIN PRODUCT p ON pt.SKU_ID = p.SKU_ID " +
                "WHERE t.OrderDate < DATE_SUB(CURDATE(), INTERVAL ? MONTH) " +
                "GROUP BY c.CustomerID";

        try {
            PreparedStatement stmt = conn.prepareStatement(query);
            stmt.setInt(1, months);
            ResultSet rs = stmt.executeQuery();

            System.out.println("Users for Promotional Emails:");
            while (rs.next()) {
                System.out.println(rs.getString("FirstName") + " " + rs.getString("LastName") + " - " + rs.getString("EmailURL") + " - Favorite Products: " + rs.getString("FavoriteProducts"));
            }

            rs.close();
            stmt.close();
        } catch (SQLException e) {
            System.out.println("Database error. Please try again later.");
            System.out.println(e.getMessage());
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

            // get valid fk
            int fk = -1;
            boolean validId = false;
            System.out.println("Which " + table.toLowerCase() + " is this connected to?");
            while (!validId) {
                // validate chosen id
                fk = getChoice(scan, min, max);
                // if the number is not in the db, try again
                String checkID = String.format("SELECT %s FROM %s WHERE %s = %d", name, table, pk, fk);
                res = s.executeQuery(checkID);
                validId = res.next();
                if (!validId) {
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

            // get valid warehouse
            System.out.println("Which warehouse would you like to select?");
            String warehouse = scan.nextLine().strip();
            String base = "SELECT * FROM WAREHOUSE WHERE WarehouseName = '";
            String checkQuery = base + warehouse + "';";
            res = s.executeQuery(checkQuery);
            while (!res.next()) {
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
