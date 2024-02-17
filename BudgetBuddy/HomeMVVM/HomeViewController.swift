//
//  ViewController.swift
//  BudgetBuddy
//
//  Created by Alisher Zinullayev on 09.01.2024.
//

import UIKit
import SwiftUI


final class HomeViewController: UIViewController {
    private var viewModel: HomeViewModel
    var allPrices: [Double] = []
    
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
        updatePrices()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        viewModel.onTransactionsUpdated?()
        updatePrices()
        showView()
    }
    
    private let containerView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private let backView: TopView = {
        let view = TopView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private let allpricesView: AllPricesView = {
        let view = AllPricesView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private let tableViewText: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 0
        label.text = "Transactions History"
        label.textColor = .black
        label.font = UIFont.systemFont(ofSize: 18, weight: .semibold)
        label.textAlignment = .left
        return label
    }()
    
    private let mainTableView: UITableView = {
        let tableView = UITableView()
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.rowHeight = UITableView.automaticDimension
        tableView.separatorStyle = .none
        tableView.register(TransactionsTableViewCell.self, forCellReuseIdentifier: TransactionsTableViewCell.identifier)
        return tableView
    }()
    
    private lazy var pushViewControllerButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        let symbolConfiguration = UIImage.SymbolConfiguration(pointSize: 100)
        let symbolImage = UIImage(systemName: "plus.circle.fill", withConfiguration: symbolConfiguration)
        button.setImage(symbolImage, for: .normal)
        button.tintColor = UIColor.buttonColor
        button.imageView?.contentMode = .scaleToFill
        button.addTarget(self, action: #selector(pushVC), for: .touchUpInside)
        return button
    }()
    
    private lazy var incomePushButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        let symbolConfiguration = UIImage.SymbolConfiguration(pointSize: 100)
        let symbolImage = UIImage(systemName: "arrow.up.circle", withConfiguration: symbolConfiguration)
        button.setImage(symbolImage, for: .normal)
        button.tintColor = UIColor.buttonColor
        button.imageView?.contentMode = .scaleToFill
        button.alpha = 0
        button.addTarget(self, action: #selector(incomePushViewController), for: .touchUpInside)
        return button
    }()
    
    private lazy var expensePushButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        let symbolConfiguration = UIImage.SymbolConfiguration(pointSize: 100)
        let symbolImage = UIImage(systemName: "arrow.down.circle", withConfiguration: symbolConfiguration)
        button.setImage(symbolImage, for: .normal)
        button.tintColor = UIColor.buttonColor
        button.imageView?.contentMode = .scaleToFill
        button.alpha = 0
        button.addTarget(self, action: #selector(expensePushViewController), for: .touchUpInside)
        return button
    }()
}

extension HomeViewController {
    private func bindingViewModel() {
        viewModel.onTransactionsUpdated = { [weak self] in
            DispatchQueue.main.async {
                guard let self = self else {return}
                self.mainTableView.reloadData()
                self.updatePrices()
            }
        }
    }
    
    private func updatePrices() {
        allPrices = viewModel.getAllPrices()
        allpricesView.setValues(income: String(allPrices[1]), expense: String(allPrices[2]), allPrices: String(allPrices[0]))
    }
}

// MARK: TableView functions
extension HomeViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        viewModel.numberOfTransactions()
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: TransactionsTableViewCell.identifier, for: indexPath) as? TransactionsTableViewCell else {
            return UITableViewCell()
        }
        let transaction = viewModel.transaction(at: indexPath.row)
        cell.configure(with: transaction, index: indexPath.row)
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let transaction = viewModel.transaction(at: indexPath.row)
        let vc = TransactionDetailViewController(item: transaction)
        navigationController?.pushViewController(vc, animated: true)
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            tableView.beginUpdates()
            viewModel.removeTransaction(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .fade)
            tableView.endUpdates()
        }
    }
    
    func tableView(_ tableView: UITableView, editingStyleForRowAt indexPath: IndexPath) -> UITableViewCell.EditingStyle {
        return .delete
    }
}

// MARK: UI
extension HomeViewController {
    private func setupUI() {
        view.addSubview(containerView)
        containerView.addSubview(backView)
        containerView.addSubview(allpricesView)
        containerView.addSubview(tableViewText)
        containerView.addSubview(mainTableView)
        view.addSubview(pushViewControllerButton)
        view.addSubview(incomePushButton)
        view.addSubview(expensePushButton)
        
        let containterViewConstraints = [
            containerView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            containerView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            containerView.topAnchor.constraint(equalTo: view.topAnchor),
            containerView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
        ]
        
        let backViewConstraints = [
            backView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            backView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            backView.topAnchor.constraint(equalTo: view.topAnchor),
            backView.heightAnchor.constraint(equalToConstant: 280)
        ]
        
        let allPricesViewConstraints = [
            allpricesView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            allpricesView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            allpricesView.topAnchor.constraint(equalTo: view.topAnchor, constant: 180),
            allpricesView.heightAnchor.constraint(equalToConstant: 200)
        ]
        
        let tableViewTextConstraints = [
            tableViewText.topAnchor.constraint(equalTo: allpricesView.bottomAnchor, constant: 30),
            tableViewText.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            tableViewText.trailingAnchor.constraint(equalTo: view.trailingAnchor)
        ]
        
        let mainTableViewConstraints = [
            mainTableView.topAnchor.constraint(equalTo: tableViewText.bottomAnchor, constant: 10),
            mainTableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            mainTableView.trailingAnchor.constraint(equalTo: view.trailingAnchor)
        ]
        
        let pushViewControllerButtonConstraints = [
            pushViewControllerButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            pushViewControllerButton.topAnchor.constraint(equalTo: mainTableView.bottomAnchor, constant: 20),
            pushViewControllerButton.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -30),
            pushViewControllerButton.heightAnchor.constraint(equalToConstant: 60),
            pushViewControllerButton.widthAnchor.constraint(equalToConstant: 60)
        ]
        
        let incomePushButtonConstraints = [
            incomePushButton.trailingAnchor.constraint(equalTo: pushViewControllerButton.leadingAnchor, constant: -20),
            incomePushButton.bottomAnchor.constraint(equalTo: pushViewControllerButton.topAnchor, constant: -30),
            incomePushButton.heightAnchor.constraint(equalToConstant: 50),
            incomePushButton.widthAnchor.constraint(equalToConstant: 50)
        ]
        let expensePushButtonConstraints = [
            expensePushButton.leadingAnchor.constraint(equalTo: pushViewControllerButton.trailingAnchor, constant: 20),
            expensePushButton.bottomAnchor.constraint(equalTo: pushViewControllerButton.topAnchor, constant: -30),
            expensePushButton.heightAnchor.constraint(equalToConstant: 50),
            expensePushButton.widthAnchor.constraint(equalToConstant: 50)
        ]
        
        NSLayoutConstraint.activate(containterViewConstraints)
        NSLayoutConstraint.activate(backViewConstraints)
        NSLayoutConstraint.activate(allPricesViewConstraints)
        NSLayoutConstraint.activate(tableViewTextConstraints)
        NSLayoutConstraint.activate(mainTableViewConstraints)
        NSLayoutConstraint.activate(pushViewControllerButtonConstraints)
        NSLayoutConstraint.activate(incomePushButtonConstraints)
        NSLayoutConstraint.activate(expensePushButtonConstraints)
    }
    
    private func setAllUI() {
        mainTableView.delegate = self
        mainTableView.dataSource = self
        setupUI()
        view.backgroundColor = .systemBackground
    }
    
    @objc func pushVC() {
        let shouldShow = incomePushButton.alpha == 0
        UIView.animate(withDuration: 0.3) {
            self.incomePushButton.alpha = shouldShow ? 1 : 0
            self.expensePushButton.alpha = shouldShow ? 1 : 0
            self.containerView.alpha = shouldShow ? 0.8 : 1.0
            self.containerView.isUserInteractionEnabled = !shouldShow
        }
    }
    
    @objc func incomePushViewController() {
        let vc = IncomeViewController(viewModel: viewModel)
        navigationController?.pushViewController(vc, animated: true)
    }
    
    @objc func expensePushViewController() {
        let vc = ExpenseViewController(viewModel: viewModel)
        navigationController?.pushViewController(vc, animated: true)
    }
    
    private func showView() {
        incomePushButton.alpha = 0
        expensePushButton.alpha = 0
        containerView.alpha = 1.0
        containerView.isUserInteractionEnabled = true
    }
    
}

fileprivate extension UIColor {
    static let buttonColor = UIColor(hex: "429690")
}
