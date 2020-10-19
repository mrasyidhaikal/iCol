//
//  ChallengeCell.swift
//  iCol
//
//  Created by Wendy Kurniawan on 13/10/20.
//

import UIKit

class ChallengeCell: UICollectionViewCell {

    static let reuseIdentifier = "ChallengeCell"
    
    let containerView = UIView()
    let challengeLabel = UILabel()
    let challengeImageView = UIImageView()
    
    override init(frame: CGRect) {
        super.init(frame: .zero)
        
        // TODO: - Initialize View
        containerView.layer.cornerRadius = 8
        containerView.clipsToBounds = false
        containerView.backgroundColor = .white
        containerView.addShadow(color: .black, opacity: 0.1, radius: 10, offset: CGSize(width: 0, height: 4))
        
        challengeImageView.frame = CGRect(x: 0, y: 0, width: containerView.bounds.width / 2, height: 10)
        challengeImageView.contentMode = .scaleAspectFit
        
        challengeLabel.textAlignment = .center
        challengeLabel.numberOfLines = 0
        challengeLabel.font = .preferredFont(forTextStyle: .title3)
        
        // TODO: - Adding Subview
        addSubview(containerView)
        containerView.addSubview(challengeImageView)
        containerView.addSubview(challengeLabel)
        
        // TODO: - Setting Auto Layout
        containerView.setConstraint(
            topAnchor: topAnchor, topAnchorConstant: 8,
            bottomAnchor: bottomAnchor, bottomAnchorConstant: 0,
            leadingAnchor: layoutMarginsGuide.leadingAnchor, leadingAnchorConstant: 0,
            trailingAnchor: layoutMarginsGuide.trailingAnchor, trailingAnchorConstant: 0
        )

        challengeImageView.setConstraint(
            topAnchor: topAnchor, topAnchorConstant: 32,
            centerXAnchor: containerView.centerXAnchor, centerXAnchorConstant: 0,
            heighAnchorConstant: 80, widthAnchorConstant: 80)

        challengeLabel.setConstraint(
            bottomAnchor: containerView.bottomAnchor, bottomAnchorConstant: -20,
            leadingAnchor: containerView.leadingAnchor, leadingAnchorConstant: 14,
            centerXAnchor: containerView.centerXAnchor
        )
    }
        
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}
