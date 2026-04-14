//
//  TaskItem.swift
//  ProjectPlanner
//
//  Created by DevTechie on 1/17/26.
//

import Foundation
import SwiftData

@Model
class TaskItem {
    var name: String
    
    init(name: String) {
        self.name = name
    }
}
