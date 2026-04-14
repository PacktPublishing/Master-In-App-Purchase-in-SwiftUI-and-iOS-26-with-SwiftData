//
//  EditProjectDetails.swift
//  ProjectPlanner
//
//  Created by DevTechie on 1/13/26.
//

import SwiftData
import SwiftUI

struct EditProjectDetails: View {
    
    @Bindable var project: ProjectItem
    
    @Environment(\.modelContext) private var modelContext
    @Environment(\.dismiss) private var dismiss
    let isNewProject: Bool
    
    @State private var newTaskName = ""
    
    var body: some View {
        Form {
            TextField("Project name", text: $project.name)
            TextField("Project details", text: $project.details)
            DatePicker("Due date", selection: $project.dueDate)
            
            Toggle("Is completed?", isOn: $project.isCompleted)
                .onChange(of: project.isCompleted) { _, isCompleted in
                    if isCompleted {
                        project.completionDate = Date()
                    } else {
                        project.completionDate = nil
                    }
                }
            
            Section("Priority") {
                Picker("Priority", selection: $project.priority) {
                    Text("Low")
                        .tag(1)
                    Text("Medium")
                        .tag(2)
                    Text("High")
                        .tag(3)
                }
                .pickerStyle(.segmented)
            }
            
            Section("Tasks") {
                ForEach(project.tasks) { task in
                    Text(task.name)
                        .font(.title3.bold())
                }
                .onDelete(perform: deleteTask)
                
                HStack {
                    TextField("Add new task in \(project.name)", text: $newTaskName)
                    Button("Add", action: addTask)
                }
            }
        }
        .navigationTitle(isNewProject ? "Add New Project" : "Edit \(project.name)")
        .navigationBarTitleDisplayMode(.inline)
        .toolbar {
            if isNewProject {
                ToolbarItem(placement: .cancellationAction) {
                    Button("Cancel") {
                        cancel()
                    }
                }
                ToolbarItem(placement: .confirmationAction) {
                    Button("Save") {
                        save()
                    }
                    .disabled(project.name.trimmingCharacters(in: .whitespaces).isEmpty)
                }
            }
        }
    }
    
    private func save() {
        if isNewProject {
            modelContext.insert(project)
        }
        dismiss()
    }
    
    private func cancel() {
        dismiss()
    }
    
    private func addTask() {
        guard !newTaskName.trimmingCharacters(in: .whitespaces).isEmpty else { return }
        
        withAnimation {
            let newTask =  TaskItem(name: newTaskName)
            project.tasks.append(newTask)
            newTaskName = ""
        }
        
        saveModelContext()
    }
    
    private func deleteTask(_ indexSet : IndexSet) {
        for index in indexSet {
            project.tasks.remove(at: index)
        }
        
        saveModelContext()
    }
    
    private func saveModelContext() {
        do {
            try modelContext.save()
        } catch {
            print(error.localizedDescription)
        }
    }
}

#Preview {
    do {
        let config = ModelConfiguration(isStoredInMemoryOnly: true)
        let container = try ModelContainer(for: ProjectItem.self, configurations: config)
        let sample = ProjectItem(name: "Sample Record", details: "This is a sample record", isCompleted: false, dueDate: Date(), priority: 2)
        
        return NavigationStack {
            EditProjectDetails(project: sample, isNewProject: false).modelContainer(container)
        }
    } catch {
        fatalError("Failed to load in-memory model container")
    }
}
