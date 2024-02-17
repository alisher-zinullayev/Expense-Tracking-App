//
//  IncomeManagerMVVM.swift
//  BudgetBuddy
//
//  Created by Alisher Zinullayev on 04.02.2024.
//

import UIKit

final class IncomeViewController: UIViewController {
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
        view.backgroundColor = .systemGreen
        setupUI()
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        view.endEditing(true)
    }
    
    private let containerView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .systemGreen
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
        label.text = "Income"
        label.font = UIFont.boldSystemFont(ofSize: 18)
        label.textAlignment = .left
        return label
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
}

extension IncomeViewController {
    @objc func addTransaction() {
        viewModel.createExpense(
            name: description_expense.text!,
            price: Double(price_expense.text!) ?? 0,
            date: datePicker.date,
            category: "Income",
            logo: "dollarsign.circle.fill",
            isIncome: true
        )
        
        price_expense.text = ""
        description_expense.text = ""
    }
    
    private func setupUI() {
        view.addSubview(containerView)
        view.addSubview(containerViewForSV)
        containerView.addSubview(expensesText)
        containerView.addSubview(howMuchText)
        containerViewForSV.addSubview(scrollView)
        scrollView.addSubview(stackView)
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
            stackView.heightAnchor.constraint(equalTo: scrollView.heightAnchor)
        ]
        
        let heightSubviews = [
            description_expense.heightAnchor.constraint(equalToConstant: 50),
            price_expense.heightAnchor.constraint(equalToConstant: 50),
            datePicker.heightAnchor.constraint(equalToConstant: 400)
        ]
        
        let saveButtonConstraints = [
            saveButton.centerXAnchor.constraint(equalTo: stackView.centerXAnchor)
        ]
        
        NSLayoutConstraint.activate(containerViewConstraints)
        NSLayoutConstraint.activate(containerViewForSVConstraints)
        NSLayoutConstraint.activate(expensesTextConstraints)
        NSLayoutConstraint.activate(howMuchTextConstraints)
        NSLayoutConstraint.activate(scrollViewConstraints)
        NSLayoutConstraint.activate(stackViewConstraints)
        NSLayoutConstraint.activate(heightSubviews)
        NSLayoutConstraint.activate(saveButtonConstraints)
    }
}

extension IncomeViewController: UITextFieldDelegate {
    private func keyboardConfiguration() {
        description_expense.keyboardType = .default
        price_expense.keyboardType = .numberPad
    }
}
