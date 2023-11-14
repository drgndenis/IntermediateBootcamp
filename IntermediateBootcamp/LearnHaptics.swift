//
//  LearnHaptics.swift
//  IntermediateBootcamp
//
//  Created by Denis DRAGAN on 12.11.2023.
//

import SwiftUI

private class HapticManager {
    static let instance = HapticManager()
    
    func notification(type: UINotificationFeedbackGenerator.FeedbackType) {
        let generator = UINotificationFeedbackGenerator()
        generator.notificationOccurred(type)
    }
    
    func impact(style: UIImpactFeedbackGenerator.FeedbackStyle) {
        let generator = UIImpactFeedbackGenerator(style: style)
        generator.impactOccurred()
    }
}

struct LearnHaptics: View {
    var body: some View {
        VStack(spacing: 20) {
            Button("Error") {
                HapticManager.instance.notification(type: .error)
            }
            Button("Success") {
                HapticManager.instance.notification(type: .success)
            }
            Button("Warning") {
                HapticManager.instance.notification(type: .warning)
            }
            Button("Heavy") {
                HapticManager.instance.impact(style: .heavy)
            }
            Button("Light") {
                HapticManager.instance.impact(style: .light)
            }

            Button("Medium") {
                HapticManager.instance.impact(style: .medium)
            }

            Button("Rigid") {
                HapticManager.instance.impact(style: .rigid)
            }
            Button("Soft") {
                HapticManager.instance.impact(style: .soft)
            }
        }
    }
}

#Preview {
    LearnHaptics()
}
