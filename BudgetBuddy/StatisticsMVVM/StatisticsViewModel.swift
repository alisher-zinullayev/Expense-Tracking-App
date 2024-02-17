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
    
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    private let coreDataManager: CoreDataManager

    init(coreDataManager: CoreDataManager) {
        self.coreDataManager = coreDataManager
        coreDataManager.getTransactions()
    }
    
    func getPriceFor(date: CustomDate, type: CustomType) -> [TransactionsCD] {
        return coreDataManager.getPriceFor(date: date, type: type)
    }
    
}

enum CustomDate {
    case week, month, year
}

enum CustomType: String {
    case expense, income, total
}
