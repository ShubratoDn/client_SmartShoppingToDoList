package com.shopping.todo.controller;

import java.util.Date;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MultipartFile;

import com.shopping.todo.entity.User;
import com.shopping.todo.payload.ServerMessage;
import com.shopping.todo.services.UserServices;

import jakarta.servlet.http.HttpSession;

@Controller
public class AuthController {
	
	@Autowired
	private UserServices userServices;
	

	@GetMapping("/login")
	public String loginPage() {
		return "login";
	}

	@GetMapping("/register")
	public String registerPage() {
		return "register";
	}

	@PostMapping("/register")
	public String register(@ModelAttribute User user, @RequestParam(value = "file", required = false) MultipartFile file, Model model) {

		String err = "";
		System.out.println(user.getEmail());

		if (user.getName().isBlank() || user.getName().length() < 3 || user.getName() == null) {
			err += "Invalid user name <br>";
		}

		if (user.getEmail() == null || user.getEmail().isBlank()) {
			err += "Invalid email <br>";
		}

		if (user.getPassword().isBlank() || user.getPassword().length() < 4 || user.getPassword() == null) {
			err += "Minimum 4 character needed for password <br>";
		}

		if(userServices.getUserByEmail(user.getEmail()) != null) {
			err += "Email already exist!<br>";
		}
		
		ServerMessage sm = null;

		if (!err.equals("")) {
			sm = new ServerMessage(err, "error", "alert-danger");
			model.addAttribute("serverMsg", sm);
			return "register";
		}

		
		user.setImage("user.png");
		user.setDateJoined(new Date());
	
		userServices.saveuser(user);
		sm = new ServerMessage("<strong>Congratulations!!</strong>  Register successfull", "success", "alert-success");
		model.addAttribute("serverMsg", sm);
		return "register";
	}
	
	
	
	@PostMapping("/login")
	public String login(@RequestParam("email") String email, @RequestParam("password") String password, Model model, HttpSession session) {
		User user = userServices.getUserByEmail(email);	
		ServerMessage sm = null;
		if(user == null) {
			sm = new ServerMessage("<strong>Error!!</strong> Email not found", "error", "alert-danger");
			model.addAttribute("serverMsg", sm);
			return "/login";
		}
		
		if(!user.getPassword().equals(password)) {
			sm = new ServerMessage("<strong>Error!!</strong> Password not matching", "error", "alert-danger");
			model.addAttribute("serverMsg", sm);
			return "/login";
		}
		
		session.setAttribute("user", user);
		
		return "redirect:/home";
	}

	
	
	@GetMapping("/logout")
	public String logout(HttpSession httpSession) {
		httpSession.invalidate();
		return  "redirect:/login";
	}
	

}
