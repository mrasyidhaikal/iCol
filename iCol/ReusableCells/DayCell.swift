//
//  DayCell.swift
//  iCol
//
//  Created by Windy on 16/10/20.
//

import UIKit

class DayCell: UICollectionViewCell {
    
    static let reuseIdentifier = "DayCell"
    
    let dateLabel = UILabel()
    let monthLabel = UILabel()
    let tickButton = UIButton(type: .system)
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        let containerView = UIView()
        containerView.backgroundColor = #colorLiteral(red: 0.8850145936, green: 0.9960160851, blue: 0.9677742124, alpha: 1)
        containerView.layer.cornerRadius = 8

        addSubview(containerView)
        
        dateLabel.font = .preferredFont(forTextStyle: .body)
        dateLabel.font = .boldSystemFont(ofSize: 17)
        dateLabel.text = "23"
        monthLabel.font = .preferredFont(forTextStyle: .footnote)
        monthLabel.text = "Oct"
        
        tickButton.setImage(UIImage(systemName: "person.circle"), for: .normal)
        containerView.addSubview(tickButton)
        
        let stackView = UIStackView(arrangedSubviews: [dateLabel, monthLabel])
        stackView.axis = .vertical
        stackView.alignment = .center
        containerView.addSubview(stackView)
        
        containerView.setConstraint(topAnchor: topAnchor, topAnchorConstant: 0,
                                    leadingAnchor: leadingAnchor, leadingAnchorConstant: 0,
                                    trailingAnchor: trailingAnchor, trailingAnchorConstant: 0)
        containerView.heightAnchor.constraint(equalToConstant: 64).isActive = true
        
        stackView.setConstraint(centerXAnchor: containerView.centerXAnchor, centerXAnchorConstant: 0,
                                centerYAnchor: containerView.centerYAnchor, centerYAnchorConstant: 0)
        
        tickButton.setConstraint(topAnchor: stackView.bottomAnchor, topAnchorConstant: 32,
                                 bottomAnchor: bottomAnchor, bottomAnchorConstant: 0,
                                 centerXAnchor: containerView.centerXAnchor, centerXAnchorConstant: 0)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
