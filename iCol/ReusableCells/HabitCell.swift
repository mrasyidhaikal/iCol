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
    let descImageLabel = UIImageView()
    let descLabel = UILabel()
    let timeImageLabel = UIImageView()
    let timeLabel = UILabel()
    let percentageLabel = UILabel()
    let progressBar = UIProgressView()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier) 
        
        containerView.layer.cornerRadius = 16
        containerView.clipsToBounds = false
        containerView.backgroundColor = .systemBackground
        containerView.addShadow(color: .black, opacity: 0.1, radius: 10, offset: CGSize(width: 0, height: 4))
        addSubview(containerView)
        
        titleLabel.text = "Eat less gorengan"
        titleLabel.font = .preferredFont(forTextStyle: .title2)
        titleLabel.font = .boldSystemFont(ofSize: 22)
        containerView.addSubview(titleLabel)
        
        descImageLabel.image = UIImage(systemName: "flame")
        descImageLabel.tintColor = .label
        descLabel.text = "9 gorengan eaten"
        descLabel.font = .preferredFont(forTextStyle: .footnote)
        
        let descLabelStackView = UIStackView(arrangedSubviews: [descImageLabel, descLabel])
        descLabelStackView.axis = .horizontal
        descLabelStackView.spacing = 4
        
        timeImageLabel.image = UIImage(systemName: "alarm")
        timeImageLabel.tintColor = .label
        timeLabel.text = "02:00 PM"
        timeLabel.font = .preferredFont(forTextStyle: .footnote)
        
        let timeStackView = UIStackView(arrangedSubviews: [timeImageLabel, timeLabel])
        timeStackView.axis = .horizontal
        timeStackView.spacing = 4
        
        let descStackView = UIStackView(arrangedSubviews: [descLabelStackView, timeStackView])
        descStackView.axis = .horizontal
        descStackView.distribution = .equalCentering
        containerView.addSubview(descStackView)
        
        percentageLabel.text = "40%"
        percentageLabel.font = .preferredFont(forTextStyle: .footnote)
        containerView.addSubview(percentageLabel)
        
        progressBar.progress = 0.5
        progressBar.progressTintColor = #colorLiteral(red: 0.4615316987, green: 0.7156453133, blue: 0.7555921674, alpha: 1)
        containerView.addSubview(progressBar)
        
        containerView.setConstraint(topAnchor: topAnchor, topAnchorConstant: 8,
                                    bottomAnchor: bottomAnchor, bottomAnchorConstant: -8,
                                    leadingAnchor: layoutMarginsGuide.leadingAnchor,
                                    trailingAnchor: layoutMarginsGuide.trailingAnchor)
        
        titleLabel.setConstraint(topAnchor: containerView.topAnchor, topAnchorConstant: 8,
                                 leadingAnchor: containerView.leadingAnchor, leadingAnchorConstant: 24)
        
        descStackView.setConstraint(topAnchor: titleLabel.bottomAnchor, topAnchorConstant: 8,
                                    leadingAnchor: containerView.leadingAnchor, leadingAnchorConstant: 24,
                                    trailingAnchor: containerView.trailingAnchor, trailingAnchorConstant: -24)
        
        percentageLabel.setConstraint(topAnchor: descStackView.bottomAnchor, topAnchorConstant: 8,
                                      trailingAnchor: containerView.trailingAnchor, trailingAnchorConstant: -24)
        
        progressBar.setConstraint(topAnchor: percentageLabel.bottomAnchor, topAnchorConstant: 4,
                                  bottomAnchor: containerView.bottomAnchor, bottomAnchorConstant: -16,
                                  leadingAnchor: containerView.leadingAnchor, leadingAnchorConstant: 24,
                                  trailingAnchor: containerView.trailingAnchor, trailingAnchorConstant: -24)
        progressBar.heightAnchor.constraint(equalToConstant: 6).isActive = true
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
