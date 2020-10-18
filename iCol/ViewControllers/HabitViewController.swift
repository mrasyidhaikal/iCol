//
//  ViewController.swift
//  iCol
//
//  Created by Muhammad Rasyid khaikal on 12/10/20.
//

import UIKit
import CoreData


class HabitViewController: UITableViewController, DismissDetailHabit {
    
    private var habits: [Habit] = []

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        setupNavigation()
        setupTableView()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        CoreDataService.shared.fetchFromCoreData { (result) in
            self.habits = result
        }
        tableView.reloadData()
    }

    private func setupNavigation() {
        navigationItem.title = "Habit"
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(handleHabitCreate))
        navigationController?.navigationBar.prefersLargeTitles = true
    }
    
    private func setupTableView() {
        tableView.register(HabitCell.self, forCellReuseIdentifier: HabitCell.reuseIdentifier)
        tableView.rowHeight = 130
        tableView.separatorStyle = .none        
        tableView.backgroundView = UIImageView(image: UIImage(named: "bgVector"))
    }
    
    @objc private func handleHabitCreate() {
        let vc = ChallengeViewController()
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    func didSendTotal(isDismiss: Bool) {
        if isDismiss {
            CoreDataService.shared.fetchFromCoreData { (result) in
                self.habits = result
            }
            tableView.reloadData()
        }
    }
    
}

extension HabitViewController {
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return habits.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: HabitCell.reuseIdentifier, for: indexPath) as! HabitCell
        cell.backgroundColor = .clear
        cell.setupHabitCell(habit: habits[indexPath.row])
        return cell
    }

    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let vc = HabitDetailViewController()
        vc.habit = habits[indexPath.row]
        vc.delegate = self
        let nav = UINavigationController(rootViewController: vc)
        present(nav, animated: true)
    }
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            CoreDataService.shared.deleteHabit(id: habits[indexPath.row].id!)
            habits.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .fade)
            tableView.reloadData()
        }
    }
    
}

