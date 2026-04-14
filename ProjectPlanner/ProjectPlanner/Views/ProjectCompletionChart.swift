//
//  ProjectCompletionChart.swift
//  ProjectPlanner
//
//  Created by DevTechie on 1/17/26.
//
import Charts
import SwiftUI

struct ProjectCompletionChart: View {
    let completedCount: Int
    let pendingCount: Int
    
    private var totalCount: Int {
        completedCount + pendingCount
    }
    
    var body: some View {
        VStack(alignment: .leading, spacing: 12) {
            ZStack {
                Chart {
                    SectorMark(
                        angle: .value("Completed", completedCount),
                        innerRadius: .ratio(0.6),
                        angularInset: 1
                    )
                    .foregroundStyle(.green.gradient)
                    
                    SectorMark(
                        angle: .value("Pending", pendingCount),
                        innerRadius: .ratio(0.6),
                        angularInset: 1
                    )
                    .foregroundStyle(.pink.gradient)
                }
                .frame(height: 130)
                .background {
                    VStack(spacing: 4) {
                        Text("\(completedCount) / \(totalCount)")
                            .bold()
                        Text("done")
                            .font(.caption)
                            .foregroundColor(.secondary)
                    }
                }
            }
        }
        .padding()
    }
}
