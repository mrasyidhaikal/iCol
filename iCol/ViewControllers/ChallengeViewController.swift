//
//  ViewController2.swift
//  iCol
//
//  Created by Windy on 12/10/20.
//

import UIKit

class ChallengeViewController: UITableViewController {
    
    private let challenges = [
        "I want to eat less gorengan",
        "I want to eat more vegetables",
        "I want to drink less soda"
    ]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        setupNavigation()
        setupTableView()
    }

    private func setupNavigation() {
        navigationItem.title = "What habit to build?"
        navigationController?.navigationBar.prefersLargeTitles = true
    }
    
    private func setupTableView() {
        tableView.register(ChallengeCell.self, forCellReuseIdentifier: ChallengeCell.reuseIdentifier)
        tableView.rowHeight = 100
        tableView.separatorStyle = .none
    }
 
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return challenges.count
    }
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
     
        let vc = DescriptionViewController()
        navigationController?.pushViewController(vc, animated: true)
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: ChallengeCell.reuseIdentifier, for: indexPath) as! ChallengeCell
        cell.titleLabel.text = challenges[indexPath.row]
        
        return cell
    }

}
