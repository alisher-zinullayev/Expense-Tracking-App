//
//  MoneyInformationView.swift
//  BudgetBuddy
//
//  Created by Alisher Zinullayev on 09.01.2024.
//

import UIKit

final class MoneyInformationView: UIView {

    private let containerView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .systemGreen
        view.layer.cornerRadius = 20
        return view
    }()
    
    private let information_name: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 0
        label.textColor = UIColor.black
        label.text = "Income"
        label.textColor = .white
        label.font = UIFont.boldSystemFont(ofSize: 14)
        label.textAlignment = .left
        return label
    }()
    
    private let current_price: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 0
        label.textColor = UIColor.black
        label.text = "$9000"
        label.textColor = .white
        label.font = UIFont.boldSystemFont(ofSize: 22)
        label.textAlignment = .left
        return label
    }()
    
    private let information_logo: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFit
        imageView.clipsToBounds = true
        imageView.image = UIImage(systemName: "arrow.up.square.fill")
        imageView.tintColor = .white
        return imageView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupUI() {
        addSubview(containerView)
        containerView.addSubview(information_logo)
        containerView.addSubview(information_name)
        containerView.addSubview(current_price)
        
        let containerViewConstraints = [
            containerView.leadingAnchor.constraint(equalTo: leadingAnchor),
            containerView.trailingAnchor.constraint(equalTo: trailingAnchor),
            containerView.topAnchor.constraint(equalTo: topAnchor),
            containerView.bottomAnchor.constraint(equalTo: bottomAnchor)
        ]
        
        let information_logoConstraints = [
            information_logo.topAnchor.constraint(equalTo: containerView.topAnchor, constant: 16),
            information_logo.bottomAnchor.constraint(equalTo: containerView.bottomAnchor, constant: -16),
            information_logo.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 16),
            information_logo.heightAnchor.constraint(equalToConstant: 48),
            information_logo.widthAnchor.constraint(equalToConstant: 48)
        ]
        
        let information_nameConstraints = [
            information_name.topAnchor.constraint(equalTo: containerView.topAnchor, constant: 17),
            information_name.leadingAnchor.constraint(equalTo: information_logo.trailingAnchor, constant: 10),
        ]
        
        let current_priceConstraints = [
            current_price.topAnchor.constraint(equalTo: information_name.bottomAnchor, constant: 4),
            current_price.leadingAnchor.constraint(equalTo: information_logo.trailingAnchor, constant: 10),
            current_price.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -16)
        ]
        
        NSLayoutConstraint.activate(containerViewConstraints)
        NSLayoutConstraint.activate(information_logoConstraints)
        NSLayoutConstraint.activate(information_nameConstraints)
        NSLayoutConstraint.activate(current_priceConstraints)
    }
    
    func setupValues(name: String, price: String) {
        
        if name == "Income" {
            containerView.backgroundColor = .systemGreen
            information_logo.image = UIImage(systemName: "arrow.up.square.fill")
            information_name.text = name
        } else {
            containerView.backgroundColor = .systemRed
            information_logo.image = UIImage(systemName: "arrow.down.square.fill")
            information_name.text = "Expenses"
        }
        
        current_price.text = price
    }
}
