//
//  AppConstants.swift
//  ProjectPlanner
//
//  Created by DevTechie on 1/13/26.
//

import Foundation

struct AppConstants {
    static func statusEmoji(_ isCompleted: Bool) -> String {
        isCompleted ? "✅" : "⏳"
    }
    
    static func prioriryEmoji(_ priority: Int) -> String {
        switch priority {
        case 2: return "🐇"
        case 3: return "🐆"
        default: return "🐌"
        }
    }
}
