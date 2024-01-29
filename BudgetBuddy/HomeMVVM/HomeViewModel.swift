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
    
    private(set) var transactions: [MainTransactionModel] = [] {
        didSet {
            self.onTransactionsUpdated?()
        }
    }
    
    var onTransactionsUpdated: (() -> Void)?
    
    func numberOfTransactions() -> Int {
        return transactions.count
    }
    
    func transaction(at indexPath: IndexPath) -> MainTransactionModel {
        return transactions[indexPath.row]
    }
    
    func removeTransaction(at indexPath: IndexPath) {
        DispatchQueue.main.async {
            guard indexPath.row < self.transactions.count else { return }
            self.transactions.remove(at: indexPath.row)
            self.onTransactionsUpdated?()
        }
    }
}
    //}
    
    //    init() {
    //        loadDummyData()
    //    }
    
    // this function was added to check whether my tableview shows data or not
    //    private func loadDummyData() {
    //        let dummyTransactions: [MainTransactionModel] = [
    //            MainTransactionModel(category: .education, logo: .education, price: 200.0, description: "Books for university", date: Date().addingTimeInterval(-5 * 3600)),
    //            MainTransactionModel(category: .shopping, logo: .shopping, price: 120.0, description: "Bought clothes", date: Date()),
    //            MainTransactionModel(category: .education, logo: .education, price: 200.0, description: "Books for class", date: Date().addingTimeInterval(-3 * 3600)), // 3 hours ago
    //            MainTransactionModel(category: .subscription, logo: .subscription, price: 15.99, description: "Music subscription", date: Date().addingTimeInterval(-26 * 3600)), // 1 day ago
    //            MainTransactionModel(category: .food, logo: .food, price: 30.0, description: "Groceries", date: Date().addingTimeInterval(-3 * 25 * 3600)), // 3 days ago
    //            MainTransactionModel(category: .other, logo: .other, price: 45.0, description: "Car wash", date: Date().addingTimeInterval(-4 * 21 * 3600)) // 4 days ago
    //        ]
    //        self.transactions = dummyTransactions
    //    }
    
    //}
    
    //    func loadTransactions(forMonth month: Date){
    //        DispatchQueue.main.async {
    //            self.transactions.sort(by: {$0.date > $1.date})
    //            self.transactions = self.transactions
    //        }
    //    }
    
//    func addTransaction(_ transaction: MainTransactionModel) {
//        DispatchQueue.main.async {
//            self.transactions.append(transaction)
//            self.transactions.sort(by: {$0.date > $1.date})
//            self.onTransactionsUpdated?()
//        }
//    }
//}
