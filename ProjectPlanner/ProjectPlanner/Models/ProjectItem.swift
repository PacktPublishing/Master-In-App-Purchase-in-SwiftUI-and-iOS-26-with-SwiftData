//
//  ProjectItem.swift
//  ProjectPlanner
//
//  Created by DevTechie on 1/13/26.
//

import Foundation
import SwiftData

@Model
class ProjectItem {
    var name: String
    var details: String
    var isCompleted: Bool
    var dueDate: Date
    var priority: Int
    
    @Relationship(deleteRule: .cascade)
    var tasks: [TaskItem] = []
    
    var completionDate: Date? = nil
    
    init(name: String = "", details: String = "", isCompleted: Bool = false, dueDate: Date = .now, priority: Int = 2) {
        self.name = name
        self.details = details
        self.isCompleted = isCompleted
        self.dueDate = dueDate
        self.priority = priority
    }
}

