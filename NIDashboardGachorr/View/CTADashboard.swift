//
//  CTADashboard.swift
//  NIDashboardGachorr
//
//  Created by Azalia Amanda on 25/07/25.
//

import SwiftUI

struct CTADashboard: View {
    var text: String = ""
    var colorHex: String = ""
    var showAnimation: Bool = false

    @State private var pulse = false

    var body: some View {
        Text(text)
            .font(.system(size: 36, weight: .bold))
            .foregroundColor(.black)
            .frame(maxWidth: .infinity)
            .padding(.vertical, 16)
            .background(Color.white)
            .cornerRadius(8)
            .overlay(
                RoundedRectangle(cornerRadius: 8)
                    .stroke(Color(hex: colorHex), lineWidth: pulse ? 10 : 5)
                    .animation(
                        showAnimation
                        ? Animation.easeInOut(duration: 0.3).repeatForever(autoreverses: true)
                        : .default,
                        value: pulse
                    )
            )
            .shadow(color: .black.opacity(0.2), radius: 5, y: 3)
            .padding(.trailing, 20)
            .onAppear {
                if showAnimation {
                    pulse = true
                }
            }
    }
}


public extension Color {
    
    static let appBackgroundColor = Color(hex: "E1EEDF")
    
    init(hex: String) {
        let hex = hex.trimmingCharacters(in: CharacterSet.alphanumerics.inverted)
        var int = UInt64()
        Scanner(string: hex).scanHexInt64(&int)
        let r, g, b: Double
        r = Double((int >> 16) & 0xFF) / 255
        g = Double((int >> 8) & 0xFF) / 255
        b = Double(int & 0xFF) / 255
        self.init(red: r, green: g, blue: b)
    }
}


#Preview {
    CTADashboard()
}
