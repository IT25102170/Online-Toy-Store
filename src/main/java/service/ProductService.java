package service;

import model.Product;
import util.FileDatabase;
import java.util.ArrayList;
import java.util.List;

public class ProductService {
    private static final String FILE_NAME = "product.txt";
    public boolean createProduct(Product product) {
        product.setProductId(FileDatabase.getNextId(FILE_NAME));
        String[] record = {
                String.valueOf(product.getProductId()),
                String.valueOf(product.getSellerId()),
                product.getProductName(),
                product.getDescription(),
                String.valueOf(product.getPrice()),
                String.valueOf(product.getQuantity()),
                product.getImageUrl(),
                String.valueOf(product.isActive())
        };
        return FileDatabase.addRecord(FILE_NAME, record);
    }
    public List<Product> getAllProducts() {
        List<Product> products = new ArrayList<>();
        List<String[]> records = FileDatabase.readAll(FILE_NAME);
        for (String[] record : records) {
            Product p = mapToProduct(record);
            if (p != null) {
                products.add(p);
            }
        }
        return products;
    }

    public Product getProductById(int productId) {
        List<String[]> records = FileDatabase.readAll(FILE_NAME);
        for (String[] record : records) {
            if (Integer.parseInt(record[0]) == productId) {
                return mapToProduct(record);
            }
        }
        return null;
    }
    public List<Product> getProductsBySellerId(int sellerId) {
        List<Product> products = new ArrayList<>();
        List<String[]> records = FileDatabase.readAll(FILE_NAME);
        for (String[] record : records) {
            if (Integer.parseInt(record[1]) == sellerId) {
                Product p = mapToProduct(record);
                if (p != null) {
                    products.add(p);
                }
            }
        }
        return products;
    }
    public boolean updateProduct(Product product) {
        String[] record = {
                String.valueOf(product.getProductId()),
                String.valueOf(product.getSellerId()),
                product.getProductName(),
                product.getDescription(),
                String.valueOf(product.getPrice()),
                String.valueOf(product.getQuantity()),
                product.getImageUrl(),
                String.valueOf(product.isActive())
        };
        return FileDatabase.updateRecord(FILE_NAME, String.valueOf(product.getProductId()), record);
    }
    public boolean deleteProduct(int productId) {
        return FileDatabase.deleteRecord(FILE_NAME, String.valueOf(productId));
    }
    private Product mapToProduct(String[] record) {
        if (record.length < 8) {
            System.err.println("Warning: Incomplete product record found: " + String.join("|", record));
            return null;
        }
        try {
            Product product = new Product();
            product.setProductId(Integer.parseInt(record[0]));
            product.setSellerId(Integer.parseInt(record[1]));
            product.setProductName(record[2]);
            product.setDescription(record[3]);
            product.setPrice(Double.parseDouble(record[4]));
            product.setQuantity(Integer.parseInt(record[5]));
            product.setImageUrl(record[6]);
            product.setActive(Boolean.parseBoolean(record[7]));
            return product;
        } catch (Exception e) {
            System.err.println("Error parsing product record: " + String.join("|", record));
            return null;
        }
    }
}