//
//  TransactionDetailViewController.swift
//  BudgetBuddy
//
//  Created by Alisher Zinullayev on 10.02.2024.
//

import UIKit

final class TransactionDetailViewController: UIViewController {
    private var item: TransactionsCD
    
    private let bottomView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .white
        view.roundCorners([.layerMaxXMinYCorner, .layerMinXMinYCorner], radius: 20)
        return view
    }()
    
    private let transactionDetails: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 0
        label.text = "Transaction Details"
        label.textColor = .white
        label.font = UIFont.systemFont(ofSize: 18, weight: .semibold)
        label.textAlignment = .left
        return label
    }()
    
    private let ellipsis: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFit
        imageView.clipsToBounds = true
        imageView.image = UIImage(systemName: "ellipsis")
        imageView.tintColor = .white
        return imageView
    }()
    
    private let logo: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFit
        imageView.clipsToBounds = true
        imageView.image = UIImage(systemName: "arrow.up.square.fill")
        imageView.tintColor = .systemOrange
        return imageView
    }()
    
    private let type: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 0
        label.text = "Expense"
        label.textColor = .black
        label.font = UIFont.systemFont(ofSize: 18, weight: .semibold)
        label.textAlignment = .left
        return label
    }()
    
    private let price: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 0
        label.text = "$85.00"
        label.textColor = .black
        label.font = UIFont.systemFont(ofSize: 24, weight: .semibold)
        label.textAlignment = .left
        return label
    }()
    
    private let status: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 0
        label.text = "Expense"
        label.textColor = .systemRed
        label.font = UIFont.systemFont(ofSize: 16, weight: .semibold)
        label.textAlignment = .left
        return label
    }()
    
    private let descriptionString: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 0
        label.text = "Shopping"
        label.textColor = .black
        label.font = UIFont.systemFont(ofSize: 16, weight: .medium)
        label.textAlignment = .left
        return label
    }()
    
    private let dateText: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 0
        label.text = "Feb 28, 2023"
        label.textColor = .black
        label.font = UIFont.systemFont(ofSize: 16, weight: .medium)
        label.textAlignment = .left
        return label
    }()
    
    private let statusText: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 0
        label.text = "Status"
        label.textColor = UIColor(hex: "666666")
        label.font = UIFont.systemFont(ofSize: 16, weight: .medium)
        label.textAlignment = .left
        return label
    }()
    
    private let descriptionStringText: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 0
        label.text = "Description"
        label.textColor = UIColor(hex: "666666")
        label.font = UIFont.systemFont(ofSize: 16, weight: .medium)
        label.textAlignment = .left
        return label
    }()
    
    private let dateTextDescription: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 0
        label.text = "Date"
        label.textColor = UIColor(hex: "666666")
        label.font = UIFont.systemFont(ofSize: 16, weight: .medium)
        label.textAlignment = .left
        return label
    }()
    
    init(item: TransactionsCD) {
        self.item = item
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor(hex: "429690")
        setupUI()
        setValues()
    }
    
    private func setupUI() {
        view.addSubview(transactionDetails)
        view.addSubview(ellipsis)
        view.addSubview(bottomView)
        bottomView.addSubview(logo)
        bottomView.addSubview(type)
        bottomView.addSubview(price)
        bottomView.addSubview(status)
        bottomView.addSubview(descriptionString)
        bottomView.addSubview(dateText)
        bottomView.addSubview(statusText)
        bottomView.addSubview(descriptionStringText)
        bottomView.addSubview(dateTextDescription)
        
        let transactionDetailsConstraints = [
            transactionDetails.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            transactionDetails.topAnchor.constraint(equalTo: view.topAnchor, constant: 160)
        ]
        
        let ellipsisConstraints = [
            ellipsis.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -30),
            ellipsis.topAnchor.constraint(equalTo: view.topAnchor, constant: 160)
        ]
        
        let bottomViewConstraints = [
            bottomView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            bottomView.topAnchor.constraint(equalTo: view.topAnchor, constant: 250),
            bottomView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            bottomView.trailingAnchor.constraint(equalTo: view.trailingAnchor)
        ]
        
        let logoConstraints = [
            logo.centerXAnchor.constraint(equalTo: bottomView.centerXAnchor),
            logo.topAnchor.constraint(equalTo: bottomView.topAnchor, constant: 30),
            logo.heightAnchor.constraint(equalToConstant: 60),
            logo.widthAnchor.constraint(equalToConstant: 60)
        ]
        
        let typeConstraints = [
            type.centerXAnchor.constraint(equalTo: bottomView.centerXAnchor),
            type.topAnchor.constraint(equalTo: logo.bottomAnchor, constant: 15),
        ]
        
        let priceConstraints = [
            price.centerXAnchor.constraint(equalTo: bottomView.centerXAnchor),
            price.topAnchor.constraint(equalTo: type.bottomAnchor, constant: 15)
        ]
        
        let statusConstraints = [
            status.trailingAnchor.constraint(equalTo: bottomView.trailingAnchor, constant: -30),
            status.topAnchor.constraint(equalTo: price.bottomAnchor, constant: 40)
        ]
        
        let descriptionConstraints = [
            descriptionString.trailingAnchor.constraint(equalTo: bottomView.trailingAnchor, constant: -30),
            descriptionString.topAnchor.constraint(equalTo: status.bottomAnchor, constant: 10)
        ]
        
        let dateConstraints = [
            dateText.trailingAnchor.constraint(equalTo: bottomView.trailingAnchor, constant: -30),
            dateText.topAnchor.constraint(equalTo: descriptionString.bottomAnchor, constant: 10)
        ]
        
        let statusTextConstraints = [
            statusText.leadingAnchor.constraint(equalTo: bottomView.leadingAnchor, constant: 30),
            statusText.topAnchor.constraint(equalTo: price.bottomAnchor, constant: 40)
        ]
        
        let descriptionStringTextConstraints = [
            descriptionStringText.leadingAnchor.constraint(equalTo: bottomView.leadingAnchor, constant: 30),
            descriptionStringText.topAnchor.constraint(equalTo: status.bottomAnchor, constant: 10)
        ]
        
        let dateTextDescriptionConstraints = [
            dateTextDescription.leadingAnchor.constraint(equalTo: bottomView.leadingAnchor, constant: 30),
            dateTextDescription.topAnchor.constraint(equalTo: descriptionString.bottomAnchor, constant: 10)
        ]
        
        NSLayoutConstraint.activate(transactionDetailsConstraints)
        NSLayoutConstraint.activate(ellipsisConstraints)
        NSLayoutConstraint.activate(bottomViewConstraints)
        NSLayoutConstraint.activate(logoConstraints)
        NSLayoutConstraint.activate(typeConstraints)
        NSLayoutConstraint.activate(priceConstraints)
        NSLayoutConstraint.activate(statusConstraints)
        NSLayoutConstraint.activate(descriptionConstraints)
        NSLayoutConstraint.activate(dateConstraints)
        NSLayoutConstraint.activate(statusTextConstraints)
        NSLayoutConstraint.activate(descriptionStringTextConstraints)
        NSLayoutConstraint.activate(dateTextDescriptionConstraints)
    }
    
    private func setValues() {
        logo.image = UIImage(systemName: item.logo ?? "arrow.up.circle")
        price.text = "$\(item.price)"
        status.text = item.category
        descriptionString.text = item.descriptionString
        if item.isIncome {
            type.text = "Income"
            status.textColor = .systemGreen
            type.textColor = .systemGreen
        } else {
            type.text = "Expense"
            status.textColor = .systemRed
            type.textColor = .systemRed
        }
        let dateFormatter = DateFormatter()
        dateFormatter.locale = Locale(identifier: "en_US_POSIX")
        dateFormatter.dateFormat = "MMM dd, yyyy"
        let date = item.date ?? Date()
        let formattedDate = dateFormatter.string(from: date)
        dateText.text = formattedDate
    }
}
