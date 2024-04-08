/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package SampleDB;

import Employee_Classes.*;
import java.sql.*;
import java.util.Scanner;

/**
 *
 * @author mta
 */
public class HourlyEmployeeManagement {
    private Connection conn=null;
    private Statement stmt=null;
    private PreparedStatement pStmt=null;
    private ResultSet rs=null;
    private Scanner scanner=null;

    public HourlyEmployeeManagement() throws ClassNotFoundException,SQLException{
     
             Class.forName("com.mysql.cj.jdbc.Driver");
             String url="jdbc:mysql://localhost:3306/Employee_Database";
             String username="MTA";
             String password="mahfouz9402";
             conn=DriverManager.getConnection(url,username,password);
             stmt=conn.createStatement();
             stmt.executeUpdate("CREATE TABLE IF NOT EXISTS Employees("
                     + "SSN INT AUTO_INCREMENT,"
                     + "firstName VARCHAR(30),"
                     + "lastName VARCHAR(30),"
                     + "PRIMARY KEY(SSN)"
                     + ");");
             stmt.executeUpdate("CREATE TABLE IF NOT EXISTS HourlyEmployee("
                     + "SSN INT PRIMARY KEY AUTO_INCREMENT,"
                     + "hours INT,"
                     + "wage DECIMAL(8,2),"
                     + "FOREIGN KEY(SSN) references Employees(SSN)"
                     + ");");
             
             stmt.close();
             conn.close();
        
    }
    
    public void addHourlyEmployee() throws SQLException{
        
        String url="jdbc:mysql://localhost:3306/Employee_Database";
        String username="MTA";
        String password="mahfouz9402";
       
        conn=DriverManager.getConnection(url,username,password);
        pStmt=conn.prepareStatement("Insert into Employees(firstName,lastName) values(?,?)", Statement.RETURN_GENERATED_KEYS);
        
        System.out.println("Enter the Employee's First Name: ");
        scanner=new Scanner(System.in);
        
        String firstName=scanner.nextLine();
        
        System.out.println("Enter the Employee's Last Name: ");
        String lastName=scanner.nextLine();
        System.out.println("Enter the Employee's hours: ");
        int hours=scanner.nextInt();
        System.out.println("Enter the Employee's wage: ");
        double wage=scanner.nextDouble();
        
        HourlyEmployee he=new HourlyEmployee(firstName, lastName, wage, hours);
        
        pStmt.setString(1, he.getFirstName());
        pStmt.setString(2, he.getLastName());
        pStmt.executeUpdate();
        
        int SSN=1;
        rs=pStmt.getGeneratedKeys();
        while (rs.next()) {
           SSN=rs.getInt(1);  
        }
        he.setSSN(SSN);
        
        pStmt=conn.prepareStatement("Insert into HourlyEmployee(SSN,hours,wage) values("+he.getSSN()+",?,?)");

        pStmt.setInt(1, he.getHours());
        pStmt.setDouble(2, he.getWage());
        pStmt.executeUpdate();
        
        pStmt.close();
        conn.close(); 
    
    }
    
    public void displayHourlyEmployee()throws SQLException{
        String url="jdbc:mysql://localhost:3306/Employee_Database";
        String username="MTA";
        String password="mahfouz9402";
       
        conn=DriverManager.getConnection(url,username,password);
        stmt=conn.createStatement();
        
        rs=stmt.executeQuery("select E.SSN,E.firstName,E.lastName,H.hours,H.wage from Employees E join HourlyEmployee H on E.SSN=H.SSN;");
        
        if (rs.isBeforeFirst()) {
               
            int i=0;
            while (rs.next()) {
                if (i==0) {
                     System.out.println("------------------------------------------------------------------------------------------------------------------------------------------------------------------------");
                     System.out.printf("%15s%20s%20s%15s%15s%15s", "SSN","First-Name ","Last-Name","Hours-Worked","Wage","Earnings");
                     System.out.println();
                     System.out.println("------------------------------------------------------------------------------------------------------------------------------------------------------------------------");
                
                }
                int SSN=rs.getInt(1);
                String firstName=rs.getString(2);
                String lastName=rs.getString(3);
                int hours=rs.getInt(4);
                double wage=rs.getDouble(5);
                
                HourlyEmployee he=new HourlyEmployee(firstName, lastName, wage, hours);
                he.setSSN(SSN);
                System.out.println("------------------------------------------------------------------------------------------------------------------------------------------------------------------------");
                System.out.printf("%15s%20s%20s%15s%15s%15s", he.getSSN(),he.getFirstName(),he.getLastName(),he.getHours(),he.getWage(),he.earnings());
                System.out.println();
                System.out.println("------------------------------------------------------------------------------------------------------------------------------------------------------------------------");  
                i++;
            }
        }else{
            System.out.println("No Hourly Employee's in the record!!");
            System.out.println();
        }
        
        rs.close();
        stmt.close();
        conn.close();
    }
    
    
    public void searchHourlyEmployee() throws SQLException{
        
        String url="jdbc:mysql://localhost:3306/Employee_Database";
        String username="MTA";
        String password="mahfouz9402";
        
        int choice=-1;
        scanner=new Scanner(System.in);
        conn=DriverManager.getConnection(url, username, password);
        
                   
           System.out.println("\n\n1. To Search by Name");
           System.out.println("2. To Search by ID"); 
           System.out.println("3. Go Back");
           System.out.println("Enter your Choice: ");
           choice=scanner.nextInt();
            switch (choice) {
                case 1:
                    pStmt=conn.prepareStatement("select E.SSN,E.firstName,E.lastName,H.hours,H.wage "
                            + "from Employees E join HourlyEmployee H on E.SSN=H.SSN "
                            + "where CONCAT(E.firstName,\" \",E.lastName) Like ?;");
                    System.out.println("Enter the Full Name of the Hourly Employee: ");
                    scanner.nextLine();
                    String name=scanner.nextLine();
                    
                    pStmt.setString(1, name+"%");
                    rs=pStmt.executeQuery();
                    if (rs.isBeforeFirst()) {
                        
                     int i=0;
                              while (rs.next()) {
                                     if (i==0) {
                                        System.out.println("------------------------------------------------------------------------------------------------------------------------------------------------------------------------");
                                        System.out.printf("%15s%20s%20s%15s%15s%15s", "SSN","First-Name ","Last-Name","Hours-Worked","Wage","Earnings");
                                        System.out.println();
                                        System.out.println("------------------------------------------------------------------------------------------------------------------------------------------------------------------------");

                                   }
                                        int SSN=rs.getInt(1);
                                        String firstName=rs.getString(2);
                                        String lastName=rs.getString(3);
                                        int hours=rs.getInt(4);
                                        double wage=rs.getDouble(5);

                                        HourlyEmployee he=new HourlyEmployee(firstName, lastName, wage, hours);
                                        he.setSSN(SSN);
                                        System.out.println("------------------------------------------------------------------------------------------------------------------------------------------------------------------------");
                                        System.out.printf("%15s%20s%20s%15s%15s%15s", he.getSSN(),he.getFirstName(),he.getLastName(),he.getHours(),he.getWage(),he.earnings());
                                        System.out.println();
                                        System.out.println("------------------------------------------------------------------------------------------------------------------------------------------------------------------------");  
                                        i++;
                                     }
                     }else{
                        System.out.println("The Hourly Employee you are looking for is not in the record!!");
                        System.out.println();
                    }
                    
                    break;
                
                case 2:
                    pStmt=conn.prepareStatement("select E.SSN,E.firstName,E.lastName,H.hours,H.wage "
                            + "from Employees E join HourlyEmployee H on E.SSN=H.SSN "
                            + "where E.SSN= (?);");
                   
                    System.out.println("Enter the SSN of the Hourly Employee: ");
                    int SSN=scanner.nextInt();
                    pStmt.setInt(1, SSN);
                    rs=pStmt.executeQuery();
                    if (rs.next()) {
                          
                        System.out.println("------------------------------------------------------------------------------------------------------------------------------------------------------------------------");
                        System.out.printf("%15s%20s%20s%15s%15s%15s", "SSN","First-Name ","Last-Name","Hours-Worked","Wage","Earnings");
                        System.out.println();
                        System.out.println("------------------------------------------------------------------------------------------------------------------------------------------------------------------------");

                   
                        int SSN1=rs.getInt(1);
                        String firstName=rs.getString(2);
                        String lastName=rs.getString(3);
                        int hours=rs.getInt(4);
                        double wage=rs.getDouble(5);

                        HourlyEmployee he=new HourlyEmployee(firstName, lastName, wage, hours);
                        he.setSSN(SSN1);
                        System.out.println("------------------------------------------------------------------------------------------------------------------------------------------------------------------------");
                        System.out.printf("%15s%20s%20s%15s%15s%15s", he.getSSN(),he.getFirstName(),he.getLastName(),he.getHours(),he.getWage(),he.earnings());
                        System.out.println();
                        System.out.println("------------------------------------------------------------------------------------------------------------------------------------------------------------------------");  
                                                         
                                     
                     }else{
                        System.out.println("The Hourly Employee's you are looking for is not in the record!!");
                        System.out.println();
                    }
                   
                    break;
                
                case 3:
                    break;
               
                default:
                     System.out.println("Please provide corect choice!!");  
                     
            } 
            
            rs.close();
            pStmt.close();
            conn.close();
    }
    
    public void modifyHourlyEmployee() throws SQLException{
        
        String url="jdbc:mysql://localhost:3306/Employee_Database";
        String username="MTA";
        String password="mahfouz9402";
        scanner=new Scanner(System.in);
        conn=DriverManager.getConnection(url, username, password);
        pStmt=conn.prepareStatement("select E.SSN,E.firstName,E.lastName,H.hours,H.wage "
                            + "from Employees E join HourlyEmployee H on E.SSN=H.SSN "
                            + "where E.SSN= (?);");
        
            System.out.println("\nEnter the SSN of the Hourly Employee: ");
            int SSN=scanner.nextInt();
            pStmt.setInt(1, SSN);
            rs=pStmt.executeQuery();
            
            if (rs.next()) {
                System.out.println("Hourly Employee Found!!"); 
                System.out.println("------------------------------------------------------------------------------------------------------------------------------------------------------------------------");
                System.out.printf("%15s%20s%20s%15s%15s%15s", "SSN","First-Name ","Last-Name","Hours-Worked","Wage","Earnings");
                System.out.println();
                System.out.println("------------------------------------------------------------------------------------------------------------------------------------------------------------------------");

           
                int SSN1=rs.getInt(1);
                String firstName=rs.getString(2);
                String lastName=rs.getString(3);
                int hours=rs.getInt(4);
                double wage=rs.getDouble(5);

                HourlyEmployee he=new HourlyEmployee(firstName, lastName, wage, hours);
                he.setSSN(SSN1);
                System.out.println("------------------------------------------------------------------------------------------------------------------------------------------------------------------------");
                System.out.printf("%15s%20s%20s%15s%15s%15s", he.getSSN(),he.getFirstName(),he.getLastName(),he.getHours(),he.getWage(),he.earnings());
                System.out.println();
                System.out.println("------------------------------------------------------------------------------------------------------------------------------------------------------------------------");  
                        
               pStmt=conn.prepareStatement("UPDATE Employees SET firstName=(?),lastName=(?) where SSN="+SSN+";");

               System.out.println("Enter the Updated Employee's First Name: ");
               scanner=new Scanner(System.in);
               firstName=scanner.nextLine();
               
               System.out.println("Enter the Updated Employee's Last Name: ");
               lastName=scanner.nextLine();

               pStmt.setString(1, firstName);
               pStmt.setString(2, lastName);
               pStmt.executeUpdate();
               
               System.out.println("Enter the  Updated Employee's Hours: ");
               hours=scanner.nextInt();
               System.out.println("Enter the  Updated Employee's Wage: ");
               wage=scanner.nextDouble();
               pStmt=conn.prepareStatement("UPDATE HourlyEmployee SET hours=(?),wage=(?) where SSN="+SSN+";");

               pStmt.setInt(1, hours);
               pStmt.setDouble(2, wage);
               pStmt.executeUpdate();            
                            
            }else{
               System.out.println("The Hourly Employee's you are looking to update is not in the record!!");
               System.out.println();
            }
            
            rs.close();
            pStmt.close();
            conn.close();
    }
    
    public void deleteHourlyEmployee() throws SQLException{
        String url="jdbc:mysql://localhost:3306/Employee_Database";
        String username="MTA";
        String password="mahfouz9402";
        scanner=new Scanner(System.in);
        conn=DriverManager.getConnection(url, username, password);
        pStmt=conn.prepareStatement("select E.SSN,E.firstName,E.lastName,H.hours,H.wage "
                            + "from Employees E join HourlyEmployee H on E.SSN=H.SSN "
                            + "where E.SSN= (?);");
        
            System.out.println("\nEnter the SSN of the Hourly Employee: ");
            int SSN=scanner.nextInt();
            pStmt.setInt(1, SSN);
            rs=pStmt.executeQuery();
        if (rs.next()) {
            System.out.println("Are you sure you want to delete the hourly employee with SSN: "+SSN+"(y/n):");
            char choice=scanner.next().toLowerCase().charAt(0);
            if (choice=='y') {
                stmt=conn.createStatement();
                stmt.executeUpdate("DELETE FROM HourlyEmployee WHERE SSN="+SSN+";");
                stmt.executeUpdate("DELETE FROM Employees WHERE SSN="+SSN+";");
          
                stmt.close();
            }
            rs.close();
            pStmt.close();
            conn.close();
        }else{
            System.out.println("The hourly Employee's you are looking to delete is not in the record!!");
            System.out.println();
        }
    }
}
