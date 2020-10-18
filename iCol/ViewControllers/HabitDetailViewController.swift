//
//  HabitDetailViewController.swift
//  iCol
//
//  Created by Windy on 14/10/20.
//

import UIKit
import CoreData

protocol DismissDetailHabit {
    func didSendTotal(isDismiss: Bool)
}

class HabitDetailViewController: UIViewController {
    
    private let challengeOverview = HabitOverview()
    private let totalEatPerDayLabel = UILabel()
    private var totalEatPerDay: Int = 0
    
    var habit: Habit?
    var delegate: DismissDetailHabit?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupNavigation()
        setupUI()
        setupDetail()
    }
    
    private func setupDetail() {
        
        if let id = habit?.id, let habit = habit {
            
            navigationItem.title = habit.title
            
            let totalEat = CoreDataService.shared.getTotalEat(id: id)
            
            challengeOverview.totalEat.text = "\(totalEat)"
            
            let progress = Float(totalEat) / Float(habit.totalValuePerWeek)
            let percentage = progress * 100
            
            if progress >= 1 {
                challengeOverview.progressBar.percentage = 1
                challengeOverview.percentageLabel.text = "100%"
            } else {
                challengeOverview.progressBar.percentage = CGFloat(progress)
                challengeOverview.percentageLabel.text = "\(String(format: "%.0f", percentage))%"
            }
            
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "dd"
            
            let startDate = dateFormatter.string(from: Date())
            let endDate = dateFormatter.string(from: habit.endDate!)
            let remainingDay = Int(endDate)! - Int(startDate)!
            
            if remainingDay == 0 {
                challengeOverview.remainingDay.text = "End today"
            } else {
                challengeOverview.remainingDay.text = "\(remainingDay) days remaining"
            }
        }
        
    }
    
    private func setupNavigation() {
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Save", style: .done, target: self, action: #selector(handleSave))
    }
    
    @objc private func handleSave() {
        let moc = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
        
        let formatter = DateFormatter()
        formatter.dateStyle = .short
        
        let day = SummaryDay(context: moc)
        day.totalEatPerDay = Int32(totalEatPerDay)
        day.currentDate = Date()
        
        guard let id = habit?.id else { return }
        
        let habitToUpdate = CoreDataService.shared.getHabit(id: id)

        do {
            if habitToUpdate.days?.count == 0 {
                print("masih baru")
                habitToUpdate.addToDays(day)
            } else {
                print(habitToUpdate.days?.count as Any)
                
                let days = habitToUpdate.days
                let sortedDays = days?.sorted(by: { ($0 as! SummaryDay).currentDate! > ($1 as! SummaryDay).currentDate! })
                
                if sortedDays?.count == 1 {
                    print("masih satu hari")
                    let dayToUpdate = sortedDays?[0] as! SummaryDay
                    dayToUpdate.totalEatPerDay += Int32(totalEatPerDay)
                    dayToUpdate.currentDate = Date()
                } else if ((sortedDays?[0] as AnyObject).currentDate!) < Date() && Date() > ((sortedDays?[1] as AnyObject).currentDate!) {
                    print("today")
                    let dayToUpdate = sortedDays?[0] as! SummaryDay
                    dayToUpdate.totalEatPerDay = Int32(totalEatPerDay)
                    dayToUpdate.currentDate = Date()
                } else {
                    print("Not today")
                    habitToUpdate.addToDays(day)
                }
            }
            try moc.save()
            
            
        } catch let err {
            print(err.localizedDescription)
        }
        
        dismiss(animated: true) {
            self.delegate?.didSendTotal(isDismiss: true)
        }
    }
    
    private func setupUI() {
        
        view.addSubview(challengeOverview)
        view.backgroundColor = .systemBackground
        
        let updateLabel = UILabel()
        updateLabel.text = "Update Today Progress"
        updateLabel.font = .preferredFont(forTextStyle: .title2)
        updateLabel.font = .boldSystemFont(ofSize: 24)
        view.addSubview(updateLabel)
        
        totalEatPerDayLabel.text = "\(totalEatPerDay)"
        totalEatPerDayLabel.font = .preferredFont(forTextStyle: .largeTitle)
        totalEatPerDayLabel.font = .boldSystemFont(ofSize: 32)
        
        let stepper = UIStepper()
        stepper.minimumValue = 0
        stepper.autorepeat = true
        stepper.addTarget(self, action: #selector(stepperValueChanged(_:)), for: .valueChanged)
        
        let stackView = UIStackView(arrangedSubviews: [totalEatPerDayLabel, stepper])
        stackView.spacing = 32
        stackView.axis = .horizontal
        view.addSubview(stackView)
        
        let divider = UIView()
        divider.backgroundColor = #colorLiteral(red: 0.7685508132, green: 0.768681109, blue: 0.7685337067, alpha: 1)
        view.addSubview(divider)
        
        challengeOverview.setConstraint(topAnchor: view.safeAreaLayoutGuide.topAnchor, topAnchorConstant: 32,
                                        leadingAnchor: view.layoutMarginsGuide.leadingAnchor,
                                        trailingAnchor: view.layoutMarginsGuide.trailingAnchor)
        
        updateLabel.setConstraint(topAnchor: challengeOverview.bottomAnchor, topAnchorConstant: 64,
                                  leadingAnchor: view.layoutMarginsGuide.leadingAnchor, leadingAnchorConstant: 0)
        
        stackView.setConstraint(topAnchor: updateLabel.bottomAnchor, topAnchorConstant: 64,
                                centerXAnchor: view.centerXAnchor)
        
    }
    
    @objc private func stepperValueChanged(_ sender: UIStepper) {
        totalEatPerDay = Int(sender.value)
        totalEatPerDayLabel.text = "\(totalEatPerDay)"
    }
    
}

class HabitOverview: UIView {
    
    let percentageLabel = UILabel()
    let remainingDay = UILabel()
    let progressBar = ProgressBarView()
    var totalEat = UILabel()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        let titleLabel = UILabel()
        titleLabel.text = "Habit Overview"
        titleLabel.font = .preferredFont(forTextStyle: .title2)
        titleLabel.font = .boldSystemFont(ofSize: 24)
        addSubview(titleLabel)
        
        percentageLabel.font = .preferredFont(forTextStyle: .body)
        
        remainingDay.text = "4 days till challenge ends"
        remainingDay.font = .preferredFont(forTextStyle: .body)
        
        let percentageStackView = UIStackView(arrangedSubviews: [percentageLabel, remainingDay])
        percentageStackView.axis = .horizontal
        percentageStackView.distribution = .equalCentering
        addSubview(percentageStackView)
        
        addSubview(progressBar)
        
        let doneSymbol = UIView()
        doneSymbol.backgroundColor = Color.primary
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
        textLabel.text = "Total Progress"
        textLabel.font = .preferredFont(forTextStyle: .footnote)
        
        let textStackView = UIStackView(arrangedSubviews: [textSymbol, textLabel])
        textStackView.axis = .horizontal
        textStackView.spacing = 4
        addSubview(textStackView)
        
        let totalYouEatLabel = UILabel()
        totalYouEatLabel.text = "Total you eat"
        totalYouEatLabel.font = .preferredFont(forTextStyle: .title2)
        totalYouEatLabel.font = .boldSystemFont(ofSize: 24)
        addSubview(totalYouEatLabel)
        
        totalEat.font = .preferredFont(forTextStyle: .largeTitle)
        totalEat.font = .boldSystemFont(ofSize: 32)
        addSubview(totalEat)
        
        titleLabel.setConstraint(
            topAnchor: topAnchor,
            leadingAnchor: leadingAnchor,
            trailingAnchor: trailingAnchor)
        
        percentageStackView.setConstraint(
            topAnchor: titleLabel.bottomAnchor, topAnchorConstant: 16,
            leadingAnchor: leadingAnchor,
            trailingAnchor: trailingAnchor)
        
        progressBar.setConstraint(
            topAnchor: percentageStackView.bottomAnchor, topAnchorConstant: 8,
            leadingAnchor: leadingAnchor,
            trailingAnchor: trailingAnchor)
        
        textStackView.setConstraint(
            topAnchor: progressBar.bottomAnchor, topAnchorConstant: 16,
            trailingAnchor: trailingAnchor)
        
        doneStackView.setConstraint(
            topAnchor: progressBar.bottomAnchor, topAnchorConstant: 16,
            trailingAnchor: textStackView.leadingAnchor, trailingAnchorConstant: -24)
        
        doneSymbol.widthAnchor.constraint(equalToConstant: 12).isActive = true
        doneSymbol.heightAnchor.constraint(equalToConstant: 12).isActive = true
        
        textSymbol.widthAnchor.constraint(equalToConstant: 12).isActive = true
        textSymbol.heightAnchor.constraint(equalToConstant: 12).isActive = true
        
        totalYouEatLabel.setConstraint(
            topAnchor: doneStackView.bottomAnchor, topAnchorConstant: 24,
            leadingAnchor: leadingAnchor, leadingAnchorConstant: 0,
            trailingAnchor: trailingAnchor, trailingAnchorConstant: 0)
        
        totalEat.setConstraint(
            topAnchor: totalYouEatLabel.bottomAnchor, topAnchorConstant: 8,
            bottomAnchor: bottomAnchor,
            leadingAnchor: leadingAnchor, leadingAnchorConstant: 0,
            trailingAnchor: trailingAnchor, trailingAnchorConstant: 0)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}



//class ChallengeProgressView: UIView {
//
//    let dateLabel = UILabel()
//    var totalEatPerDay: Int = 0
//    let totalEatPerDayLabel = UILabel()
//
//    let collectionView: UICollectionView = {
//        let flow = UICollectionViewFlowLayout()
//        flow.scrollDirection = .horizontal
//        let cv = UICollectionView(frame: .zero, collectionViewLayout: flow)
//        return cv
//    }()
//
//    override init(frame: CGRect) {
//        super.init(frame: frame)
//
//        let titleLabel = UILabel()
//        titleLabel.text = "Update Progress"
//        titleLabel.font = .preferredFont(forTextStyle: .body)
//        addSubview(titleLabel)
//
//        dateLabel.text = "Wednesday, 14 October 2020"
//        dateLabel.font = .preferredFont(forTextStyle: .headline)
//        addSubview(dateLabel)
//
//        addSubview(collectionView)
//
//        let howMuchLabel = UILabel()
//        howMuchLabel.text = "How much do you eat?"
//        addSubview(howMuchLabel)
//
//        totalEatPerDayLabel.text = "\(totalEatPerDay)"
//        totalEatPerDayLabel.font = .preferredFont(forTextStyle: .title1)
//        totalEatPerDayLabel.font = .boldSystemFont(ofSize: 34)
//
//        let minButton = UIButton(type: .system)
//        minButton.setImage(UIImage(systemName: "minus"), for: .normal)
//        minButton.addTarget(self, action: #selector(handleMinus), for: .touchUpInside)
//
//        let plusButton = UIButton(type: .system)
//        plusButton.setImage(UIImage(systemName: "plus"), for: .normal)
//        plusButton.addTarget(self, action: #selector(handlePlus), for: .touchUpInside)
//
//        let stackView = UIStackView(arrangedSubviews: [minButton, totalEatPerDayLabel, plusButton])
//        stackView.axis = .horizontal
//        stackView.spacing = 32
//        addSubview(stackView)
//
//        titleLabel.setConstraint(topAnchor: topAnchor, topAnchorConstant: 0,
//                                 leadingAnchor: leadingAnchor, leadingAnchorConstant: 0,
//                                 trailingAnchor: trailingAnchor, trailingAnchorConstant: 0)
//        dateLabel.setConstraint(topAnchor: titleLabel.bottomAnchor, topAnchorConstant: 16,
//                                leadingAnchor: leadingAnchor, leadingAnchorConstant: 0,
//                                trailingAnchor: trailingAnchor, trailingAnchorConstant: 0)
//        setupCollectionView()
//
//        howMuchLabel.setConstraint(topAnchor: collectionView.bottomAnchor, topAnchorConstant: 32,
//                                   leadingAnchor: leadingAnchor, leadingAnchorConstant: 0)
//
//        stackView.setConstraint(topAnchor: howMuchLabel.bottomAnchor, topAnchorConstant: 32,
//                                bottomAnchor: bottomAnchor, bottomAnchorConstant: 0,
//                                leadingAnchor: leadingAnchor, leadingAnchorConstant: 0)
//
//    }
//
//    @objc private func handleMinus() {
//        totalEatPerDay -= 1
//        if totalEatPerDay <= 0 {
//            totalEatPerDay = 0
//        }
//        totalEatPerDayLabel.text = "\(totalEatPerDay)"
//    }
//
//    @objc private func handlePlus() {
//        totalEatPerDay += 1
//        totalEatPerDayLabel.text = "\(totalEatPerDay)"
//    }
//
//    private func setupCollectionView() {
//        collectionView.backgroundColor = .systemBackground
//        collectionView.showsHorizontalScrollIndicator = false
//        collectionView.setConstraint(topAnchor: dateLabel.bottomAnchor, topAnchorConstant: 16,
//                                     leadingAnchor: leadingAnchor, leadingAnchorConstant: 0,
//                                     trailingAnchor: trailingAnchor, trailingAnchorConstant: 0)
//        collectionView.heightAnchor.constraint(equalToConstant: 112).isActive = true
//
//        collectionView.register(DayCell.self, forCellWithReuseIdentifier: DayCell.reuseIdentifier)
//        collectionView.delegate = self
//        collectionView.dataSource = self
//    }
//
//    required init?(coder: NSCoder) {
//        fatalError("init(coder:) has not been implemented")
//    }
//
//}
//
//extension ChallengeProgressView: UICollectionViewDelegateFlowLayout, UICollectionViewDataSource {
//
//    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
//        return CGSize(width: 44.8, height: collectionView.frame.height)
//    }
//
//    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
//        return 7
//    }
//
//    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
//        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: DayCell.reuseIdentifier, for: indexPath) as! DayCell
//
//        return cell
//    }
//
//}
//
