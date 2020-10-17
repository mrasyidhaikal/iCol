//
//  ViewController.swift
//  iCol
//
//  Created by Muhammad Rasyid khaikal on 12/10/20.
//

import UIKit
import CoreData

class CoreDataService {
    
    static let shared = CoreDataService()
    
    func fetchFromCoreData(completion: @escaping ([Planning]) -> ()) {
        
        let moc = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
        
        let fetchRequest = NSFetchRequest<Planning>(entityName: PlanningConstant.entityName)
        
        do {
            let results = try moc.fetch(fetchRequest)
            completion(results)
        } catch let err {
            print(err.localizedDescription)
        }
        
    }
    
}

class HabitViewController: UITableViewController {
    
    private var habits: [Planning] = []

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
        let vc = UINavigationController(rootViewController: HabitDetailViewController())
        present(vc, animated: true)
    }
    
}

