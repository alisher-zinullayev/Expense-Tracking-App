//
//  CoreDataManager.swift
//  BudgetBuddy
//
//  Created by Alisher Zinullayev on 02.02.2024.
//

import UIKit
import CoreData

final class CoreDataManager {
    private let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    private var transactions: [TransactionsCD] = []
    
    func createTransactions(name: String, price: Double, date: Date, category: String, logo: String, isIncome: Bool) {
        let newTransaction = TransactionsCD(context: context)
        newTransaction.id = UUID()
        newTransaction.category = category
        newTransaction.date = date
        newTransaction.descriptionString = name
        newTransaction.logo = logo
        newTransaction.price = price
        newTransaction.isIncome = isIncome
        transactions.append(newTransaction)
        transactions.sort(by: { $0.date! > $1.date! })
        save()
    }
    
    func getTransactions() -> [TransactionsCD] {
        do {
            transactions = try context.fetch(TransactionsCD.fetchRequest())
            return transactions
        } catch {
            print("error getting data")
        }
        return []
    }
    
    func updateTransactions(update model: TransactionsCD, with transaction: TransactionsCD) {
        model.id = transaction.id
        model.category = transaction.category
        model.date = transaction.date
        model.descriptionString = transaction.descriptionString
        model.logo = transaction.logo
        model.price = transaction.price
        model.isIncome = transaction.isIncome
        save()
    }
    
    func deleteTransactions(index: Int) {
        context.delete(transactions[index])
        getTransactions()
        save()
    }
    
    private func save() {
        do {
            try context.save()
        } catch {
            print(error)
        }
    }
    
    func getTransactionsCount() -> Int {
        return transactions.count
    }
    
    func getTransaction(at index: Int) -> TransactionsCD{
        return transactions[index]
    }
    
    func getExpensesPrice() -> Double {
        var count: Double = 0
        for i in transactions {
            if !i.isIncome {
                count += i.price
            }
        }
        return count
    }
    
    func getIncomePrice() -> Double {
        var count: Double = 0
        for i in transactions {
            if i.isIncome {
                count += i.price
            }
        }
        return count
    }
    
    func getPriceFor(date: CustomDate, type: CustomType) -> [TransactionsCD] {
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
}


