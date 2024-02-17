//
//  HomeModel.swift
//  BudgetBuddy
//
//  Created by Alisher Zinullayev on 10.01.2024.
//

import Foundation
import Combine
import UIKit

final class HomeViewModel {
    
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
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
        let income = coreDataManager.getIncomePrice()
        let expenses = coreDataManager.getExpensesPrice()
        return [income-expenses, income, expenses]
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
