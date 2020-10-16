//
//  ViewController3.swift
//  iCol
//
//  Created by Windy on 12/10/20.
//

import UIKit

class DescriptionViewController: UIViewController {

    let descriptionLabel = UILabel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupNavigation()
        setupDescription()
        setupButton()
    }
    
    private func setupNavigation() {
        navigationItem.title = "Eat Less Gorengan"
        navigationController?.navigationBar.prefersLargeTitles = true
    }
    
    private func setupDescription() {
        descriptionLabel.text = "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Donec magna libero, fermentum eu nunc non, varius rutrum ex.  Donec non libero massa. Vestibulum vestibulum, mi vel aliquet placerat, odio risus vestibulum libero, ut ullamcorper sem neque id ligula."
        descriptionLabel.font = UIFont.preferredFont(forTextStyle: .title3)
        descriptionLabel.numberOfLines = 0
        view.addSubview(descriptionLabel)
        
        descriptionLabel.setConstraint(topAnchor: view.safeAreaLayoutGuide.topAnchor, topAnchorConstant: 16,
                                       leadingAnchor: view.layoutMarginsGuide.leadingAnchor,
                                       trailingAnchor: view.layoutMarginsGuide.trailingAnchor)
    }
    
    private func setupButton() {
        let takeBtn = UIButton(type: .system)
        takeBtn.backgroundColor = UIColor.black
        takeBtn.setTitleColor(UIColor.white, for: .normal)
        takeBtn.setTitle("Take Me", for: .normal)
        takeBtn.layer.cornerRadius = 8
        view.addSubview(takeBtn)
        
        takeBtn.setConstraint(bottomAnchor: view.safeAreaLayoutGuide.bottomAnchor, bottomAnchorConstant: -16,
                              leadingAnchor: view.layoutMarginsGuide.leadingAnchor,
                              trailingAnchor: view.layoutMarginsGuide.trailingAnchor)
        takeBtn.heightAnchor.constraint(equalToConstant: 50).isActive = true
        takeBtn.addTarget(self, action: #selector(handlePlanning(_:)), for: .touchUpInside)
    }
    
    @objc private func handlePlanning(_ button:UIButton) {
        let vc = PlanningViewController()
        self.navigationController?.pushViewController(vc, animated: true)
    }
    

}
