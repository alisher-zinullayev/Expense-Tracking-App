//
//  CoreDataManager.swift
//  BudgetBuddy
//
//  Created by Alisher Zinullayev on 02.02.2024.
//

import UIKit
import CoreData

final class CoreDataManager {
    private var transactions: [TransactionsCD] = []
    private var isSorted: Bool = false
    
    lazy var persistentContainer: NSPersistentContainer = {
        let container = NSPersistentContainer(name: "TransactionsCoreData")
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error as NSError? {
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        })
        return container
    }()
    
    var context: NSManagedObjectContext {
        persistentContainer.viewContext
    }
    
    func save() {
        if context.hasChanges {
            do {
                try context.save()
            } catch {
                let nserror = error as NSError
                fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
            }
        }
    }
    
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
        isSorted = false
        save()
    }
    
    func getTransactions() -> [TransactionsCD] {
        if !isSorted {
            transactions.sort(by: { $0.date! > $1.date! })
            isSorted = true
        }
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
    
    func getTransactionsCount() -> Int {
        return transactions.count
    }
    
    func getTransaction(at index: Int) -> TransactionsCD{
        return transactions[index]
    }
}


