//
//  HomeModel.swift
//  BudgetBuddy
//
//  Created by Alisher Zinullayev on 10.01.2024.
//

import Foundation
import UIKit

final class HomeViewModel {
    private let coreDataManager: CoreDataManager
    
    init(coreDataManager: CoreDataManager) {
        self.coreDataManager = coreDataManager
        coreDataManager.getTransactions()
    }
    
    var onTransactionsUpdated: (() -> Void)?
    
    func numberOfTransactions() -> Int {
        return coreDataManager.getTransactionsCount()
    }
    
    func getAllPrices() -> [Double] {
        let transactions = coreDataManager.getTransactions()
        
        var incomeCount: Double = 0
        var expenseCount: Double = 0
        for i in transactions {
            if !i.isIncome {
                expenseCount += i.price
            } else {
                incomeCount += i.price
            }
        }
        return [incomeCount-expenseCount, incomeCount, expenseCount]
    }
    
    func getPriceFor(date: TransactionDate, type: TransactionType) -> [TransactionsCD] {
        let transactions = coreDataManager.getTransactions()
        let now = Date()
        var startDate: Date?
        let calendar = Calendar.current
        
        switch date {
        case .week:
            startDate = calendar.date(byAdding: .weekOfYear, value: -1, to: now)
        case .month:
            startDate = calendar.date(byAdding: .month, value: -1, to: now)
        case .year:
            startDate = calendar.date(byAdding: .year, value: -1, to: now)
        }
        
        let transactionsFilteredByDate = transactions.filter { transaction in
            guard let startDate = startDate else {return false}
            return transaction.date ?? Date() >= startDate && transaction.date ?? Date() <= now
        }
        
        switch type {
        case .expense:
            return transactionsFilteredByDate.filter { !$0.isIncome }
        case .income:
            return transactionsFilteredByDate.filter { $0.isIncome }
        case .total:
            return transactionsFilteredByDate
        }
    }
    
    func transaction(at index: Int) -> TransactionsCD {
        return coreDataManager.getTransaction(at: index)
    }
    
    func removeTransaction(at index: Int) {
        coreDataManager.deleteTransactions(index: index)
        onTransactionsUpdated?()
    }
    
    func createExpense(name: String, price: Double, date: Date, category: String, logo: String, isIncome: Bool) {
        coreDataManager.createTransactions(name: name, price: price, date: date, category: category, logo: logo, isIncome: isIncome)
        onTransactionsUpdated?()
    }
}
