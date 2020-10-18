//
//  PlanningViewController.swift
//  iCol
//
//  Created by Muhammad Rasyid khaikal on 14/10/20.
//

import UIKit
import CoreData
class PlanningViewController: UIViewController {
    
    var titleHabit: String = ""
    var type: Type?
    
    private var endDate: Date?
    private let goalSlider = UISlider()
    private let goalLabel = UILabel()
    private let reducePerWeekLabel = UILabel()
    
    private var consumptionStackView: UIStackView! = nil
    private var startEndStackView: UIStackView! = nil
    private var sliderStackView: UIStackView! = nil
    private var dateStackView: UIStackView! = nil
    private let currentConsumptionTextfield = UITextField()
    
    private let datePicker: UIDatePicker = {
        let datePick = UIDatePicker()
        datePick.datePickerMode = .date
        if #available(iOS 13.4, *) {
            datePick.preferredDatePickerStyle = .wheels
        }
        return datePick
    }()
    
    private lazy var startDateTextField: UITextField = {
        let tf = UITextField()
        tf.rightView = UIImageView(image: UIImage(systemName: "calendar"))
        tf.rightViewMode = .always
        tf.font = UIFont.preferredFont(forTextStyle: .body)
        tf.borderStyle = .none
        tf.placeholder = "Enter your date"
        tf.inputView = datePicker
        datePicker.addTarget(self, action: #selector(self.handleDataPicker), for: .valueChanged)
        return tf
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = #colorLiteral(red: 0.968627451, green: 0.968627451, blue: 0.968627451, alpha: 1)
        
        setupNavigation()
        setupConsumtion()
        setupSlider()
        setupTextfield()
    }
    
    private func setupNavigation() {
        navigationItem.title = "Let’s set a plan!"
        navigationItem.rightBarButtonItem = UIBarButtonItem(
            title: "Add", style: .done,
            target: self,
            action: #selector(handleCreatePlan)
        )
        navigationController?.navigationBar.prefersLargeTitles = true
    }
    
    @objc func handleCreatePlan() {
        
        if currentConsumptionTextfield.text == "" || startDateTextField.text == "" {
            let alert = UIAlertController(title: "Warning", message: "Please enter all information", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "Okay", style: .default, handler: nil))
            present(alert, animated: true)
        } else {
            
            let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
            
            let plan = Habit(context: context)
            plan.id = UUID()
            plan.title = titleHabit
            plan.startDate = datePicker.date
            plan.totalValuePerWeek = Int32(Int(goalSlider.value))
            plan.endDate = endDate
            
            do {
                try context.save()
            } catch {
                print(error.localizedDescription)
            }
            
            self.navigationController?.popToRootViewController(animated: true)
        }
    }
    
    @objc func handleDataPicker(sender: UIDatePicker) {
        let dateFormat = DateFormatter()
        dateFormat.dateStyle = .long
        dateFormat.dateFormat = "E, dd MMM YYYY"
        
        startDateTextField.text = dateFormat.string(from: sender.date)
        endDate = Calendar.current.date(byAdding: .day, value: 7, to: sender.date)
    }
    
    @objc func handleSlider(_ sender: UISlider) {
        goalLabel.text = "\(String(Int(sender.value))) piece(s)"
    }
    
    @objc func handleTextField(_ sender: UITextField) {
        
        guard let valuePerDay = sender.text else { return }
        
        if sender.text != "" {
            
            guard let valueDay = Int(valuePerDay) else { return }
            let valuePerWeek = (Int(valueDay) * 7) - 2 * 7
            
            if valuePerWeek <= -7 {
                goalSlider.maximumValue = 0
                goalLabel.text = "\(0) piece(s)"
            } else {
                goalSlider.maximumValue = Float(valuePerWeek)
                goalSlider.setValue(Float(valuePerWeek), animated: true)
                goalLabel.text = "\(valuePerWeek) piece(s)"
            }
            
        } else {
            goalLabel.text = "0 piece(s)"
        }
    }
    
    private func setupConsumtion() {
    
        currentConsumptionTextfield.keyboardType = .numberPad
        currentConsumptionTextfield.borderStyle = .none
        currentConsumptionTextfield.addTarget(self, action: #selector(handleTextField), for: .editingChanged)
        currentConsumptionTextfield.placeholder = "Enter your consumption"
        
        let line = UIView()
        line.backgroundColor = .label
        line.setConstraint(heighAnchorConstant: 2)
        
        let perDayUssaly = UILabel()
        perDayUssaly.text = "Your current consumption (per day)"
        perDayUssaly.font = UIFont.preferredFont(forTextStyle: .title3)
        
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
        goalText.text = "Set your weekly goal"
        goalText.font = UIFont.preferredFont(forTextStyle: .title3)
        
        reducePerWeekLabel.text = "Reduce: 2 piece(s) / day"
        reducePerWeekLabel.font = UIFont.preferredFont(forTextStyle: .subheadline)
        
        goalSlider.tintColor = Color.primary
        goalSlider.addTarget(self, action: #selector(handleSlider(_: )), for: .valueChanged)
        goalSlider.minimumValue = 0
        
        let line = UIView()
        line.backgroundColor = .label
        line.setConstraint(heighAnchorConstant: 2)
        
        goalLabel.text = "0 piece(s)"
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
        
        let stackView = UIStackView(arrangedSubviews: [label, startDateTextField, line])
        stackView.axis = .vertical
        stackView.spacing = 16
        view.addSubview(stackView)
        
        stackView.setConstraint(
            topAnchor: sliderStackView.bottomAnchor, topAnchorConstant: 56,
            leadingAnchor: view.layoutMarginsGuide.leadingAnchor, leadingAnchorConstant: 0,
            trailingAnchor: view.layoutMarginsGuide.trailingAnchor, trailingAnchorConstant: 0)
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
    
}

