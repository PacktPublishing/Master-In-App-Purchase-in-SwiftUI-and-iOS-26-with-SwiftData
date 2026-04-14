//
//  ProjectRow.swift
//  ProjectPlanner
//
//  Created by DevTechie on 1/13/26.
//

import SwiftUI

struct ProjectRow: View {
    
    let project: ProjectItem
    
    var body: some View {
        HStack {
            Text(AppConstants.statusEmoji(project.isCompleted))
                .font(.largeTitle)
            
            VStack(alignment: .leading, spacing: 6) {
                Text(project.name)
                    .font(.headline)
                
                if project.isCompleted {
                    Text((project.completionDate ?? Date()).formatted(date: .long, time: .shortened))
                        .font(.caption)
                        .foregroundStyle(.green.opacity(0.7))
                } else {
                    Text(project.dueDate.formatted(date: .long, time: .shortened))
                        .font(.caption)
                        .foregroundStyle(.secondary)
                }
            }
            
            Spacer()
            
            Text(AppConstants.prioriryEmoji(project.priority))
                .font(.title)
        }
        .padding()
        .frame(maxWidth: .infinity, alignment: .leading)
        .background(Color(uiColor: .secondarySystemBackground).shadow(.drop(radius: 5)), in: .rect(cornerRadius: 16))
    }
}
