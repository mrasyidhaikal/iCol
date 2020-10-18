//
//  ViewController3.swift
//  iCol
//
//  Created by Windy on 12/10/20.
//

import UIKit

class DescriptionViewController: UIViewController {

    let descriptionLabel = UILabel()
    var type: Type?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupNavigation()
        setupBackground()
        setupDescription()
        setupButton()
    }
    
    private func setupNavigation() {
        navigationController?.navigationBar.prefersLargeTitles = true
    }
    
    private func setupBackground() {
        view.backgroundColor = .systemBackground
    }
    
    private func setupDescription() {
        descriptionLabel.text = "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Donec magna libero, fermentum eu nunc non, varius rutrum ex.  Donec non libero massa. Vestibulum vestibulum, mi vel aliquet placerat, odio risus vestibulum libero, ut ullamcorper sem neque id ligula."
        descriptionLabel.font = UIFont.preferredFont(forTextStyle: .body)
        descriptionLabel.numberOfLines = 0
        view.addSubview(descriptionLabel)
        
        descriptionLabel.setConstraint(topAnchor: view.safeAreaLayoutGuide.topAnchor, topAnchorConstant: 8,
                                       leadingAnchor: view.layoutMarginsGuide.leadingAnchor,
                                       trailingAnchor: view.layoutMarginsGuide.trailingAnchor)
    }
    
    private func setupButton() {
        let takeBtn = UIButton(type: .system)
        takeBtn.backgroundColor = Color.primary
        takeBtn.setTitleColor(UIColor.white, for: .normal)
        takeBtn.setTitle("Take The Challenge", for: .normal)
        takeBtn.titleLabel?.font = .boldSystemFont(ofSize: 18)
        takeBtn.layer.cornerRadius = 8
        view.addSubview(takeBtn)
        
        takeBtn.setConstraint(bottomAnchor: view.safeAreaLayoutGuide.bottomAnchor, bottomAnchorConstant: -16,
                              leadingAnchor: view.layoutMarginsGuide.leadingAnchor,
                              trailingAnchor: view.layoutMarginsGuide.trailingAnchor,
                              heighAnchorConstant: 50)
        takeBtn.addTarget(self, action: #selector(handlePlanning(_:)), for: .touchUpInside)
    }
    
    @objc private func handlePlanning(_ button:UIButton) {
        let vc = PlanningViewController()
        if let title = navigationItem.title {
            vc.titleHabit = title
            vc.type = self.type
        }
        navigationController?.pushViewController(vc, animated: true)
    }
    
}
