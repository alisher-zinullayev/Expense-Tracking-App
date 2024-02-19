//
//  StatisticsViewModel.swift
//  BudgetBuddy
//
//  Created by Alisher Zinullayev on 12.02.2024.
//

import Foundation
import UIKit
import CoreData

final class StatisticsViewModel {
    private let coreDataManager: CoreDataManager
    private var viewModel: HomeViewModel

    init(coreDataManager: CoreDataManager, viewModel: HomeViewModel) {
        self.coreDataManager = coreDataManager
        self.viewModel = viewModel
        coreDataManager.getTransactions()
    }
    
    func getPriceFor(date: TransactionDate, type: TransactionType) -> [TransactionsCD] {
        return viewModel.getPriceFor(date: date, type: type)
    }
}

enum TransactionDate {
    case week, month, year
}

enum TransactionType: String {
    case expense, income, total
}
