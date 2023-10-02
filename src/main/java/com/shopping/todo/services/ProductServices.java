package com.shopping.todo.services;

import java.io.File;
import java.io.FileOutputStream;
import java.io.InputStream;
import java.security.SecureRandom;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;
import org.springframework.web.multipart.MultipartFile;

import com.shopping.todo.entity.Product;
import com.shopping.todo.repository.ProductRepo;

@Component
public class ProductServices {
	
	@Autowired
	private ProductRepo productRepo;

	public String productInputValidation(Product product,MultipartFile file) {
		
		String err = "";
		
		if(product.getName() == null || product.getName().isBlank()) {
			err += "<li>Insert valid product name </li>";
		}
		
		if(product.getUnit() == null || product.getUnit().isBlank() ) {
			err += "<li>Insert valid product unit</li>";
		}
		
		if(product.getPrice() == null || product.getPrice() < 0 || Double.isNaN(product.getPrice()) ) {
			err += "<li>Invalid product price</li>";
		}
		
		
		 // Check if the file is provided
	    if (file == null || file.isEmpty()) {
	        err += "<li>Image file is required</li>";
	    } else {
	        // Check if the file is an image
	        if (!isImage(file)) {
	            err += "<li>Invalid file type, only images are allowed</li>";
	        }

	        // Check if the file size is under 5MB
	        long maxSize = 5 * 1024 * 1024; // 5MB in bytes
	        if (file.getSize() > maxSize) {
	            err += "<li>Image size exceeds the maximum allowed (5MB)</li>";
	        }
	    }
		
		
		return err;
	}
	
	
	// Helper method to check if the file is an image
	private boolean isImage(MultipartFile file) {
	    return file.getContentType() != null && file.getContentType().startsWith("image/");
	}
	
	
	
	public Product addProduct(Product product, MultipartFile file) {
		String uploadImage = uploadImage(file);		
		if(uploadImage == null) {
			return null;
		}
		
		product.setImage(uploadImage);
		return productRepo.save(product);
	}
	
	
	public String uploadImage(MultipartFile file) {
		String fileName = null;
		String path = "src"+ File.separator +"main" + File.separator + "webapp" + File.separator + "resources" + File.separator + "image" + File.separator + "productImage" + File.separator;
		try {

			// Random text generate
			SecureRandom random = new SecureRandom();
			byte[] randomBytes = new byte[10];
			random.nextBytes(randomBytes);

			StringBuilder sb = new StringBuilder();
			for (byte b : randomBytes) {
				sb.append(String.format("%02x", b));
			}
			String randomHexCode = sb.toString();

			fileName = "_" + randomHexCode + file.getOriginalFilename();

			// uploading file
			InputStream is = file.getInputStream();
			byte fileData[] = new byte[is.available()];
			is.read(fileData);

			FileOutputStream fos = new FileOutputStream(path + fileName);
			fos.write(fileData);

			fos.flush();
			fos.close();
			return fileName;

		} catch (Exception e) {
			System.out.println("Error in file uploading : " + e);
			return null;
		}
	}
	
	
	
	
	
	public List<Product> findByProductName(String name){		
		List<Product> findByNameContaining = productRepo.findByNameContaining(name);		
		return findByNameContaining;
	}	
	
	
}
