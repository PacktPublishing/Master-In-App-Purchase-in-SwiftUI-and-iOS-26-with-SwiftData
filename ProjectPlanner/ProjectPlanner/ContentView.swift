//
//  ContentView.swift
//  ProjectPlanner
//
//  Created by DevTechie on 1/13/26.
//

import StoreKit
import SwiftData
import SwiftUI


struct ContentView: View {
    
    //@EnvironmentObject var productStorekit: ProductStoreKit
    //@Environment(\.scenePhase) var scenePhase
    @State private var showSubsView = false
    
    @Query(sort: [
        SortDescriptor(\ProjectItem.name, order: .forward),
        SortDescriptor(\ProjectItem.dueDate, order: .reverse)])
    var projects: [ProjectItem]
    
    @State private var path = [ProjectItem]()
    @State private var sortOrder = SortDescriptor(\ProjectItem.name)
    @State private var searchString = ""
    
    private var completedCount: Int {
        projects.filter({ $0.isCompleted }).count
    }
    
    private var pendingCount: Int {
        projects.filter({ !$0.isCompleted }).count
    }
    
    var body: some View {
        NavigationStack(path: $path) {
            List {
                HStack {
                    ProjectCompletionChart(completedCount: completedCount, pendingCount: pendingCount)
                    VStack(spacing: 12) {
                        SummaryChip(title: "Completed", count: completedCount, color: .green)
                        SummaryChip(title: "Pending", count: pendingCount, color: .pink)
                    }
                    .frame(maxWidth: .infinity)
                }
                .listRowBackground(Color.clear)
                .padding(.horizontal, 5)
                .background(Color(uiColor: .secondarySystemBackground).shadow(.drop(radius: 5)), in: .rect(cornerRadius: 16))
                
                
                ProjectListingView(sortOrder, searchString: searchString)
                
            }
            .navigationTitle("Project Planner")
            .navigationDestination(for: ProjectItem.self, destination: { project in
                EditProjectDetails(project: project, isNewProject: !(projects.contains(where: { $0.id == project.id })))
            })
            .searchable(text: $searchString, placement: .automatic, prompt: Text("Search by project name or details."))
            .toolbar {
//                ToolbarItem(placement: .topBarTrailing) {
//                    Button("Add Sample", action: addSampleData)
//                }
                
                ToolbarItem(placement: .topBarTrailing) {
                    Button("Add new project", systemImage: "plus.circle", action: addProject)
                }
                ToolbarItem(placement: .topBarTrailing) {
                    Menu("Sort", systemImage: "arrow.up.arrow.down") {
                        Picker("Sort by", selection: $sortOrder) {
                            Text("Name")
                                .tag(SortDescriptor(\ProjectItem.name))
                            Text("Due Date")
                                .tag(SortDescriptor(\ProjectItem.dueDate))
                            Text("Priority")
                                .tag(SortDescriptor(\ProjectItem.priority))
                        }
                    }
                }
            }
//            .onChange(of: productStorekit.purchasedSubscriptions) { oldValue, newValue in
//                if !newValue.isEmpty {
//                    showSubscriptionScreen()
//                }
//            }
//            .onChange(of: scenePhase) { oldValue, newValue in
//                showSubscriptionScreen()
//            }
//            .sheet(isPresented: $showSubsView) {
//                showSubscriptionScreen()
//            } content: {
//                NavigationStack {
//                    SubscriptionStoreView(groupID: "21901941") {
//                        AllAccessDescView()
//                    }
//                    .subscriptionStoreControlStyle(.automatic)
//                    .storeButton(.hidden, for: .cancellation)
//                    .navigationBarBackButtonHidden()
//                    .interactiveDismissDisabled()
//                    .subscriptionStorePolicyDestination(url: URL(string: "https://www.devtechie.com")!, for: .privacyPolicy)
//                    .subscriptionStorePolicyDestination(url: URL(string: "https://www.apple.com/legal/internet-services/itunes/dev/stdeula/")!, for: .termsOfService)
//                    .storeButton(.visible, for: .restorePurchases)
//                }
//            }
        }
    }
    
//    private func addSampleData() {
//        let videoCourse = ProjectItem(name: "Video course on SwiftData and IAP", details: "Project planner app with In-App Purchase", dueDate: Date())
//        let RecordVideo = ProjectItem(name: "Record IAP Video", details: "Record video on In App Purchase", dueDate: Date())
//        
//        modelContext.insert(videoCourse)
//        modelContext.insert(RecordVideo)
//    }
    
    private func addProject() {
        let newProject = ProjectItem()
        path = [newProject]
    }
    
//    private func showSubscriptionScreen() {
//        Task {
//            await productStorekit.updateCustomerProductStatus()
//            
//            if productStorekit.purchasedSubscriptions.isEmpty {
//                DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
//                    showSubsView = productStorekit.purchasedSubscriptions.isEmpty
//                    print(showSubsView)
//                    print(productStorekit.purchasedSubscriptions)
//                }
//            } else {
//                showSubsView = productStorekit.purchasedSubscriptions.isEmpty
//            }
//        }
//    }
}

#Preview {
    ContentView()
}
