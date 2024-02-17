//
//  TransactionAddViewController.swift
//  BudgetBuddy
//
//  Created by Alisher Zinullayev on 12.01.2024.
//

import UIKit

final class ExpenseViewController: UIViewController {
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
        view.backgroundColor = UIColor(hex: "FD3C4A") //.systemBlue
        mainTableView.delegate = self
        mainTableView.dataSource = self
        setupUI()
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        view.endEditing(true)
    }
    
    private let containerView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = UIColor(hex: "FD3C4A")
        return view
    }()
    
    private let stackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.spacing = 10
        stackView.layoutMargins = UIEdgeInsets(top: 0, left: 20, bottom: 0, right: 20)
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    
    private let containerViewForSV: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .white
        view.layer.cornerRadius = 20
        return view
    }()
    
    private let scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        scrollView.isScrollEnabled = true
        return scrollView
    }()
    
    private let howMuchText: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 0
        label.textColor = UIColor.white
        label.text = "How Much?"
        label.font = UIFont.boldSystemFont(ofSize: 18)
        label.textAlignment = .left
        return label
    }()
    
    private let expensesText:UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 0
        label.textColor = UIColor.white
        label.text = "Expense"
        label.font = UIFont.boldSystemFont(ofSize: 18)
        label.textAlignment = .left
        return label
    }()
    
     private lazy var selectCategoryButton: UIButton = {
        let button = UIButton()
        button.setTitle("Select an option", for: .normal)
        button.setTitleColor(.systemBlue, for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 18)
        button.addTarget(self, action: #selector(chooseCategory), for: .touchUpInside)
        button.titleEdgeInsets = UIEdgeInsets(top: 0, left: 20, bottom: 0, right: 0)
        button.contentHorizontalAlignment = .left
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    private let description_expense: UITextField = {
        let textField = UITextField()
        textField.attributedPlaceholder = NSAttributedString(string: "Description", attributes: [.font: UIFont.systemFont(ofSize: 12)])
        textField.frame.size.height = 50
        textField.borderStyle = .roundedRect
        textField.font = UIFont.systemFont(ofSize: 16)
        textField.layer.cornerRadius = 20
        textField.translatesAutoresizingMaskIntoConstraints = false
        return textField
    }()
    
    private let price_expense: UITextField = {
        let textField = UITextField()
        textField.attributedPlaceholder = NSAttributedString(string: "Price", attributes: [.font: UIFont.systemFont(ofSize: 12)])
        textField.borderStyle = .roundedRect
        textField.font = UIFont.systemFont(ofSize: 16)
        textField.layer.cornerRadius = 20
        textField.translatesAutoresizingMaskIntoConstraints = false
        return textField
    }()
    
    private let datePicker: UIDatePicker = {
        let datePicker = UIDatePicker()
        datePicker.datePickerMode = .date
        datePicker.locale = .current
        datePicker.timeZone = .current
        datePicker.preferredDatePickerStyle = .inline //.wheels
        datePicker.backgroundColor = .systemBackground
        datePicker.maximumDate = Date()
        datePicker.translatesAutoresizingMaskIntoConstraints = false
        return datePicker
    }()
    
    private lazy var saveButton: UIButton = {
        let button = UIButton()
        button.setTitle("Save", for: .normal)
        button.setTitleColor(.systemBlue, for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 18)
        button.addTarget(self, action: #selector(addTransaction), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    private let mainTableView: UITableView = {
        let tableView = UITableView()
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.rowHeight = UITableView.automaticDimension
        tableView.separatorStyle = .none
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        tableView.isHidden = true
        tableView.register(TransactionsTableViewCell.self, forCellReuseIdentifier: TransactionsTableViewCell.identifier)
        return tableView
    }()
}

extension ExpenseViewController {
    @objc func chooseCategory() {
        mainTableView.isHidden = mainTableView.isHidden == false ? true : false
    }
    
    @objc func addTransaction() {
        let categoryString = selectCategoryButton.titleLabel?.text ?? TransactionCategory.other.rawValue
        let category = TransactionCategory(rawValue: categoryString) ?? TransactionCategory.other
        
        viewModel.createExpense(
            name: description_expense.text!,
            price: Double(price_expense.text!) ?? 0,
            date: datePicker.date,
            category: category.rawValue,
            logo: category.logo.rawValue,
            isIncome: false
        )
        
        mainTableView.isHidden = true
        price_expense.text = ""
        description_expense.text = ""
        selectCategoryButton.setTitle("Select an option", for: .normal)
    }
    
    private func setupUI() {
        view.addSubview(containerView)
        view.addSubview(containerViewForSV)
        containerView.addSubview(expensesText)
        containerView.addSubview(howMuchText)
        containerViewForSV.addSubview(scrollView)
        scrollView.addSubview(stackView)
        stackView.addArrangedSubview(selectCategoryButton)
        stackView.addArrangedSubview(mainTableView)
        stackView.addArrangedSubview(description_expense)
        stackView.addArrangedSubview(price_expense)
        stackView.addArrangedSubview(datePicker)
        stackView.addArrangedSubview(saveButton)
        keyboardConfiguration()
        
        let containerViewConstraints = [
            containerView.topAnchor.constraint(equalTo: view.topAnchor, constant: 16),
            containerView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            containerView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            containerView.heightAnchor.constraint(equalToConstant: 250)
        ]
        
        let containerViewForSVConstraints = [
            containerViewForSV.topAnchor.constraint(equalTo: containerView.bottomAnchor, constant: 0),
            containerViewForSV.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 0),
            containerViewForSV.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: 0),
            containerViewForSV.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: 0),
        ]
        
        let expensesTextConstraints = [
            expensesText.topAnchor.constraint(equalTo: view.layoutMarginsGuide.topAnchor, constant: 0),
            expensesText.centerXAnchor.constraint(equalTo: containerView.centerXAnchor)
        ]
        
        let howMuchTextConstraints = [
            howMuchText.bottomAnchor.constraint(equalTo: containerView.bottomAnchor, constant: -50),
            howMuchText.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 16)
        ]
        
        let scrollViewConstraints = [
            scrollView.topAnchor.constraint(equalTo: containerViewForSV.topAnchor),
            scrollView.leadingAnchor.constraint(equalTo: containerViewForSV.leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: containerViewForSV.trailingAnchor),
            scrollView.bottomAnchor.constraint(equalTo: containerViewForSV.bottomAnchor),
        ]
        
        let stackViewConstraints = [
            stackView.topAnchor.constraint(equalTo: scrollView.topAnchor, constant: 15),
            stackView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor),
            stackView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor),
            stackView.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor),
            stackView.widthAnchor.constraint(equalTo: scrollView.widthAnchor),
            stackView.heightAnchor.constraint(equalTo: scrollView.heightAnchor) //.isActive = true
        ]
        
        let heightSubviews = [
            selectCategoryButton.heightAnchor.constraint(equalToConstant: 50),
            description_expense.heightAnchor.constraint(equalToConstant: 50),
            price_expense.heightAnchor.constraint(equalToConstant: 50),
        ]
        
        let saveButtonConstraints = [
            saveButton.centerXAnchor.constraint(equalTo: stackView.centerXAnchor)
        ]
        
        let mainTableViewConstraints = [
            mainTableView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor),
            mainTableView.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor),
            mainTableView.widthAnchor.constraint(equalTo: scrollView.widthAnchor),
            mainTableView.heightAnchor.constraint(equalToConstant: 200)
        ]
        
        NSLayoutConstraint.activate(containerViewConstraints)
        NSLayoutConstraint.activate(containerViewForSVConstraints)
        NSLayoutConstraint.activate(expensesTextConstraints)
        NSLayoutConstraint.activate(howMuchTextConstraints)
        NSLayoutConstraint.activate(scrollViewConstraints)
        NSLayoutConstraint.activate(stackViewConstraints)
        NSLayoutConstraint.activate(heightSubviews)
        NSLayoutConstraint.activate(saveButtonConstraints)
        NSLayoutConstraint.activate(mainTableViewConstraints)
    }
}

extension ExpenseViewController: UITextFieldDelegate {
    private func keyboardConfiguration() {
        description_expense.keyboardType = .default
        price_expense.keyboardType = .numberPad
    }
}

extension ExpenseViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return TransactionCategory.allCases.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//        guard let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as? UITableViewCell else {return UITableViewCell()}
        let cell = UITableViewCell()
        cell.textLabel?.text = TransactionCategory.allCases[indexPath.row].rawValue // TransactionCategoryLogo.allCases[indexPath.row].rawValue
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        mainTableView.isHidden = true
        selectCategoryButton.setTitle(TransactionCategory.allCases[indexPath.row].rawValue, for: .normal)
    }
}
