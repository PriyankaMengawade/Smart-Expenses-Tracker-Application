package com.project.controller;

import java.util.List;

import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;

import com.project.model.Expense;
import com.project.model.User;
import com.project.repository.ExpenseRepository;
import com.project.util.PdfGenerator;

@Controller
public class PdfController {

    @Autowired
    private ExpenseRepository expenseRepository;

    @GetMapping("/downloadPDF")
    public void downloadPDF(HttpSession session, HttpServletResponse response) throws Exception {

        User user = (User) session.getAttribute("user");
        if (user == null) return;

        List<Expense> list = null;
		try {
			list = expenseRepository.findByUser_Id(user.getId());
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}

        response.setContentType("application/pdf");
        response.setHeader("Content-Disposition", "attachment; filename=expenses.pdf");

        PdfGenerator.generate(list, response);
    }
}
