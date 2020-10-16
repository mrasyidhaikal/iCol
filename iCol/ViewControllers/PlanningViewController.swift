//
//  PlanningViewController.swift
//  iCol
//
//  Created by Muhammad Rasyid khaikal on 14/10/20.
//

import UIKit

class PlanningViewController: UIViewController {
    
    let goalSlider = UISlider()
    let goalLabel = UILabel()
    let reducePerWeekLabel = UILabel()
    let valueUssaly = UILabel()
    let valueMuch = UILabel()
    private var consumptionStackView: UIStackView! = nil
    private var startEndStackView: UIStackView! = nil
    private var sliderStackView: UIStackView! = nil
    private var dateStackView: UIStackView! = nil
    
    let startEndTextField = UITextField()
    let currentConsumptionTextfield = UITextField()
    
    lazy var txtDatePicker:UITextField = {
        let txt = UITextField()
        txt.rightView = UIImageView(image: UIImage(systemName: "calendar"))
        txt.rightViewMode = .always
        txt.font = UIFont.preferredFont(forTextStyle: .body)
        txt.borderStyle = .none
        txt.placeholder = "Enter your date"

        let datePick = UIDatePicker()
        datePick.datePickerMode = .date
        if #available(iOS 13.4, *) {
            datePick.preferredDatePickerStyle = .wheels
        } else {
            // Fallback on earlier versions
        }
        txt.inputView = datePick
        
        datePick.addTarget(self, action: #selector(self.valuechangedDateStart), for: .valueChanged)
        return txt
    }()
    
    lazy var txtDatePicker2:UITextField = {
        let txt = UITextField()
        txt.font = UIFont.preferredFont(forTextStyle: .body)
        txt.leftView = UIImageView(image: UIImage(systemName: "calendar"))
        txt.leftViewMode = .always
        txt.borderStyle = .roundedRect
        txt.backgroundColor = #colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1)
        txt.tintColor = .black
        
        let datePick = UIDatePicker()
        datePick.datePickerMode = .date
        
        if #available(iOS 13.4, *) {
            datePick.preferredDatePickerStyle = .wheels
        } else {
            // Fallback on earlier versions
        }
        txt.inputView = datePick
        
        datePick.addTarget(self, action: #selector(self.valuechangedDateEnd), for: .valueChanged)
        return txt
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        setupBackground()
        setupNavigation()
        setupConsumtion()
        setupSlider()
//        setupDate()
        setupTextfield()
    }
    
    private func setupBackground() {
        view.backgroundColor = #colorLiteral(red: 0.968627451, green: 0.968627451, blue: 0.968627451, alpha: 1)
    }
    
    private func setupNavigation() {
        navigationItem.title = "Let’s set a plan!"
        navigationController?.navigationBar.prefersLargeTitles = true
    }
    
    private func setupConsumtion() {
    
        currentConsumptionTextfield.keyboardType = .numberPad
        currentConsumptionTextfield.borderStyle = .none
        currentConsumptionTextfield.addTarget(self, action: #selector(perWeekValue), for: .editingChanged)
        currentConsumptionTextfield.placeholder = "Enter your consumption"
        
        let line = UIView()
        line.backgroundColor = .label
        line.setConstraint(heighAnchorConstant: 2)
        
        let perDayUssaly = UILabel()
        perDayUssaly.text = "Your current consumption (per day)"
        perDayUssaly.font = UIFont.preferredFont(forTextStyle: .title3)
        
        valueUssaly.font = UIFont.preferredFont(forTextStyle: .subheadline)
        valueUssaly.text = "Estimated : 0 piece(s) / week"
        
        consumptionStackView = UIStackView(arrangedSubviews: [perDayUssaly, currentConsumptionTextfield, line])
        consumptionStackView.axis = .vertical
        consumptionStackView.spacing = 16
        
        view.addSubview(consumptionStackView)
        
        consumptionStackView.setConstraint(
            topAnchor: view.safeAreaLayoutGuide.topAnchor, topAnchorConstant: 24,
            leadingAnchor: view.layoutMarginsGuide.leadingAnchor,
            trailingAnchor: view.layoutMarginsGuide.trailingAnchor)
    }
    
    private func setupSlider() {
        
        let goalText = UILabel()
        goalText.text = "Set your daily goal"
        goalText.font = UIFont.preferredFont(forTextStyle: .title3)
        
        reducePerWeekLabel.text = "Reduce: 2 piece(s) / day"
        reducePerWeekLabel.font = UIFont.preferredFont(forTextStyle: .subheadline)
        
        goalSlider.tintColor = Color.primary
        goalSlider.addTarget(self, action: #selector(sliderValue(_:)), for: .valueChanged)
        
        let line = UIView()
        line.backgroundColor = .label
        line.setConstraint(heighAnchorConstant: 2)
        
        goalLabel.text = "0 piece"
        goalLabel.font = .preferredFont(forTextStyle: .title2)
        goalLabel.font = .boldSystemFont(ofSize: 22)
        
        sliderStackView = UIStackView(arrangedSubviews: [goalText, goalLabel, goalSlider, reducePerWeekLabel])
        sliderStackView.axis = .vertical
        sliderStackView.spacing = 16
        sliderStackView.setCustomSpacing(16, after: goalLabel)
        view.addSubview(sliderStackView)
        
        sliderStackView.setConstraint(
            topAnchor: consumptionStackView.bottomAnchor, topAnchorConstant: 56,
            leadingAnchor: view.layoutMarginsGuide.leadingAnchor,
            trailingAnchor: view.layoutMarginsGuide.trailingAnchor)
    }
    
    private func setupTextfield() {
        
        let label = UILabel()
        label.text = "When you would like to start?"
        label.font = .preferredFont(forTextStyle: .title3)
        
        let line = UIView()
        line.backgroundColor = .label
        line.setConstraint(heighAnchorConstant: 2)
        
        let stackView = UIStackView(arrangedSubviews: [label, txtDatePicker, line])
        stackView.axis = .vertical
        stackView.spacing = 16
        view.addSubview(stackView)
        
        stackView.setConstraint(topAnchor: sliderStackView.bottomAnchor, topAnchorConstant: 56,
                                    leadingAnchor: view.layoutMarginsGuide.leadingAnchor, leadingAnchorConstant: 0,
                                    trailingAnchor: view.layoutMarginsGuide.trailingAnchor, trailingAnchorConstant: 0)
    }
    
    private func setupDate() {
        
        let perDayMuch = UILabel()
        perDayMuch.text = "When you whould like to start ?"
        perDayMuch.font = UIFont.preferredFont(forTextStyle: .title3)
        
        view.addSubview(perDayMuch)
        
        perDayMuch.setConstraint(topAnchor: sliderStackView.bottomAnchor, topAnchorConstant: 56,
                                 leadingAnchor: view.layoutMarginsGuide.leadingAnchor,
                                 trailingAnchor: view.layoutMarginsGuide.trailingAnchor)
        
        let startLabel = UILabel()
        let endLabel = UILabel()
        startLabel.text = "Start"
        startLabel.font = UIFont.preferredFont(forTextStyle: .title3)
        endLabel.text = "End"
        endLabel.font = UIFont.preferredFont(forTextStyle: .title3)

        startEndStackView = UIStackView(arrangedSubviews: [startLabel, endLabel])
        startEndStackView.axis = .horizontal
        startEndStackView.distribution = .fillEqually
        startEndStackView.spacing = 16
        view.addSubview(startEndStackView)

        startEndStackView.setConstraint(topAnchor: perDayMuch.bottomAnchor, topAnchorConstant: 32,
                                 leadingAnchor: view.layoutMarginsGuide.leadingAnchor,
                                 trailingAnchor: view.layoutMarginsGuide.trailingAnchor)

        dateStackView = UIStackView(arrangedSubviews: [txtDatePicker, txtDatePicker2])
        dateStackView.axis = .horizontal
        dateStackView.spacing = 16
        dateStackView.distribution = .fillEqually
        view.addSubview(dateStackView)
        dateStackView.setConstraint(topAnchor: startEndStackView.bottomAnchor, topAnchorConstant: 16,
                             leadingAnchor: view.layoutMarginsGuide.leadingAnchor, leadingAnchorConstant: 0,
                             trailingAnchor: view.layoutMarginsGuide.trailingAnchor, trailingAnchorConstant: 0)
    }
    
    // MARK: Date
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
    
    @objc func valuechangedDateStart(sender: UIDatePicker) {
        let dateFormat = DateFormatter()
        dateFormat.dateStyle = .long
        dateFormat.dateFormat = "E, dd MMM YYYY"
        self.txtDatePicker.text = dateFormat.string(from: sender.date)
    }
    
    @objc func valuechangedDateEnd(sender: UIDatePicker) {
        let dateFormat = DateFormatter()
        dateFormat.dateStyle = .long
        dateFormat.dateFormat = "E dd MMM"
        self.txtDatePicker2.text = dateFormat.string(from: sender.date)
    }
    
    // MARK: Slider
    @objc func sliderValue(_ sender:UISlider) {
        goalLabel.text = "\(String(Int(sender.value))) Pieces"
    }
    
    @objc func perWeekValue(_ sender:UITextField) {
        guard let valuePerDay = sender.text else { return }
        
        if sender.text != "" {
            guard let valueDay = Int(valuePerDay) else { return }
            let valuePerWeek = (Int(valueDay) * 7) - 2
            valueUssaly.text = "Estimated : \(valuePerWeek) piece(s) / week"
            goalSlider.maximumValue = Float(valuePerWeek)
            goalSlider.value = Float(valuePerWeek)
            goalLabel.text = "\(valuePerWeek)"
        } else {
            valueUssaly.text = "Estimated : 0 piece(s) / week"
            goalLabel.text = "0 Pieces"
            reducePerWeekLabel.text = "Reduce : 0 piece(s) / week"
        }
    }
    
}
