//
//  PlanningViewController.swift
//  iCol
//
//  Created by Muhammad Rasyid khaikal on 14/10/20.
//

import UIKit

class PlanningViewController: UIViewController {
    
    let slide = UISlider()
    let perDayUssaly = UILabel()
    let perDayMuch = UILabel()
    let goalText = UILabel()
    let goalValue = UILabel()
    let reduce = UILabel()
    let valueUssaly = UILabel()
    let valueMuch = UILabel()
    let stackConsumtion = UIStackView()
    let stackStartEnd = UIStackView()
    let stackSlider = UIStackView()
    let stack4 = UIStackView()
    let startText = UILabel()
    let endText = UILabel()
    let txtPeices = UITextField()
    
    lazy var txtDatePicker:UITextField = {
        let txt = UITextField()
        txt.leftView = UIImageView(image: UIImage(systemName: "calendar"))
        txt.leftViewMode = .always
        txt.font = UIFont.preferredFont(forTextStyle: .body)
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
        setupDate()
        setupDateText()
    }
    
    private func setupBackground() {
        view.backgroundColor = #colorLiteral(red: 0.968627451, green: 0.968627451, blue: 0.968627451, alpha: 1)
    }
    
    private func setupNavigation() {
        navigationItem.title = "Let’s set a plan!"
        navigationController?.navigationBar.prefersLargeTitles = true
    }
    
    private func setupConsumtion() {
        txtPeices.keyboardType = .numberPad
        txtPeices.font = UIFont.preferredFont(forTextStyle: .body)
        txtPeices.borderStyle = .none
        txtPeices.layer.borderColor = UIColor.green.cgColor
        txtPeices.layer.backgroundColor = UIColor.white.cgColor
        txtPeices.layer.borderWidth = 0.0
        txtPeices.layer.shadowOffset = CGSize(width: 0, height: 1.0)
        txtPeices.layer.shadowOpacity = 1.0
        txtPeices.layer.shadowRadius = 0.0
        txtPeices.addTarget(self, action: #selector(perWeekValue), for: .editingChanged)
        
        perDayUssaly.text = "Your current consumption (per day)"
        perDayUssaly.font = UIFont.preferredFont(forTextStyle: .title3)
        
        valueUssaly.font = UIFont.preferredFont(forTextStyle: .subheadline)
        valueUssaly.text = "Estimated : 0 piece(s) / week"
        
        stackConsumtion.addArrangedSubview(perDayUssaly)
        txtPeices.translatesAutoresizingMaskIntoConstraints = false
        txtPeices.heightAnchor.constraint(equalToConstant: 50).isActive = false
        stackConsumtion.addArrangedSubview(txtPeices)
        stackConsumtion.addArrangedSubview(valueUssaly)
        stackConsumtion.axis = .vertical
        stackConsumtion.spacing = 10
        stackConsumtion.alignment = .fill
        view.addSubview(stackConsumtion)
        stackConsumtion.setConstraint(topAnchor: view.safeAreaLayoutGuide.topAnchor, topAnchorConstant: 50,
                                      leadingAnchor: view.layoutMarginsGuide.leadingAnchor,
                                      trailingAnchor: view.layoutMarginsGuide.trailingAnchor )
        
    }
    
    private func setupSlider() {
        
        goalText.text = "Set your Goal"
        goalText.font = UIFont.preferredFont(forTextStyle: .title3)
        
        reduce.text = "Reduce : 2 piece(s) / week"
        reduce.font = UIFont.preferredFont(forTextStyle: .footnote)
        
        slide.minimumValue = 0
        slide.isContinuous = true
        slide.tintColor = #colorLiteral(red: 0.4666666687, green: 0.7647058964, blue: 0.2666666806, alpha: 1)
        slide.thumbTintColor = #colorLiteral(red: 0.9607843161, green: 0.7058823705, blue: 0.200000003, alpha: 1)
        slide.addTarget(self, action: #selector(sliderValue(_:)), for: .valueChanged)
        
        goalValue.font = UIFont.preferredFont(forTextStyle: .title3)
        goalValue.layer.borderColor = UIColor.green.cgColor
        goalValue.layer.backgroundColor = UIColor.white.cgColor
        goalValue.layer.borderWidth = 0.0
        goalValue.layer.shadowOffset = CGSize(width: 0, height: 1.0)
        goalValue.layer.shadowOpacity = 1.0
        goalValue.layer.shadowRadius = 0.0
        
        stackSlider.addArrangedSubview(goalText)
        stackSlider.addArrangedSubview(slide)
        stackSlider.addArrangedSubview(goalValue)
        stackSlider.addArrangedSubview(reduce)
        stackSlider.axis = .vertical
        stackSlider.spacing = 15
        stackSlider.alignment = .fill
        view.addSubview(stackSlider)
        
        stackSlider.setConstraint(topAnchor: stackConsumtion.bottomAnchor, topAnchorConstant: 50,
                             leadingAnchor: view.layoutMarginsGuide.leadingAnchor,
                             trailingAnchor: view.layoutMarginsGuide.trailingAnchor)
    }
    
    private func setupDateText() {
        perDayMuch.text = "When you whould like to start ?"
        perDayMuch.font = UIFont.preferredFont(forTextStyle: .title3)
        
        view.addSubview(perDayMuch)
        
        perDayMuch.setConstraint(topAnchor: stackSlider.bottomAnchor, topAnchorConstant: 50,
                                 leadingAnchor: view.layoutMarginsGuide.leadingAnchor,
                                 trailingAnchor: view.layoutMarginsGuide.trailingAnchor)
    }
    
    private func setupDate() {
        startText.text = "Start"
        startText.font = UIFont.preferredFont(forTextStyle: .title3)
        endText.text = "End"
        endText.font = UIFont.preferredFont(forTextStyle: .title3)
        
        stackStartEnd.addArrangedSubview(startText)
        stackStartEnd.addArrangedSubview(endText)
        stackStartEnd.axis = .horizontal
        stackStartEnd.spacing = 0
        stackStartEnd.alignment = .fill
        view.addSubview(stackStartEnd)
        
        stackStartEnd.setConstraint(topAnchor: stackSlider.bottomAnchor, topAnchorConstant: 100,
                                 leadingAnchor: view.layoutMarginsGuide.leadingAnchor,
                                 trailingAnchor: view.layoutMarginsGuide.trailingAnchor, trailingAnchorConstant: -100)
        
        stack4.addArrangedSubview(txtDatePicker)
        stack4.addArrangedSubview(txtDatePicker2)
        stack4.axis = .horizontal
        stack4.spacing = 70
        stack4.distribution = .fillEqually
        view.addSubview(stack4)
        stack4.setConstraint(topAnchor: stackStartEnd.bottomAnchor, topAnchorConstant: 30,
                             bottomAnchor: view.safeAreaLayoutGuide.bottomAnchor , bottomAnchorConstant: -50,
                                leadingAnchor: view.layoutMarginsGuide.leadingAnchor,
                                 trailingAnchor: view.layoutMarginsGuide.trailingAnchor)
    }
    
    // MARK: Date
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
    
    @objc func valuechangedDateStart(sender: UIDatePicker) {
        let dateFormat = DateFormatter()
        dateFormat.dateStyle = .long
        dateFormat.dateFormat = "E dd MMM"
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
        goalValue.text = "\(String(Int(sender.value))) Pieces"
    }
    
    @objc func perWeekValue(_ sender:UITextField) {
        guard let valuePerDay = sender.text else{ return }
        
        if sender.text != "" {
            guard let valueDay = Int(valuePerDay) else { return }
            let valuePerWeek = (Int(valueDay) * 7) - 2
            valueUssaly.text = "Estimated : \(valuePerWeek) piece(s) / week"
            slide.maximumValue = Float(valuePerWeek)
            slide.value = Float(valuePerWeek)
            goalValue.text = "\(valuePerWeek)"
        } else {
            valueUssaly.text = "Estimated : 0 piece(s) / week"
            goalValue.text = "0 Pieces"
            reduce.text = "Reduce : 0 piece(s) / week"
        }
        
    }
    
}
