package com.project.repository;

import com.project.model.Expense;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;

import java.time.LocalDate;
import java.util.List;

public interface ExpenseRepository extends JpaRepository<Expense, Long> {

    List<Expense> findByUser_Id(Long userId);

    List<Expense> findByUser_IdAndDateBetween(
            Long userId,
            LocalDate start,
            LocalDate end
    );

    @Query("""
        SELECT COALESCE(SUM(e.amount), 0)
        FROM Expense e
        WHERE e.user.id = :userId
          AND MONTH(e.date) = MONTH(CURRENT_DATE)
          AND YEAR(e.date) = YEAR(CURRENT_DATE)
    """)
    Double getTotalSpentThisMonth(@Param("userId") Long userId);
}
