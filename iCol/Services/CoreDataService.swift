//
//  CoreDataService.swift
//  iCol
//
//  Created by Windy on 17/10/20.
//

import CoreData
import UIKit

class CoreDataService {
    
    static let shared = CoreDataService()
    
    func fetchFromCoreData(completion: @escaping ([Habit]) -> ()) {
        
        let moc = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
        
        let fetchRequest = NSFetchRequest<Habit>(entityName: HabitConstant.entityName)
        
        do {
            let results = try moc.fetch(fetchRequest)
            completion(results)
        } catch let err {
            print(err.localizedDescription)
        }
        
    }
    
    func getTotalEat(id: UUID) -> Int {
        let habit = getHabit(id: id)
        
        var totalEat = 0
        
        habit.days?.forEach({ (day) in
            let day = day as! SummaryDay
            totalEat += Int(day.totalEatPerDay)
        })
        
        return totalEat
    }
    
    func getHabit(id: UUID) -> Habit {
        let moc = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
        let fetchRequest = NSFetchRequest<Habit>(entityName: HabitConstant.entityName)
        fetchRequest.predicate = NSPredicate(format: "id == %@", id as CVarArg)
        
        do {
            let result = try moc.fetch(fetchRequest)
            return result[0]
        } catch let err {
            print(err.localizedDescription)
            
        }
        
        return Habit()
    }
    
    func deleteHabit(id: UUID) {
        let moc = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
        let fetchRequest = NSFetchRequest<Habit>(entityName: HabitConstant.entityName)
        fetchRequest.predicate = NSPredicate(format: "id == %@", id as CVarArg)
        
        do {
            let result = try moc.fetch(fetchRequest)
            let dataToDelete = result[0]
            
            moc.delete(dataToDelete)
            
            try moc.save()
        } catch let err {
            print(err.localizedDescription)
        }
    }
    
}
