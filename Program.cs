using Microsoft.VisualBasic;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;
using System.Data.SqlClient;
using System.Diagnostics;
using System.Threading;

namespace DatabaseFirstApp
{
    /// <summary>
    /// Reads the content of each line in the text file.
    //Splits each line into values using the '|' delimiter.
    // Extracts values such as name, location, price, uom, and sellByDate from the line.
    ///  Constructs a SQL INSERT query to insert data into the MSSQL database table[PROG260FA23].[dbo].[HouseProduce]
    ///  Parses and validates the price and sellByDate before insertion.
    //  Executes the INSERT query using a SqlCommand.
    // Deletes records from the database where the sell-by date is earlier than the current date.
    //Executes a DELETE query using a SqlCommand.
    ///Set Initial Price for Green Apples:
    //Sets the initial price for "Green Apples" to $3.15 in the[dbo].[HouseProduce]
    //table.
    //Executes an UPDATE query using a SqlCommand.
    /// </summary>
    internal class Program
    {
        static void Main(string[] args)
        {
            SqlConnectionStringBuilder mySqlConBuilder = new SqlConnectionStringBuilder();
            mySqlConBuilder["server"] = @"(localdb)\MSSQLLocalDB";
            mySqlConBuilder["Trusted_Connection"] = true;
            mySqlConBuilder["Integrated Security"] = "SSPI";
            mySqlConBuilder["Initial Catalog"] = "PROG260FA23";
            string sqConStr = mySqlConBuilder.ToString();

            string fileDirectory = $"{Directory.GetCurrentDirectory()}\\Files";
            // Get all files in the directory
            var filePaths = Directory.GetFiles(fileDirectory);

            // Iterate through files
            foreach (var filePath in filePaths)
            {
                // Read data from a text file
                string[] lines = File.ReadAllLines(filePath);

                // Iterate through lines in the file
                foreach (var line in lines)
                {
                    // Split the line into values based on a delimiter (e.g., comma)
                    string[] values = line.Split('|');

                    // Debugging output
                    Console.WriteLine($"Line content: {line}");
                    Console.WriteLine($"Number of elements in values: {values.Length}");

                    // Ensure there are enough elements before accessing values
                    if (values.Length >= 3)
                    {
                        // Extract values and construct SQL INSERT query
                        string name = values.Length > 0 ? values[0] : string.Empty;
                        string location = values.Length > 1 ? values[1].Trim() : string.Empty;
                        string priceString = values.Length > 2 ? values[2].Trim() : string.Empty; // Assuming the price is a float
                        string uom = values.Length > 3 ? values[3].Trim() : string.Empty;
                        //string sellByDate = values[4].Trim();


                        // Debugging output
                        Console.WriteLine($"Attempting to parse priceString: {priceString}");
                        // Check if price is a valid integer
                        if (float.TryParse(priceString, out float price))
                        {
                            // Convert string to DateTime for Sell_By_Date
                            if (DateTime.TryParse(values[4].Trim(), out DateTime sellByDate))
                            {
                                // Construct the SQL query for inserting data
                                string insertSql = $"INSERT INTO [PROG260FA23].[dbo].[HouseProduce] ([Name], [Location], [Price], [UoM], [Sell_By_Date]) " +
                                                   $"VALUES ('{name}', '{location}', {price}, '{uom}', '{sellByDate:yyyy-MM-dd HH:mm:ss.fffffff}')";
                                // Execute the query
                                using (SqlConnection conn = new SqlConnection(sqConStr))
                                {
                                    conn.Open();
                                    using (var command = new SqlCommand(insertSql, conn))
                                    {
                                        command.ExecuteNonQuery();
                                    }
                                    conn.Close();
                                }
                            }
                            else
                            {
                                Console.WriteLine($"Error converting Sell_By_Date: {values[4].Trim()}. Skipping this record.");
                            }
                        }
                        else
                        {
                            Console.WriteLine($"Error converting Price: {priceString}. Skipping this record.");
                        }

                    }
                    else
                    {
                        Console.WriteLine($"Insufficient elements in values. Skipping this record.");
                    }

                    using (SqlConnection conn = new SqlConnection(sqConStr))
                    {
                        conn.Open();

                        // Update locations with 'F' to 'Z'
                        string updateSql = "UPDATE [PROG260FA23].[dbo].[HouseProduce] SET [Location] = REPLACE([Location], 'F', 'Z') WHERE [Location] LIKE '%F%'";
                        using (var updateCommand = new SqlCommand(updateSql, conn))
                        {
                            updateCommand.ExecuteNonQuery();
                            Console.WriteLine("Locations updated successfully!");
                        }

                        conn.Close();
                    }

                    using (SqlConnection conn = new SqlConnection(sqConStr))
                    {
                        conn.Open();

                        // Delete items past their Sell By Date
                        string deleteSql = "DELETE FROM [PROG260FA23].[dbo].[HouseProduce] WHERE [Sell_By_Date] < GETDATE()";
                        using (var deleteCommand = new SqlCommand(deleteSql, conn))
                        {
                            int rowsAffected = deleteCommand.ExecuteNonQuery();
                            Console.WriteLine($"{rowsAffected} records deleted successfully!");
                        }

                        conn.Close();
                    }

                    using (SqlConnection conn = new SqlConnection(sqConStr))
                    {
                        conn.Open();

                        // Set initial price for Green Apples to $5.00
                        string updateInitialPriceSql = "UPDATE [dbo].[HouseProduce] SET [Price] = 3.15 WHERE [Name] = 'Green Apples'";
                        using (var updateInitialPriceCommand = new SqlCommand(updateInitialPriceSql, conn))
                        {
                            updateInitialPriceCommand.ExecuteNonQuery();
                            Console.WriteLine("Initial prices for Green Apples set to $5.00 successfully!");
                        }

                        conn.Close();
                    }
                    //increase price by one$
                    using (SqlConnection conn = new SqlConnection(sqConStr))
                    {
                        conn.Open();

                        // Increase price by 1 for all items
                        string updatePriceSql = "UPDATE [dbo].[HouseProduce] SET [Price] = [Price] + 1";
                        using (var updatePriceCommand = new SqlCommand(updatePriceSql, conn))
                        {
                            updatePriceCommand.ExecuteNonQuery();
                            Console.WriteLine("Prices increased by 1 successfully!");
                        }

                        // Fetch the modified data from the database
                        string selectDataSql = "SELECT * FROM [dbo].[HouseProduce]";
                        using (var selectDataCommand = new SqlCommand(selectDataSql, conn))
                        {
                            using (var reader = selectDataCommand.ExecuteReader())
                            {
                                // Create a new directory for the output file
                                string outputDirectory = "ModifiedData";
                                if (!Directory.Exists(outputDirectory))
                                {
                                    Directory.CreateDirectory(outputDirectory);
                                }

                                // Create a new file for the modified data
                                string outputFile = Path.Combine(outputDirectory, "modified_data.csv");

                                using (StreamWriter writer = new StreamWriter(outputFile))
                                {
                                    // Write header
                                    writer.WriteLine("Name,Location,Price,UoM,Sell_By_Date");

                                    // Write modified data to the file
                                    while (reader.Read())
                                    {
                                        string ? name = reader["Name"].ToString();
                                        string ? location = reader["Location"].ToString();
                                        string ? price = reader["Price"].ToString();
                                        string ? uom = reader["UoM"].ToString();
                                        string sellByDate = ((DateTime)reader["Sell_By_Date"]).ToString("yyyy-MM-dd");

                                        writer.WriteLine($"{name},{location},{price},{uom},{sellByDate}");
                                    }
                                }

                                Console.WriteLine($"Modified data saved to: {outputFile}");
                            }
                        }


                        conn.Close();
                    }
                }

            }
        }
    }
}
