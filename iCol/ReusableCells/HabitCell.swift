//
//  HabitCell.swift
//  iCol
//
//  Created by Windy on 13/10/20.
//

import UIKit

class HabitCell: UITableViewCell {
    
    static let reuseIdentifier = "HabitCell"
    
    let containerView = UIView()
    let titleLabel = UILabel()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        containerView.backgroundColor = .systemRed
        containerView.layer.cornerRadius = 8
        containerView.clipsToBounds = false
        addSubview(containerView)

        containerView.setConstraint(topAnchor: topAnchor, topAnchorConstant: 8,
                                    bottomAnchor: bottomAnchor, bottomAnchorConstant: -8,
                                    leadingAnchor: layoutMarginsGuide.leadingAnchor, leadingAnchorConstant: 0,
                                    trailingAnchor: layoutMarginsGuide.trailingAnchor, trailingAnchorConstant: 0,
                                    centerXAnchor: nil, centerXAnchorConstant: 0,
                                    centerYAnchor: nil, centerYAnchorConstant: 0)
        
        containerView.addSubview(titleLabel)
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        titleLabel.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 16).isActive = true
        titleLabel.centerYAnchor.constraint(equalTo: containerView.centerYAnchor).isActive = true
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
