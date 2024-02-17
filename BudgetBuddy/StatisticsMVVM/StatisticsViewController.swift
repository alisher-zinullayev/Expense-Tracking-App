//
//  StatisticsViewController.swift
//  BudgetBuddy
//
//  Created by Alisher Zinullayev on 12.02.2024.
//

import UIKit
import SwiftUI

final class StatisticsViewController: UIViewController {
    
    private let dates = ["Week", "Month", "Year"]
    private var viewModel: StatisticsViewModel
    private var chartView: UIHostingController<TransactionChartView>?
    
    init(viewModel: StatisticsViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private let collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.backgroundColor = .systemBackground
        collectionView.register(DateCollectionViewCell.self, forCellWithReuseIdentifier: DateCollectionViewCell.identifier)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        return collectionView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        
//        print(viewModel.getPriceFor(date: .year, type: .total))
        
        view.backgroundColor = .systemGreen
        collectionView.dataSource = self
        collectionView.delegate = self
    }
    
    func convertToDataPoints(transactions: [TransactionsCD]) -> [TransactionDataPoint] {
        return transactions.map { TransactionDataPoint(date: $0.date!, price: $0.price) }
    }
    
    private func setupUI() {
        view.addSubview(collectionView)
        let dataPoints = convertToDataPoints(transactions: viewModel.getPriceFor(date: .year, type: .total))
        print(dataPoints)
        let chartViewController = UIHostingController(rootView: TransactionChartView(dataPoints: dataPoints))
        self.chartView = chartViewController
        addChild(chartViewController)
        view.addSubview(chartViewController.view)
        chartViewController.didMove(toParent: self)
        chartViewController.view.translatesAutoresizingMaskIntoConstraints = false
        
        let collectionViewConstraints = [
            collectionView.topAnchor.constraint(equalTo: view.layoutMarginsGuide.topAnchor),
            collectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            collectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            collectionView.heightAnchor.constraint(equalToConstant: 50)
        ]

        let chartViewConstraints = [
            chartViewController.view.topAnchor.constraint(equalTo: collectionView.bottomAnchor, constant: 20),
            chartViewController.view.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            chartViewController.view.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            chartViewController.view.heightAnchor.constraint(equalToConstant: 300)
        ]

        NSLayoutConstraint.activate(collectionViewConstraints)
        NSLayoutConstraint.activate(chartViewConstraints)
    }
}

extension StatisticsViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        dates.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: DateCollectionViewCell.identifier, for: indexPath) as? DateCollectionViewCell else {fatalError("Failed to dequeue DateCollectionViewCell")}//else {return UICollectionViewCell()}
        cell.configure(label: dates[indexPath.row])
        return cell
    }
}

extension StatisticsViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 90, height: 30)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        let screenWidth = UIScreen.main.bounds.width
        return (screenWidth-350)/2
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 0, left: 40, bottom: 0, right: 40)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        print(dates[indexPath.row])
    }
}

struct TransactionDataPoint: Equatable {
    var date: Date
    var price: Double
}

struct TransactionChartView: View {
    var dataPoints: [TransactionDataPoint]

    private var sortedDataPoints: [TransactionDataPoint] {
        dataPoints.sorted(by: { $0.date < $1.date })
    }

    private var minY: Double {
        sortedDataPoints.min(by: { $0.price < $1.price })?.price ?? 0
    }

    private var maxY: Double {
        sortedDataPoints.max(by: { $0.price < $1.price })?.price ?? 0
    }

    private var earliestDate: Date {
        sortedDataPoints.first?.date ?? Date()
    }
    private var latestDate: Date {
        sortedDataPoints.last?.date ?? Date()
    }
    private var totalTimeInterval: TimeInterval {
        latestDate.timeIntervalSince(earliestDate)
    }

    var body: some View {
        GeometryReader { geometry in
            Path { path in
                for point in sortedDataPoints {
                    let timeOffset = point.date.timeIntervalSince(earliestDate)
                    let xPosition = geometry.size.width * CGFloat(timeOffset / totalTimeInterval)
                    let yPosition = (1 - CGFloat((point.price - minY) / (maxY - minY))) * geometry.size.height

                    if point == sortedDataPoints.first {
                        path.move(to: CGPoint(x: xPosition, y: yPosition))
                    } else {
                        path.addLine(to: CGPoint(x: xPosition, y: yPosition))
                    }
                }
            }
            .stroke(Color.blue, lineWidth: 2)
        }
        .padding()
    }
}
