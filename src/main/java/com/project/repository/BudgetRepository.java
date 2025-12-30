package com.project.repository;

import com.project.model.Budget;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;
import org.springframework.stereotype.Repository;

@Repository
public interface BudgetRepository extends JpaRepository<Budget, Integer> {

    @Query("""
        SELECT COALESCE(b.amount, 0)
        FROM Budget b
        WHERE b.user.id = :userId
    """)
    Double getMonthlyBudget(@Param("userId") Long userId);
}
