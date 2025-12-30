package com.project.util;

import java.util.List;

import javax.servlet.http.HttpServletResponse;

import com.lowagie.text.*;
import com.lowagie.text.pdf.*;

import com.project.model.Expense;

public class PdfGenerator {

    public static void generate(List<Expense> expenses,
                                HttpServletResponse response) throws Exception {

        Document document = new Document(PageSize.A4);
        PdfWriter.getInstance(document, response.getOutputStream());

        document.open();

        // ===== Title =====
        Font titleFont = FontFactory.getFont(FontFactory.HELVETICA_BOLD, 16);
        Paragraph title = new Paragraph("Monthly Expense Report", titleFont);
        title.setAlignment(Element.ALIGN_CENTER);
        title.setSpacingAfter(20);
        document.add(title);

        // ===== Table =====
        PdfPTable table = new PdfPTable(3);
        table.setWidthPercentage(100);
        table.setWidths(new float[]{3f, 3f, 2f});

        Font headFont = FontFactory.getFont(FontFactory.HELVETICA_BOLD);

        PdfPCell c1 = new PdfPCell(new Phrase("Date", headFont));
        PdfPCell c2 = new PdfPCell(new Phrase("Category", headFont));
        PdfPCell c3 = new PdfPCell(new Phrase("Amount", headFont));

        table.addCell(c1);
        table.addCell(c2);
        table.addCell(c3);

        double total = 0;

        for (Expense e : expenses) {
            table.addCell(String.valueOf(e.getDate()));
            table.addCell(e.getCategory());
            table.addCell("₹ " + e.getAmount());
            total += e.getAmount();
        }

        document.add(table);

        // ===== Total =====
        Paragraph totalPara = new Paragraph(
                "\nTotal Expense : ₹ " + total,
                FontFactory.getFont(FontFactory.HELVETICA_BOLD, 12)
        );
        totalPara.setAlignment(Element.ALIGN_RIGHT);
        document.add(totalPara);

        document.close();   // ✅ VERY IMPORTANT
    }
}
