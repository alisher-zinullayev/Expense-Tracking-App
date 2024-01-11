//
//  ViewController.swift
//  BudgetBuddy
//
//  Created by Alisher Zinullayev on 09.01.2024.
//

import UIKit
import SwiftUI

protocol TransactionViewProtocol {
    var viewModel: HomeViewModel {get set}
}

final class HomeViewController: UIViewController, TransactionViewProtocol {

    var viewModel: HomeViewModel
    
    init(viewModel: HomeViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setAllUI()
        bindingViewModel()
    }
    
    private var chartView: UIHostingController<ChartView>?
    
    private func setAllUI() {
        mainTableView.delegate = self
        mainTableView.dataSource = self
        setChart()
        setupUI()
        setValues()
        view.backgroundColor = .systemBackground
    }
    
    // gpt
    private func setChart() {
        let chartVC = UIHostingController(rootView: ChartView())
        addChild(chartVC)
        chartVC.view.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(chartVC.view)
        chartVC.didMove(toParent: self)
        self.chartView = chartVC
    }
    
    private func bindingViewModel() {
        viewModel.onTransactionsUpdated = { [weak self] in
            DispatchQueue.main.async {
                self?.mainTableView.reloadData()
            }
        }
    }
    
    private let overallExpenseView: OverallExpenseView = {
        let view = OverallExpenseView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()

    private let incomeInformationView: MoneyInformationView = {
        let view = MoneyInformationView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private let expensesInformationView: MoneyInformationView = {
        let view = MoneyInformationView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private let mainTableView: UITableView = {
        let tableView = UITableView()
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.rowHeight = UITableView.automaticDimension
        tableView.separatorStyle = .none
        tableView.register(TransactionsTableViewCell.self, forCellReuseIdentifier: TransactionsTableViewCell.identifier)
        return tableView
    }()
    
    // This button was added to check whether viewModel.addTransaction robit or not
    private let buttonAdd: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("+ Transaction", for: .normal)
        button.setTitleColor(.gray, for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 18, weight: .bold)
        button.setTitleColor(.gray, for: .normal)
        button.addTarget(self, action: #selector(addTransaction), for: .touchUpInside)
        return button
    }()
    
    @objc func addTransaction() {
        viewModel.addTransaction(MainTransactionModel(category: .education, logo: .education, price: 2000, description: "Beshbarmak", date: Date()))
    }
    
}

extension HomeViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        viewModel.numberOfTransactions()
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: TransactionsTableViewCell.identifier, for: indexPath) as? TransactionsTableViewCell else {
            return UITableViewCell()
        }
        let transaction = viewModel.transaction(at: indexPath)
        cell.configure(with: transaction) // added
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let transaction = viewModel.transaction(at: indexPath)
        print("\(transaction.id):\(transaction.description):\(transaction.price):\(transaction.category.rawValue)")
        tableView.deselectRow(at: indexPath, animated: true)
    }
}

// UI
extension HomeViewController {
    
    private func setupUI() {
        
        view.addSubview(overallExpenseView)
        view.addSubview(incomeInformationView)
        view.addSubview(expensesInformationView)
        view.addSubview(mainTableView)
        view.addSubview(buttonAdd)
        
        let overallExpenseViewConstraints = [
            overallExpenseView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 8),
            overallExpenseView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -8),
            overallExpenseView.topAnchor.constraint(equalTo: view.layoutMarginsGuide.topAnchor, constant: 5)
        ]
        
        let incomeInformationViewConstraints = [
            incomeInformationView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 24),
            incomeInformationView.topAnchor.constraint(equalTo: overallExpenseView.bottomAnchor, constant: 20)
        ]
        
        let expensesInformationViewConstraints = [
            expensesInformationView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -24),
            expensesInformationView.topAnchor.constraint(equalTo: overallExpenseView.bottomAnchor, constant: 20)
        ]
        
        guard let chartView = self.chartView?.view else { return }
        
        let chartConstraints = [
            chartView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            chartView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            chartView.topAnchor.constraint(equalTo: expensesInformationView.bottomAnchor, constant: 20),
            chartView.heightAnchor.constraint(equalToConstant: 200)
        ]

        let mainTableViewConstraints = [
            mainTableView.topAnchor.constraint(equalTo: chartView.bottomAnchor, constant: 20),
//            mainTableView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            mainTableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            mainTableView.trailingAnchor.constraint(equalTo: view.trailingAnchor)
        ]
        
        let buttonConstraints = [
            buttonAdd.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            buttonAdd.topAnchor.constraint(equalTo: mainTableView.bottomAnchor, constant: 20),
            buttonAdd.bottomAnchor.constraint(equalTo: view.bottomAnchor),
        ]
        
        NSLayoutConstraint.activate(overallExpenseViewConstraints)
        NSLayoutConstraint.activate(incomeInformationViewConstraints)
        NSLayoutConstraint.activate(expensesInformationViewConstraints)
        NSLayoutConstraint.activate(chartConstraints)
        NSLayoutConstraint.activate(mainTableViewConstraints)
        NSLayoutConstraint.activate(buttonConstraints)
    }
    
    private func setValues() {
        incomeInformationView.setupValues(name: "Income", price: "$7500")
        expensesInformationView.setupValues(name: "Expense", price: "$1500")
    }
    
}
