//
//  Date+Extensions.swift
//  iCol
//
//  Created by Windy on 18/10/20.
//

import Foundation


extension Date {
    
    func startDate(of date: Date) -> Date {
        return Calendar.current.startOfDay(for: date)
    }

    func endDate(of date: Date) -> Date {
        var components = DateComponents()
        components.day = 1
        components.second = -1
        
        return Calendar.current.date(byAdding: components, to: self.startDate(of: date))!
    }
    
    func nextDate() -> Date {
        var components = DateComponents()
        components.day = 1
        
        return Calendar.current.date(byAdding: components, to: Date())!
    }
    
    func toShortFormat(of date: Date) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateStyle = .medium
        return dateFormatter.string(from: date)
    }
    
}
