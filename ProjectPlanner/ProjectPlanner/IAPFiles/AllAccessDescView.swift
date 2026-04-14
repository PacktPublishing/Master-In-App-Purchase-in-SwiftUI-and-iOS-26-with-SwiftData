//
//  AllAccessDescView.swift
//  ProjectPlanner
//
//  Created by DevTechie on 1/20/26.
//

import SwiftUI

struct AllAccessDescView: View {
    var body: some View {
        VStack(alignment: .center, spacing: 12) {
            Image(.logo)
                .resizable()
                .frame(width: 100, height: 100)
                .clipShape(.rect(cornerRadius: 20))
            
            Text("All Access")
                .font(.title2.bold())
            
            Text("All access gives you everything you need to track your projects.")
                .font(.body)
                .foregroundStyle(.secondary)
        }
        .padding()
    }
}

#Preview {
    AllAccessDescView()
}
