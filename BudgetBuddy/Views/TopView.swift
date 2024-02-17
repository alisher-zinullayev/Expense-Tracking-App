//
//  TopView.swift
//  BudgetBuddy
//
//  Created by Alisher Zinullayev on 08.02.2024.
//

import UIKit

final class TopView: UIView {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
        setupGreeting()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private let containerView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = UIColor(hex: "429690")
        view.roundCorners([.layerMinXMaxYCorner, .layerMaxXMaxYCorner], radius: 20)
        return view
    }()
    
    private let greetings: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 0
        label.text = "Good morning"
        label.textColor = .white
        label.font = UIFont.systemFont(ofSize: 14, weight: .medium)
        label.textAlignment = .left
        return label
    }()
    
    private let wishesText: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 0
        label.text = "Spend your money wisely"
        label.textColor = .white
        label.font = UIFont.systemFont(ofSize: 16, weight: .semibold)
        label.textAlignment = .left
        return label
    }()
    
    private func setupGreeting() {
        let now = Date()
        let calendar = Calendar.current
        let hour = calendar.component(.hour, from: now)
        if hour >= 6 && hour < 12 {
            greetings.text = "Good morning!"
        } else if hour >= 12 && hour < 17 {
            greetings.text = "Good afternoon!"
        } else {
            greetings.text = "Good evening!"
        }
    }
    
    private func setupUI() {
        addSubview(containerView)
        addSubview(greetings)
        addSubview(wishesText)
        
        let containterViewConstraints = [
            containerView.leadingAnchor.constraint(equalTo: leadingAnchor),
            containerView.trailingAnchor.constraint(equalTo: trailingAnchor),
            containerView.topAnchor.constraint(equalTo: topAnchor),
            containerView.bottomAnchor.constraint(equalTo: bottomAnchor),
        ]
        
        let greetingsConstraints = [
            greetings.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20),
            greetings.topAnchor.constraint(equalTo: topAnchor, constant: 100),
        ]
        
        let wishesTextConstraints = [
            wishesText.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20),
            wishesText.topAnchor.constraint(equalTo: greetings.bottomAnchor, constant: 5),
        ]
        
        NSLayoutConstraint.activate(containterViewConstraints)
        NSLayoutConstraint.activate(greetingsConstraints)
        NSLayoutConstraint.activate(wishesTextConstraints)
    }
    
}
