//
//  HabitCell.swift
//  iCol
//
//  Created by Windy on 13/10/20.
//

import UIKit

class HabitCell: UITableViewCell {
    
    static let reuseIdentifier = "HabitCell"
    
    private let titleLabel = UILabel()
    private let descLabel = UILabel()
    private let percentageLabel = UILabel()
    private let progressBar = UIProgressView()
    
    func setupHabitCell(habit: Planning) {
        titleLabel.text = habit.title
        percentageLabel.text = "0%"
        progressBar.progress = 0.0
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier) 
        
        let containerView = UIView()
        containerView.layer.cornerRadius = 16
        containerView.clipsToBounds = false
        containerView.backgroundColor = .systemBackground
        containerView.addShadow(color: .black, opacity: 0.1, radius: 10, offset: CGSize(width: 0, height: 4))
        addSubview(containerView)
        
        titleLabel.font = .preferredFont(forTextStyle: .title2)
        titleLabel.font = .boldSystemFont(ofSize: 22)
        containerView.addSubview(titleLabel)
        
        let descImageLabel = UIImageView()
        descImageLabel.image = UIImage(systemName: "flame")
        descImageLabel.tintColor = .label
        descLabel.text = "9 gorengan eaten"
        descLabel.font = .preferredFont(forTextStyle: .body)
        
        let descLabelStackView = UIStackView(arrangedSubviews: [descImageLabel, descLabel])
        descLabelStackView.axis = .horizontal
        descLabelStackView.spacing = 4
        addSubview(descLabelStackView)
        
//        let timeImageLabel = UIImageView()
//        timeImageLabel.image = UIImage(systemName: "alarm")
//        timeImageLabel.tintColor = .label
//        timeLabel.text = "02:00 PM"
//        timeLabel.font = .preferredFont(forTextStyle: .footnote)
//
//        let timeStackView = UIStackView(arrangedSubviews: [timeImageLabel, timeLabel])
//        timeStackView.axis = .horizontal
//        timeStackView.spacing = 4
        
//        let descStackView = UIStackView(arrangedSubviews: [descLabelStackView, timeStackView])
//        descStackView.axis = .horizontal
//        descStackView.distribution = .equalCentering
//        containerView.addSubview(descStackView)
        
        percentageLabel.font = .preferredFont(forTextStyle: .body)
        containerView.addSubview(percentageLabel)
        
        progressBar.progressTintColor = Color.primary
        containerView.addSubview(progressBar)
        
        containerView.setConstraint(topAnchor: topAnchor, topAnchorConstant: 8,
                                    bottomAnchor: bottomAnchor, bottomAnchorConstant: -8,
                                    leadingAnchor: layoutMarginsGuide.leadingAnchor,
                                    trailingAnchor: layoutMarginsGuide.trailingAnchor)
        
        titleLabel.setConstraint(topAnchor: containerView.topAnchor, topAnchorConstant: 16,
                                 leadingAnchor: containerView.leadingAnchor, leadingAnchorConstant: 24)
        
        descLabelStackView.setConstraint(topAnchor: titleLabel.bottomAnchor, topAnchorConstant: 8,
                                         leadingAnchor: containerView.leadingAnchor, leadingAnchorConstant: 24)
        
//        descStackView.setConstraint(topAnchor: titleLabel.bottomAnchor, topAnchorConstant: 8,
//                                    leadingAnchor: containerView.leadingAnchor, leadingAnchorConstant: 24,
//                                    trailingAnchor: containerView.trailingAnchor, trailingAnchorConstant: -24)
        
        percentageLabel.setConstraint(topAnchor: descLabelStackView.bottomAnchor, topAnchorConstant: 0,
                                      trailingAnchor: containerView.trailingAnchor, trailingAnchorConstant: -24)

        progressBar.setConstraint(topAnchor: percentageLabel.bottomAnchor, topAnchorConstant: 8,
                                  bottomAnchor: containerView.bottomAnchor, bottomAnchorConstant: -16,
                                  leadingAnchor: containerView.leadingAnchor, leadingAnchorConstant: 24,
                                  trailingAnchor: containerView.trailingAnchor, trailingAnchorConstant: -24,
                                  heighAnchorConstant: 6)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
