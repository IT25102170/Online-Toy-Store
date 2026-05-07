package util;

import java.io.*;
import java.util.ArrayList;
import java.util.List;
import java.util.stream.Collectors;

public class FileDatabase {

    private static final String DATA_DIR = getDataDirectory();

    private static String getDataDirectory() {
        // Try to find the 'data' directory in the current working directory first
        File dataDir = new File("data");
        if (dataDir.exists() && dataDir.isDirectory()) {
            return dataDir.getAbsolutePath() + File.separator;
        }
        // Fallback to the original path if not found (mostly for your local development)
        return "D:\\SLIIT\\Year 1\\Semester 2\\OOP\\Project\\OnlineShoppingStore-simple-java-servlet-project-master\\data\\";
    }

    // Read all lines from a file
    public static List<String[]> readAll(String fileName) {
        List<String[]> data = new ArrayList<>();
        File file = new File(DATA_DIR + fileName);
        if (!file.exists()) return data;

        try (BufferedReader reader = new BufferedReader(new FileReader(file))) {
            String line;
            while ((line = reader.readLine()) != null) {
                if (!line.trim().isEmpty()) {
                    // Use -1 to preserve trailing empty strings (important for missing fields)
                    data.add(line.split("\\|", -1));
                }
            }
        } catch (IOException e) {
            e.printStackTrace();
        }
        return data;
    }

    // Write a new record to a file (auto-handles ID if it's the first column)
    public static boolean addRecord(String fileName, String[] record) {
        try (BufferedWriter writer = new BufferedWriter(new FileWriter(DATA_DIR + fileName, true))) {
            writer.write(String.join("|", record));
            writer.newLine();
            return true;
        } catch (IOException e) {
            System.err.println("Failed to write to " + DATA_DIR + fileName + ": " + e.getMessage());
            e.printStackTrace();
            return false;
        }
    }

    // Update a record by ID (assuming ID is the first column)
    public static boolean updateRecord(String fileName, String id, String[] newRecord) {
        List<String[]> allRecords = readAll(fileName);
        boolean updated = false;

        try (BufferedWriter writer = new BufferedWriter(new FileWriter(DATA_DIR + fileName))) {
            for (String[] record : allRecords) {
                if (record[0].trim().equals(id.trim())) {
                    writer.write(String.join("|", newRecord));
                    updated = true;
                } else {
                    writer.write(String.join("|", record));
                }
                writer.newLine();
            }
        } catch (IOException e) {
            System.err.println("Failed to update " + DATA_DIR + fileName + ": " + e.getMessage());
            e.printStackTrace();
            return false;
        }
        return updated;
    }

    // Delete a record by ID
    public static boolean deleteRecord(String fileName, String id) {
        List<String[]> allRecords = readAll(fileName);
        boolean deleted = false;

        try (BufferedWriter writer = new BufferedWriter(new FileWriter(DATA_DIR + fileName))) {
            for (String[] record : allRecords) {
                if (record[0].trim().equals(id.trim())) {
                    deleted = true;
                    continue;
                }
                writer.write(String.join("|", record));
                writer.newLine();
            }
        } catch (IOException e) {
            System.err.println("Failed to delete from " + DATA_DIR + fileName + ": " + e.getMessage());
            e.printStackTrace();
            return false;
        }
        return deleted;
    }

    // Get the next available ID
    public static int getNextId(String fileName) {
        List<String[]> records = readAll(fileName);
        int maxId = 0;
        for (String[] record : records) {
            try {
                int id = Integer.parseInt(record[0]);
                if (id > maxId) maxId = id;
            } catch (NumberFormatException ignored) {}
        }
        return maxId + 1;
    }
}
