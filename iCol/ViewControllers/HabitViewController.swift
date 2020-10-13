//
//  ViewController.swift
//  iCol
//
//  Created by Muhammad Rasyid khaikal on 12/10/20.
//

import UIKit

class HabitViewController: UITableViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        setupNavigation()
        setupTableView()
    }

    private func setupNavigation() {
        navigationItem.title = "Habit"
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(handleHabitCreate))
        navigationController?.navigationBar.prefersLargeTitles = true
    }
    
    private func setupTableView() {
        tableView.register(HabitCell.self, forCellReuseIdentifier: HabitCell.reuseIdentifier)
        tableView.rowHeight = 100
        tableView.separatorStyle = .none
    }
    
    @objc private func handleHabitCreate() {
        let vc = ChallengeViewController()
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: HabitCell.reuseIdentifier, for: indexPath) as! HabitCell
        cell.titleLabel.text = "Test"
        return cell
    }

}

