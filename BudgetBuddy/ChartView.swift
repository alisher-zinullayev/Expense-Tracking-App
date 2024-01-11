//
//  ChartView.swift
//  BudgetBuddy
//
//  Created by Alisher Zinullayev on 11.01.2024.
//

import SwiftUI
import Charts

struct ChartView: View {
    var body: some View {
        VStack {
            Text("Spend frequency")
            Chart {
                ForEach(dummyTransactions, id: \.id) { dataPoint in
                    LineMark(
                        x: .value("Date", dataPoint.date, unit: .hour),
                        y: .value("Price", dataPoint.price)
                    )
                }
            }
            .foregroundColor(Color(UIColor(hex: "7F3DFF")))
        }
    }
    
    var dummyTransactions: [MainTransactionModel] = [
        MainTransactionModel(category: .shopping, logo: .shopping, price: 120.0, description: "Bought clothes", date: Date()),
        MainTransactionModel(category: .education, logo: .education, price: 200.0, description: "Books for class", date: Date().addingTimeInterval(-3 * 3600)), // 3 hours ago
        MainTransactionModel(category: .subscription, logo: .subscription, price: 15.99, description: "Music subscription", date: Date().addingTimeInterval(-26 * 3600)), // 1 day ago
        MainTransactionModel(category: .food, logo: .food, price: 30.0, description: "Groceries", date: Date().addingTimeInterval(-3 * 25 * 3600)), // 3 days ago
        MainTransactionModel(category: .other, logo: .other, price: 45.0, description: "Car wash", date: Date().addingTimeInterval(-4 * 21 * 3600)) // 4 days ago
    ]
    
}

struct ChartView_Previews: PreviewProvider {
    static var previews: some View {
        ChartView()
    }
}
