//
//  ViewExtension.swift
//  Billable Hours
//
//  Created by Елизавета Флисюк on 14.08.2026.
//

import SwiftUI
import UIKit

extension View {
    func hideKeyboard() {
        UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
    }
}

extension View {
    func fieldBorder(_ state: FieldsState) -> some View {
        overlay(
            RoundedRectangle(cornerRadius: 16)
                .stroke(state.color, lineWidth: state.borderWidth)
        )
    }
}
