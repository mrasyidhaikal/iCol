//
//  HabitDetailViewController.swift
//  iCol
//
//  Created by Windy on 14/10/20.
//

import UIKit

class HabitDetailViewController: UIViewController {
    
    let challengeOverview = ChallengeOverview()
    let challengeProgressView = ChallengeProgressView()

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
        view.addSubview(challengeProgressView)
        
        challengeOverview.setConstraint(topAnchor: view.safeAreaLayoutGuide.topAnchor, topAnchorConstant: 32,
                                        leadingAnchor: view.layoutMarginsGuide.leadingAnchor,
                                        trailingAnchor: view.layoutMarginsGuide.trailingAnchor)
        challengeProgressView.setConstraint(topAnchor: challengeOverview.bottomAnchor, topAnchorConstant: 56,
                                            leadingAnchor: view.layoutMarginsGuide.leadingAnchor, leadingAnchorConstant: 0,
                                            trailingAnchor: view.layoutMarginsGuide.trailingAnchor, trailingAnchorConstant: 0)
    }
    
}

class ChallengeProgressView: UIView {
    
    let dateLabel = UILabel()
    var totalEatPerDay: Int = 0
    let totalEatPerDayLabel = UILabel()
    
    let collectionView: UICollectionView = {
        let flow = UICollectionViewFlowLayout()
        flow.scrollDirection = .horizontal
        let cv = UICollectionView(frame: .zero, collectionViewLayout: flow)
        return cv
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        let titleLabel = UILabel()
        titleLabel.text = "Update Progress"
        titleLabel.font = .preferredFont(forTextStyle: .body)
        addSubview(titleLabel)
        
        dateLabel.text = "Wednesday, 14 October 2020"
        dateLabel.font = .preferredFont(forTextStyle: .headline)
        addSubview(dateLabel)
        
        addSubview(collectionView)
        
        let howMuchLabel = UILabel()
        howMuchLabel.text = "How much do you eat?"
        addSubview(howMuchLabel)
        
        totalEatPerDayLabel.text = "\(totalEatPerDay)"
        totalEatPerDayLabel.font = .preferredFont(forTextStyle: .title1)
        totalEatPerDayLabel.font = .boldSystemFont(ofSize: 34)
        
        let minButton = UIButton(type: .system)
        minButton.setImage(UIImage(systemName: "minus"), for: .normal)
        minButton.addTarget(self, action: #selector(handleMinus), for: .touchUpInside)
        
        let plusButton = UIButton(type: .system)
        plusButton.setImage(UIImage(systemName: "plus"), for: .normal)
        plusButton.addTarget(self, action: #selector(handlePlus), for: .touchUpInside)
        
        let stackView = UIStackView(arrangedSubviews: [minButton, totalEatPerDayLabel, plusButton])
        stackView.axis = .horizontal
        stackView.spacing = 32
        addSubview(stackView)
        
        titleLabel.setConstraint(topAnchor: topAnchor, topAnchorConstant: 0,
                                 leadingAnchor: leadingAnchor, leadingAnchorConstant: 0,
                                 trailingAnchor: trailingAnchor, trailingAnchorConstant: 0)
        dateLabel.setConstraint(topAnchor: titleLabel.bottomAnchor, topAnchorConstant: 16,
                                leadingAnchor: leadingAnchor, leadingAnchorConstant: 0,
                                trailingAnchor: trailingAnchor, trailingAnchorConstant: 0)
        setupCollectionView()

        howMuchLabel.setConstraint(topAnchor: collectionView.bottomAnchor, topAnchorConstant: 32,
                                   leadingAnchor: leadingAnchor, leadingAnchorConstant: 0)

        stackView.setConstraint(topAnchor: howMuchLabel.bottomAnchor, topAnchorConstant: 32,
                                bottomAnchor: bottomAnchor, bottomAnchorConstant: 0,
                                leadingAnchor: leadingAnchor, leadingAnchorConstant: 0)

    }
    
    @objc private func handleMinus() {
        totalEatPerDay -= 1
        if totalEatPerDay <= 0 {
            totalEatPerDay = 0
        }
        totalEatPerDayLabel.text = "\(totalEatPerDay)"
    }
    
    @objc private func handlePlus() {
        totalEatPerDay += 1
        totalEatPerDayLabel.text = "\(totalEatPerDay)"
    }
    
    private func setupCollectionView() {
        collectionView.backgroundColor = .systemBackground
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.setConstraint(topAnchor: dateLabel.bottomAnchor, topAnchorConstant: 16,
                                     leadingAnchor: leadingAnchor, leadingAnchorConstant: 0,
                                     trailingAnchor: trailingAnchor, trailingAnchorConstant: 0)
        collectionView.heightAnchor.constraint(equalToConstant: 112).isActive = true
        
        collectionView.register(DayCell.self, forCellWithReuseIdentifier: DayCell.reuseIdentifier)
        collectionView.delegate = self
        collectionView.dataSource = self
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}

extension ChallengeProgressView: UICollectionViewDelegateFlowLayout, UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 44.8, height: collectionView.frame.height)
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 7
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: DayCell.reuseIdentifier, for: indexPath) as! DayCell
        
        return cell
    }
    
}

class ChallengeOverview: UIView {
    
    let percentageLabel = UILabel()
    let remainingDay = UILabel()
    let progressBar = ProgressBarView()
    var totalEat = UILabel()
    
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

        progressBar.percentage = 0.2
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

        textStackView.setConstraint(topAnchor: progressBar.bottomAnchor, topAnchorConstant: 16,
                                    trailingAnchor: trailingAnchor)

        doneStackView.setConstraint(topAnchor: progressBar.bottomAnchor, topAnchorConstant: 16,
                                    trailingAnchor: textStackView.leadingAnchor, trailingAnchorConstant: -24)

        doneSymbol.widthAnchor.constraint(equalToConstant: 12).isActive = true
        doneSymbol.heightAnchor.constraint(equalToConstant: 12).isActive = true

        textSymbol.widthAnchor.constraint(equalToConstant: 12).isActive = true
        textSymbol.heightAnchor.constraint(equalToConstant: 12).isActive = true

        totalYouEatLabel.setConstraint(topAnchor: doneStackView.bottomAnchor, topAnchorConstant: 24,
                                       leadingAnchor: leadingAnchor, leadingAnchorConstant: 0,
                                       trailingAnchor: trailingAnchor, trailingAnchorConstant: 0)

        totalEat.setConstraint(topAnchor: totalYouEatLabel.bottomAnchor, topAnchorConstant: 8,
                               bottomAnchor: bottomAnchor,
                               leadingAnchor: leadingAnchor, leadingAnchorConstant: 0,
                               trailingAnchor: trailingAnchor, trailingAnchorConstant: 0)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}

