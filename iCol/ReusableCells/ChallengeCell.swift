//
//  ChallengeCell.swift
//  iCol
//
//  Created by Wendy Kurniawan on 13/10/20.
//

import UIKit

class ChallengeCell: UITableViewCell {

    static let reuseIdentifier = "ChallengeCell"
    
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
                                    trailingAnchor: layoutMarginsGuide.trailingAnchor, trailingAnchorConstant: 0)
        
        containerView.addSubview(titleLabel)
        titleLabel.setConstraint(leadingAnchor: containerView.leadingAnchor, leadingAnchorConstant: 16,
                                 centerYAnchor: containerView.centerYAnchor)

    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}
