//
//  AllPricesView.swift
//  BudgetBuddy
//
//  Created by Alisher Zinullayev on 07.02.2024.
//

import UIKit

final class AllPricesView: UIView {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private let containerView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = UIColor(hex: "2F7E79") //429690 //2F7E79
        view.layer.cornerRadius = 16
        return view
    }()
    
    private let totalBalanceText: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 0
        label.text = "Total Balance"
        label.textColor = .white
        label.font = UIFont.systemFont(ofSize: 16, weight: .semibold)
        label.textAlignment = .left
        return label
    }()
    
    private let upSymbol: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFit
        imageView.clipsToBounds = true
        imageView.image = UIImage(systemName: "arrow.up.circle")
        imageView.tintColor = .white
        return imageView
    }()
    
    private let downSymbol: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFit
        imageView.clipsToBounds = true
        imageView.image = UIImage(systemName: "arrow.down.circle")
        imageView.tintColor = .white
        return imageView
    }()
    
    private let incomeText: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 0
        label.text = "Income"
        label.textColor = .white
        label.font = UIFont.systemFont(ofSize: 16, weight: .medium)
        label.textAlignment = .left
        return label
    }()
    
    private let expenseText: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 0
        label.text = "Expenses"
        label.textColor = .white
        label.font = UIFont.systemFont(ofSize: 16, weight: .medium)
        label.textAlignment = .left
        return label
    }()
    
    private let incomePrice: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 0
        label.text = "$12000"
        label.textColor = .white
        label.font = UIFont.systemFont(ofSize: 20, weight: .semibold)
        label.textAlignment = .left
        return label
    }()
    
    private let expensePrice: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 0
        label.text = "$4000"
        label.textColor = .white
        label.font = UIFont.systemFont(ofSize: 20, weight: .semibold)
        label.textAlignment = .left
        return label
    }()
    
    private let totalPrice: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 0
        label.text = "$8000"
        label.textColor = .white
        label.font = UIFont.systemFont(ofSize: 30, weight: .bold)
        label.textAlignment = .left
        return label
    }()
    
    private func setupUI() {
        addSubview(containerView)
        containerView.addSubview(totalBalanceText)
        containerView.addSubview(downSymbol)
        containerView.addSubview(upSymbol)
        containerView.addSubview(incomeText)
        containerView.addSubview(expenseText)
        containerView.addSubview(incomePrice)
        containerView.addSubview(expensePrice)
        containerView.addSubview(totalPrice)
        
        let containterViewConstraints = [
            containerView.leadingAnchor.constraint(equalTo: leadingAnchor),
            containerView.trailingAnchor.constraint(equalTo: trailingAnchor),
            containerView.topAnchor.constraint(equalTo: topAnchor),
            containerView.bottomAnchor.constraint(equalTo: bottomAnchor),
        ]
        
        let totalBalanceTextConstraints = [
            totalBalanceText.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 20),
            totalBalanceText.topAnchor.constraint(equalTo: containerView.topAnchor, constant: 25)
        ]
        
        let totalPriceConstraints = [
            totalPrice.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 20),
            totalPrice.topAnchor.constraint(equalTo: totalBalanceText.bottomAnchor, constant: 10)
        ]
        
        let upSymbolConstraints = [
            upSymbol.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 20),
            upSymbol.topAnchor.constraint(equalTo: totalPrice.bottomAnchor, constant: 30)
        ]
        
        let incomeTextConstraints = [
            incomeText.leadingAnchor.constraint(equalTo: upSymbol.trailingAnchor, constant: 8),
            incomeText.topAnchor.constraint(equalTo: totalPrice.bottomAnchor, constant: 30)
        ]
        
        let incomePriceConstraints = [
            incomePrice.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 20),
            incomePrice.topAnchor.constraint(equalTo: upSymbol.bottomAnchor, constant: 10)
        ]
        
        let expenseTextConstraints = [
            expenseText.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -20),
            expenseText.topAnchor.constraint(equalTo: totalPrice.bottomAnchor, constant: 30)
        ]
        
        let downSymbolConstraints = [
            downSymbol.trailingAnchor.constraint(equalTo: expenseText.leadingAnchor, constant: -8),
            downSymbol.topAnchor.constraint(equalTo: totalPrice.bottomAnchor, constant: 30)
        ]
        
        let expensePriceConstraints = [
            expensePrice.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -20),
            expensePrice.topAnchor.constraint(equalTo: downSymbol.bottomAnchor, constant: 10)
        ]
        
        NSLayoutConstraint.activate(containterViewConstraints)
        NSLayoutConstraint.activate(totalBalanceTextConstraints)
        NSLayoutConstraint.activate(totalPriceConstraints)
        NSLayoutConstraint.activate(upSymbolConstraints)
        NSLayoutConstraint.activate(incomeTextConstraints)
        NSLayoutConstraint.activate(incomePriceConstraints)
        NSLayoutConstraint.activate(expenseTextConstraints)
        NSLayoutConstraint.activate(downSymbolConstraints)
        NSLayoutConstraint.activate(expensePriceConstraints)
    }
    
    func setValues(income: String, expense: String, allPrices: String) {
        totalPrice.text = allPrices
        incomePrice.text = income
        expensePrice.text = expense
    }
}
