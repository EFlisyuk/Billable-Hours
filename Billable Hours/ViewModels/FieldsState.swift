//
//  FieldsColor.swift
//  Billable Hours
//
//  Created by Елизавета Флисюк on 17.11.2026.
//

import SwiftUI

enum FieldsState {
    case start
    case moderate
    case error
    
    var borderWidth: CGFloat {
        switch self {
        case .start: return 0
        case .moderate: return 1
        case .error: return 2
        }
    }
    
    var color: Color {
        self == .error ? .red : .blue
    }
}
