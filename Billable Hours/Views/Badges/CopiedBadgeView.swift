//
//  CopiedBadgeView.swift
//  Billable Hours
//
//  Created by Елизавета Флисюк on 16.11.2026.
//

import SwiftUI

struct CopiedBadgeView: View {
    var body: some View {
        Text("Copied")
            .font(.subheadline)
            .padding(.vertical, 8)
            .padding(.horizontal, 12)
            .background(Color(.systemBackground))
            .foregroundStyle(.primary)
            .clipShape(Capsule())
            .padding(.top, 12)
            .transition(.move(edge: .top).combined(with: .opacity))
    }
}

#Preview {
    CopiedBadgeView()
}
