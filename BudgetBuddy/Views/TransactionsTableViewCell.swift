//
//  TransactionsTableViewCell.swift
//  BudgetBuddy
//
//  Created by Alisher Zinullayev on 10.01.2024.
//

import UIKit

final class TransactionsTableViewCell: UITableViewCell {

    static let identifier = String(describing: TransactionsTableViewCell.self)
    
    var model: MainTransactionModel?
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        addSubviews()
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
    }
    
    private let containerView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = UIColor(hex: "FCFCFC")
        view.layer.cornerRadius = 20
        return view
    }()
    
    private let transaction_logo: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFit
        imageView.clipsToBounds = true
        imageView.image = UIImage(systemName: "arrow.up.square.fill")
        imageView.tintColor = .systemOrange
        return imageView
    }()
    
    private let transaction_type: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 0
        label.textColor = UIColor.black
        label.text = "Shopping"
        label.font = UIFont.boldSystemFont(ofSize: 16)
        label.textAlignment = .left
        return label
    }()
    
    private let transaction_description: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 0
        label.textColor = UIColor.lightGray
        label.text = "Buy some grocery"
        label.font = UIFont.boldSystemFont(ofSize: 14)
        label.textAlignment = .left
        return label
    }()
    
    private let transaction_price: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 0
        label.textColor = UIColor.red
        label.text = "- $1200"
        label.font = UIFont.boldSystemFont(ofSize: 16)
        label.textAlignment = .left
        return label
    }()
    
    private let transaction_date: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 0
        label.textColor = UIColor.lightGray
        label.text = "10:00 AM."
        label.font = UIFont.boldSystemFont(ofSize: 14)
        label.textAlignment = .left
        return label
    }()
    
    func configure(with transaction: TransactionsCD, index: Int) {
        if transaction.isIncome {
            transaction_price.text = "+ $\(transaction.price)"
            transaction_price.textColor = .systemGreen
        } else {
            transaction_price.text = "- $\(transaction.price)"
            transaction_price.textColor = .systemRed
        }
        if index % 2 == 0 {
            containerView.backgroundColor = UIColor.myGrayColor
        } else {
            containerView.backgroundColor = UIColor.myGrayColor
        }
        transaction_type.text = transaction.category! //.rawValue
        transaction_description.text = transaction.descriptionString
        transaction_logo.image = UIImage(systemName: transaction.logo ?? "book.fill") // rawValue

        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd.MM.yyyy"
        let dateString = dateFormatter.string(from: transaction.date!)
        transaction_date.text = dateString
    }
    
    private func addSubviews() {
        contentView.addSubview(containerView)
        containerView.addSubview(transaction_logo)
        containerView.addSubview(transaction_type)
        containerView.addSubview(transaction_description)
        containerView.addSubview(transaction_price)
        containerView.addSubview(transaction_date)
    }
    
    private func setupUI() {
        let containerViewConstraints = [
            containerView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 8),
            containerView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -8),
            containerView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            containerView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
            containerView.heightAnchor.constraint(equalToConstant: 90)
        ]
        let transaction_logoConstraints = [
            transaction_logo.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 16),
            transaction_logo.centerYAnchor.constraint(equalTo: containerView.centerYAnchor),
            transaction_logo.heightAnchor.constraint(equalToConstant: 60), //60
            transaction_logo.widthAnchor.constraint(equalToConstant: 60) //60
        ]
        let transaction_typeConstraints = [
            transaction_type.leadingAnchor.constraint(equalTo: transaction_logo.trailingAnchor, constant: 8),
            transaction_type.topAnchor.constraint(equalTo: containerView.topAnchor, constant: 24) //16
        ]
        let transaction_descriptionConstraints = [
            transaction_description.leadingAnchor.constraint(equalTo: transaction_logo.trailingAnchor, constant: 8),
            transaction_description.bottomAnchor.constraint(equalTo: containerView.bottomAnchor, constant: -20)
        ]
        let transaction_priceConstraints = [
            transaction_price.topAnchor.constraint(equalTo: containerView.topAnchor, constant: 24), //16
            transaction_price.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -16)
        ]
        let transaction_dateConstraints = [
            transaction_date.bottomAnchor.constraint(equalTo: containerView.bottomAnchor, constant: -20),
            transaction_date.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -16)
        ]
        
        NSLayoutConstraint.activate(containerViewConstraints)
        NSLayoutConstraint.activate(transaction_logoConstraints)
        NSLayoutConstraint.activate(transaction_typeConstraints)
        NSLayoutConstraint.activate(transaction_descriptionConstraints)
        NSLayoutConstraint.activate(transaction_priceConstraints)
        NSLayoutConstraint.activate(transaction_dateConstraints)
    }
}

fileprivate extension UIColor {
    static let myGrayColor = UIColor(red: 0.941, green: 0.955, blue: 0.97, alpha: 1)
    static let myWhiteColor = UIColor(cgColor: CGColor(red: 1, green: 1, blue: 1, alpha: 1))
    static let myDarkGrayColor = UIColor(red: 0.8, green: 0.815, blue: 0.83, alpha: 1)
}
