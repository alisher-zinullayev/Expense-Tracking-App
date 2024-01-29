//
//  TransactionAddViewModel.swift
//  BudgetBuddy
//
//  Created by Alisher Zinullayev on 16.01.2024.
//

import Foundation
import Combine

final class TransactionAddViewModel {
    private var transactions: [MainTransactionModel] = [] {
        didSet {
            
        }
    }
    
    var transactionsAdded = PassthroughSubject<MainTransactionModel, Never>()

    func addTransaction(_ transaction: MainTransactionModel) {
        transactions.append(transaction)
        for i in transactions {
            print(i)
        }
    }
}
