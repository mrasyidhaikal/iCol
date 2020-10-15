//
//  HabitDetailViewController.swift
//  iCol
//
//  Created by Windy on 14/10/20.
//

import UIKit

class HabitDetailViewController: UIViewController {
    
    let challengeOverview = ChallengeOverview()

    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = .systemBackground
        setupNavigation()
        setupUI()
    }
    
    private func setupNavigation() {
        navigationItem.title = "Detail Habit"
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Save", style: .done, target: self, action: nil)
    }
    
    private func setupUI() {
        view.addSubview(challengeOverview)
        
        challengeOverview.setConstraint(topAnchor: view.safeAreaLayoutGuide.topAnchor, topAnchorConstant: 32,
                                        leadingAnchor: view.layoutMarginsGuide.leadingAnchor,
                                        trailingAnchor: view.layoutMarginsGuide.trailingAnchor)
    }
    
}

class ChallengeProgressView: UIView {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}

class ChallengeOverview: UIView {
    
    let percentageLabel = UILabel()
    let remainingDay = UILabel()
    let progressBar = ProgressBarView()
    let totalEat = UILabel()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        let titleLabel = UILabel()
        titleLabel.text = "Challenge Overview"
        addSubview(titleLabel)

        percentageLabel.text = "40%"
        percentageLabel.font = .preferredFont(forTextStyle: .title2)

        remainingDay.text = "4 days till challenge ends"
        remainingDay.font = .preferredFont(forTextStyle: .footnote)

        let percentageStackView = UIStackView(arrangedSubviews: [percentageLabel, remainingDay])
        percentageStackView.axis = .horizontal
        percentageStackView.distribution = .equalCentering
        addSubview(percentageStackView)

        progressBar.percentage = 0.5
        addSubview(progressBar)

        let doneSymbol = UIView()
        doneSymbol.backgroundColor = #colorLiteral(red: 0.176264137, green: 0.3899727762, blue: 0.334807694, alpha: 1)
        doneSymbol.translatesAutoresizingMaskIntoConstraints = false
        doneSymbol.layer.cornerRadius = 6

        let doneLabel = UILabel()
        doneLabel.text = "Done"
        doneLabel.font = .preferredFont(forTextStyle: .footnote)

        let doneStackView = UIStackView(arrangedSubviews: [doneSymbol, doneLabel])
        doneStackView.axis = .horizontal
        doneStackView.spacing = 4
        addSubview(doneStackView)

        let textSymbol = UIView()
        textSymbol.backgroundColor = #colorLiteral(red: 0.7685508132, green: 0.768681109, blue: 0.7685337067, alpha: 1)
        textSymbol.translatesAutoresizingMaskIntoConstraints = false
        textSymbol.layer.cornerRadius = 6

        let textLabel = UILabel()
        textLabel.text = "Text"
        textLabel.font = .preferredFont(forTextStyle: .footnote)

        let textStackView = UIStackView(arrangedSubviews: [textSymbol, textLabel])
        textStackView.axis = .horizontal
        textStackView.spacing = 4
        addSubview(textStackView)

        let totalYouEatLabel = UILabel()
        totalYouEatLabel.text = "Total you eat"
        totalYouEatLabel.font = .preferredFont(forTextStyle: .body)
        addSubview(totalYouEatLabel)

        totalEat.text = "34"
        totalEat.font = .preferredFont(forTextStyle: .title1)
        totalEat.font = .boldSystemFont(ofSize: 32)
        addSubview(totalEat)

        titleLabel.setConstraint(topAnchor: topAnchor,
                                 leadingAnchor: leadingAnchor,
                                 trailingAnchor: trailingAnchor)

        percentageStackView.setConstraint(topAnchor: titleLabel.bottomAnchor, topAnchorConstant: 16,
                                          leadingAnchor: leadingAnchor,
                                          trailingAnchor: trailingAnchor)

        progressBar.setConstraint(topAnchor: percentageStackView.bottomAnchor, topAnchorConstant: 8,
                                  leadingAnchor: leadingAnchor,
                                  trailingAnchor: trailingAnchor)

        textStackView.setConstraint(topAnchor: progressBar.bottomAnchor, topAnchorConstant: 40,
                                    trailingAnchor: trailingAnchor)

        doneStackView.setConstraint(topAnchor: progressBar.bottomAnchor, topAnchorConstant: 40,
                                    trailingAnchor: textStackView.leadingAnchor, trailingAnchorConstant: -24)

        doneSymbol.widthAnchor.constraint(equalToConstant: 12).isActive = true
        doneSymbol.heightAnchor.constraint(equalToConstant: 12).isActive = true

        textSymbol.widthAnchor.constraint(equalToConstant: 12).isActive = true
        textSymbol.heightAnchor.constraint(equalToConstant: 12).isActive = true

        totalYouEatLabel.setConstraint(topAnchor: doneStackView.bottomAnchor, topAnchorConstant: 24,
                                       leadingAnchor: leadingAnchor, leadingAnchorConstant: 0,
                                       trailingAnchor: trailingAnchor, trailingAnchorConstant: 0)

        totalEat.setConstraint(topAnchor: totalYouEatLabel.bottomAnchor, topAnchorConstant: 8,
                               leadingAnchor: leadingAnchor, leadingAnchorConstant: 0,
                               trailingAnchor: trailingAnchor, trailingAnchorConstant: 0)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}

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

        progressView.backgroundColor = #colorLiteral(red: 0.176264137, green: 0.3899727762, blue: 0.334807694, alpha: 1)
        progressView.layer.cornerRadius = 8
        progressBackground.backgroundColor = #colorLiteral(red: 0.7685508132, green: 0.768681109, blue: 0.7685337067, alpha: 1)
        progressBackground.layer.cornerRadius = 8

        progressBackground.setConstraint(topAnchor: topAnchor, topAnchorConstant: 0,
                                         leadingAnchor: leadingAnchor, leadingAnchorConstant: 0,
                                         trailingAnchor: trailingAnchor, trailingAnchorConstant: 0)
        progressBackground.heightAnchor.constraint(equalToConstant: 30).isActive = true
        progressBackground.widthAnchor.constraint(equalTo: widthAnchor).isActive = true

        progressView.setConstraint(topAnchor: topAnchor, topAnchorConstant: 0,
                                   leadingAnchor: leadingAnchor, leadingAnchorConstant: 0)
        progressView.heightAnchor.constraint(equalToConstant: 30).isActive = true
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
