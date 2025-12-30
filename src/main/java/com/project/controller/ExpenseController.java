package com.project.controller;

import java.time.LocalDate;
import java.time.YearMonth;
import java.util.List;

import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;

import com.project.model.Expense;
import com.project.model.User;
import com.project.repository.BudgetRepository;
import com.project.repository.ExpenseRepository;
import com.project.repository.UserRepository;
import com.project.util.PdfGenerator;

@Controller
public class ExpenseController {

    @Autowired
    private ExpenseRepository expenseRepo;
    
    @Autowired
    private BudgetRepository budgetRepo;
    
    @Autowired
    private UserRepository userRepo;


    // ================= Add Expense Page =================
    @GetMapping("/addExpense")
    public String addExpensePage(HttpSession session) {
        User user = (User) session.getAttribute("user");
        if (user == null) return "redirect:/login";
        return "addExpense";
    }

    // ================= Save Expense =================
    @PostMapping("/saveExpense")
    public String saveExpense(@RequestParam String category,
                              @RequestParam double amount,
                              @RequestParam String description,
                              HttpSession session) {

        User user = (User) session.getAttribute("user");
        if (user == null) return "redirect:/login";

        Expense exp = new Expense();
        exp.setCategory(category);
        exp.setAmount(amount);
        exp.setNote(description);
        exp.setDate(LocalDate.now());
        exp.setUser(user);

        expenseRepo.save(exp);
        return "redirect:/dashboard";
    }

    // ================= Dashboard =================
    @GetMapping("/dashboard")
    public String dashboard(HttpSession session, Model model) {

        User user = (User) session.getAttribute("user");
        if (user == null) return "redirect:/login";

        List<Expense> list = expenseRepo.findByUser_Id(user.getId());

        model.addAttribute("list", list);
        model.addAttribute("total",
                list.stream().mapToDouble(Expense::getAmount).sum());

        return "dashboard";
    }

    // ================= Delete Expense =================
    @GetMapping("/deleteExpense/{id}")
    public String deleteExpense(@PathVariable Long id, HttpSession session) {

        User user = (User) session.getAttribute("user");
        if (user == null) return "redirect:/login";

        expenseRepo.deleteById(id);
        return "redirect:/dashboard";
    }

    // ================= Edit Expense =================
    @GetMapping("/editExpense/{id}")
    public String editExpense(@PathVariable Long id,
                              HttpSession session,
                              Model model) {

        User user = (User) session.getAttribute("user");
        if (user == null) return "redirect:/login";

        Expense e = expenseRepo.findById(id).orElse(null);
        if (e == null) return "redirect:/dashboard";

        model.addAttribute("exp", e);
        return "editExpense";
    }

    // ================= Update Expense =================
    @PostMapping("/updateExpense")
    public String updateExpense(@RequestParam Long id,
                                @RequestParam String category,
                                @RequestParam double amount,
                                @RequestParam String description,
                                HttpSession session) {

        User user = (User) session.getAttribute("user");
        if (user == null) return "redirect:/login";

        Expense e = expenseRepo.findById(id).orElse(null);
        if (e == null) return "redirect:/dashboard";

        e.setCategory(category);
        e.setAmount(amount);
        e.setNote(description);

        expenseRepo.save(e);
        return "redirect:/dashboard";
    }

    // ================= Monthly Report Page =================
    @GetMapping("/monthly-report")
    public String monthlyReport(HttpSession session, Model model) {

        User user = (User) session.getAttribute("user");
        if (user == null) return "redirect:/login";

        LocalDate now = LocalDate.now();
        LocalDate start = now.withDayOfMonth(1);
        LocalDate end = now.withDayOfMonth(now.lengthOfMonth());

        List<Expense> expenses =
                expenseRepo.findByUser_IdAndDateBetween(
                        user.getId(), start, end);

        model.addAttribute("expenses", expenses);
        model.addAttribute("total",
                expenses.stream().mapToDouble(Expense::getAmount).sum());
        model.addAttribute("month", now.getMonth().name());

        return "monthlyReport";
    }

    // ================= ALL EXPENSES PDF =================
    @GetMapping("/expenses/export-pdf")
    public void exportAllPdf(HttpServletResponse response,
                             HttpSession session) throws Exception {

        User user = (User) session.getAttribute("user");
        if (user == null) return;

        List<Expense> list = expenseRepo.findByUser_Id(user.getId());

        response.setContentType("application/pdf");
        response.setHeader("Content-Disposition",
                "attachment; filename=all_expenses.pdf");

        PdfGenerator.generate(list, response);
    }

    // ================= DATE-WISE PDF =================
    @GetMapping("/expenses/export-pdf-date")
    public void exportDateWisePdf(@RequestParam String from,
                                  @RequestParam String to,
                                  HttpSession session,
                                  HttpServletResponse response) throws Exception {

        User user = (User) session.getAttribute("user");
        if (user == null) return;

        LocalDate start = LocalDate.parse(from);
        LocalDate end = LocalDate.parse(to);

        List<Expense> list =
                expenseRepo.findByUser_IdAndDateBetween(
                        user.getId(), start, end);

        response.setContentType("application/pdf");
        response.setHeader("Content-Disposition",
                "attachment; filename=datewise_expenses.pdf");

        PdfGenerator.generate(list, response);
    }

    // ================= MONTH-WISE PDF =================
    @GetMapping("/expenses/export-pdf-month")
    public void exportMonthWisePdf(@RequestParam String month,
                                   HttpSession session,
                                   HttpServletResponse response) throws Exception {

        User user = (User) session.getAttribute("user");
        if (user == null) return;

        YearMonth ym = YearMonth.parse(month);
        LocalDate start = ym.atDay(1);
        LocalDate end = ym.atEndOfMonth();

        List<Expense> list =
                expenseRepo.findByUser_IdAndDateBetween(
                        user.getId(), start, end);

        response.setContentType("application/pdf");
        response.setHeader("Content-Disposition",
                "attachment; filename=monthly_expenses.pdf");

        PdfGenerator.generate(list, response);
    }

    // ================= AI Suggestion =================
    @GetMapping("/aiSuggestion")
    public String aiSuggestion(HttpSession session, Model model) {

        User user = (User) session.getAttribute("user");
        if (user == null) return "redirect:/login";

        // ✅ Total spent (this month / all – currently all)
        List<Expense> list = expenseRepo.findByUser_Id(user.getId());
        double totalSpent = list.stream()
                .mapToDouble(Expense::getAmount)
                .sum();

        // ✅ Monthly budget (from USER table)
        double budget = user.getMonthlyBudget() != null
                ? user.getMonthlyBudget()
                : 0.0;

        String suggestion;
        if (budget > 0 && totalSpent > budget)
            suggestion = "⚠ Your expenses have exceeded your budget. Please try to reduce unnecessary spending.";
        else if (totalSpent > 20000)
            suggestion = "⚠ Your expenses are very high. Consider setting a monthly budget.";
        else if (totalSpent > 10000)
            suggestion = "👍 Your spending is moderate. Try to cut down on non-essential expenses.";
        else
            suggestion = "👌 Great job! Your expenses are well under control.";


        model.addAttribute("totalSpent", totalSpent);
        model.addAttribute("budget", budget);
        model.addAttribute("suggestion", suggestion);

        return "aiSuggestion";
    }


    // ================= Budget =================
    @PostMapping("/setBudget")
    public String setBudget(@RequestParam double budget, HttpSession session) {

        User user = (User) session.getAttribute("user");
        if (user == null) return "redirect:/login";

        user.setMonthlyBudget(budget);
        userRepo.save(user);   // ✅ DB save

        session.setAttribute("user", user); // refresh session
        return "redirect:/dashboard";
    }


    // ================= CheckBudget =================
    @GetMapping("/checkBudget")
    public String checkBudget(HttpSession session, Model model) {

        User user = (User) session.getAttribute("user");
        if (user == null) return "redirect:/login";

        // 🔹 Get budget from USER table (not session)
        double budget = user.getMonthlyBudget() != null
                ? user.getMonthlyBudget()
                : 0.0;

        List<Expense> list = expenseRepo.findByUser_Id(user.getId());
        double totalSpent = list.stream()
                .mapToDouble(Expense::getAmount)
                .sum();

        boolean alert = totalSpent > (budget * 0.8);

        model.addAttribute("budget", budget);
        model.addAttribute("totalSpent", totalSpent);
        model.addAttribute("alert", alert);

        return "budgetAlert";
    }


    // ================= budget Alert =================
    @GetMapping("/budget-alert")
    public String budgetAlert(Model model, HttpSession session) {

        User user = (User) session.getAttribute("loggedUser");

        Double budgetObj = budgetRepo.getMonthlyBudget(user.getId());
        double budget = (budgetObj != null) ? budgetObj : 0.0;

        double totalSpent = expenseRepo.getTotalSpentThisMonth(user.getId());

        boolean alert = totalSpent >= (budget * 0.8);

        model.addAttribute("budget", budget);
        model.addAttribute("totalSpent", totalSpent);
        model.addAttribute("alert", alert);

        return "budgetAlert";
    }


}
