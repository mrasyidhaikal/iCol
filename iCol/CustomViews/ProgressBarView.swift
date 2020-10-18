//
//  ProgressBarView.swift
//  iCol
//
//  Created by Windy on 16/10/20.
//

import UIKit

class ProgressBarView: UIView {

    private let progressView = UIView()
    private let progressBackground = UIView()

    var percentage = CGFloat() {
        didSet {
            progressView.widthAnchor.constraint(equalTo: progressBackground.widthAnchor, multiplier: percentage).isActive = true
        }
    }

    override init(frame: CGRect) {
        super.init(frame: frame)

        addSubview(progressBackground)
        addSubview(progressView)

        progressView.backgroundColor = Color.background
        progressView.layer.cornerRadius = 8
        progressBackground.backgroundColor = #colorLiteral(red: 0.7685508132, green: 0.768681109, blue: 0.7685337067, alpha: 1)
        progressBackground.layer.cornerRadius = 8

        progressBackground.setConstraint(topAnchor: topAnchor, topAnchorConstant: 0,
                                         bottomAnchor: bottomAnchor,
                                         leadingAnchor: leadingAnchor, leadingAnchorConstant: 0,
                                         trailingAnchor: trailingAnchor, trailingAnchorConstant: 0,
                                         heighAnchorConstant: 30)
        progressBackground.widthAnchor.constraint(equalTo: widthAnchor).isActive = true

        progressView.setConstraint(topAnchor: topAnchor, topAnchorConstant: 0,
                                   bottomAnchor: bottomAnchor,
                                   leadingAnchor: leadingAnchor, leadingAnchorConstant: 0,
                                   heighAnchorConstant: 30)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
