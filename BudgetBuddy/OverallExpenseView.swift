//
//  OverallExpenseView.swift
//  BudgetBuddy
//
//  Created by Alisher Zinullayev on 11.01.2024.
//

import UIKit

final class OverallExpenseView: UIView {

    private let containerView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .white
        view.layer.cornerRadius = 20
        return view
    }()
    
    private let top_name: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 0
        label.textColor = UIColor.lightGray
        label.text = "Account Balance"
        label.font = UIFont.boldSystemFont(ofSize: 14)
        label.textAlignment = .left
        return label
    }()
    
    private let overall_price: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 0
        label.textColor = UIColor.black
        label.text = "$9500"
        label.font = UIFont.systemFont(ofSize: 40)
        label.font = UIFont.boldSystemFont(ofSize: 40)
        label.textAlignment = .left
        return label
    }()
    
//    private let notification_logo: UIImageView = {
//        let imageView = UIImageView()
//        imageView.translatesAutoresizingMaskIntoConstraints = false
//        imageView.contentMode = .scaleAspectFit
//        imageView.clipsToBounds = true
//        imageView.image = UIImage(systemName: "arrow.up.square.fill")
//        imageView.tintColor = .white
//        return imageView
//    }()
    
//    private let button: CustomUIButton = {
//
//    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupUI() {
        addSubview(containerView)
        containerView.addSubview(top_name)
        containerView.addSubview(overall_price)
        
        let containerViewConstraints = [
            containerView.leadingAnchor.constraint(equalTo: leadingAnchor),
            containerView.trailingAnchor.constraint(equalTo: trailingAnchor),
            containerView.topAnchor.constraint(equalTo: topAnchor),
            containerView.bottomAnchor.constraint(equalTo: bottomAnchor)
        ]
        
        let top_nameConstraints = [
            top_name.centerXAnchor.constraint(equalTo: containerView.centerXAnchor),
            top_name.topAnchor.constraint(equalTo: containerView.topAnchor, constant: 20),
        ]
        
        let overall_priceConstraints = [
            overall_price.topAnchor.constraint(equalTo: top_name.bottomAnchor, constant: 20),
            overall_price.centerXAnchor.constraint(equalTo: containerView.centerXAnchor),
            overall_price.bottomAnchor.constraint(equalTo: containerView.bottomAnchor, constant: -20)
        ]
        
        NSLayoutConstraint.activate(containerViewConstraints)
        NSLayoutConstraint.activate(top_nameConstraints)
        NSLayoutConstraint.activate(overall_priceConstraints)
    }
    
    func setupValues(price: Double) {
        overall_price.text = String(price)
    }
    
}
