//
//  ViewController3.swift
//  iCol
//
//  Created by Windy on 12/10/20.
//

import UIKit

class DescriptionViewController: UIViewController {

//    private let challenges :[String]
//
//    init(challenges:[String]) {
//        self.challenges = challenges
//        super.init(nibName: nil, bundle: nil)
//    }
//
//    required init?(coder: NSCoder) {
//        fatalError("init(coder:) has not been implemented")
//    }

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
    private func setupDescription(){
        let description = UILabel()
        description.text = "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Donec magna libero, fermentum eu nunc non, varius rutrum ex. Donec non libero massa. Vestibulum vestibulum, mi vel aliquet placerat, odio risus vestibulum libero, ut ullamcorper sem neque id ligula."
        description.font = UIFont.preferredFont(forTextStyle: .title3)
        description.numberOfLines = 0
        view.addSubview(description)
        description.setConstraint(topAnchor: view.topAnchor ,topAnchorConstant: 180, bottomAnchor: nil, leadingAnchor: view.leadingAnchor,leadingAnchorConstant:22,trailingAnchor: view.trailingAnchor,trailingAnchorConstant:-20 , centerXAnchor: nil, centerYAnchor: nil)
    }
    private func setupButton(){
        let takeBtn = UIButton(type: .system)
        takeBtn.backgroundColor = UIColor.black
        takeBtn.setTitleColor(UIColor.white, for: .normal)
        takeBtn.layer.cornerRadius = 8
        view.addSubview(takeBtn)
        
        takeBtn.setConstraint(topAnchor: nil, bottomAnchor:nil , leadingAnchor: view.leadingAnchor,leadingAnchorConstant:50 , trailingAnchor: view.trailingAnchor,trailingAnchorConstant:-50 , centerXAnchor: nil, centerYAnchor: view.centerYAnchor,centerYAnchorConstant:240 )
        takeBtn.heightAnchor.constraint(equalToConstant: 50).isActive = true
    }
    

}
