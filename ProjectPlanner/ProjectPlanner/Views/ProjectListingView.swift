//
//  ProjectListingView.swift
//  ProjectPlanner
//
//  Created by DevTechie on 1/16/26.
//
import SwiftData
import SwiftUI

struct ProjectListingView: View {
    @Environment(\.modelContext) var modelContext
    @Query(sort: \ProjectItem.name)
    var projects: [ProjectItem]
    
    init(_ sort: SortDescriptor<ProjectItem>, searchString: String) {
        _projects = Query(filter: #Predicate {
            if searchString.isEmpty {
                return true
            } else {
                return $0.name.localizedStandardContains(searchString) || $0.details.localizedStandardContains(searchString)
            }
        }
                          ,sort: [sort])
    }
    
    var body: some View {
        Section("All Projects") {
            if projects.isEmpty {
                ContentUnavailableView("No Projects", systemImage: "rectangle.stack.fill", description: Text("Add a new project by tapping the plus button in the top right corner."))
            } else {
                ForEach(projects) { project in
                    NavigationLink(value: project) {
                        ProjectRow(project: project)
                    }
                    .listRowBackground(Color.clear)
                    .swipeActions(edge: .leading, allowsFullSwipe: true) {
                        Button {
                            toggleCompletion(for: project)
                        } label: {
                            Label(project.isCompleted ? "Undo" : "Complete", systemImage: project.isCompleted ? "arrow.uturn.left" :"checkmark")
                        }
                        .tint(project.isCompleted ? .orange : .green)
                    }
                }
                .onDelete(perform: deleteProject)
                .listRowSeparator(.hidden)
            }
        }
    }
    
    private func deleteProject(_ indexSet: IndexSet) {
        for index in indexSet {
            let project = projects[index]
            modelContext.delete(project)
        }
        try? modelContext.save()
    }
    
    private func toggleCompletion(for project: ProjectItem) {
        withAnimation {
            project.isCompleted.toggle()
        }
        
        if project.isCompleted {
            project.completionDate = Date()
        } else {
            project.completionDate = nil
        }
        
        do {
            try modelContext.save()
        } catch {
            print(error.localizedDescription)
        }
    }
}
