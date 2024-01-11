//
//  MainTransactionModel.swift
//  BudgetBuddy
//
//  Created by Alisher Zinullayev on 10.01.2024.
//

import Foundation

enum TransactionCategoryLogo: String, CaseIterable {
    case shopping = "cart.fill"
    case education = "book.fill"
    case subscription = "doc.plaintext"
    case food = "fork.knife.circle.fill"
    case other = "align.horizontal.left"
}

enum TransactionCategory: String, CaseIterable {
    case shopping = "Shopping"
    case education = "Education"
    case subscription = "Subscription"
    case food = "Food"
    case other = "Other"
}

struct MainTransactionModel {
    let id: UUID = UUID()
    var category: TransactionCategory
    var logo: TransactionCategoryLogo
    var price: Double
    var description: String
    var date: Date
}
