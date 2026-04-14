//
//  SummaryChip.swift
//  ProjectPlanner
//
//  Created by DevTechie on 1/13/26.
//

import SwiftUI

struct SummaryChip: View {
    let title: String
    let count: Int
    let color: Color
    
    var body: some View {
        VStack(spacing: 4) {
            Text("\(count)")
                .font(.title2.bold())
            
            Text(title)
                .font(.caption)
        }
        .foregroundStyle(color.gradient)
        .padding(.vertical, 10)
        .frame(maxWidth: .infinity)
        .background {
            RoundedRectangle(cornerRadius: 16)
                .fill(color.opacity(0.1))
                .shadow(radius: 5)
        }
        
    }
}
