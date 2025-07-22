//
//  DashboardGachorrView.swift
//  NIDashboardGachorr
//
//  Created by Alvin Justine on 22/07/25.
//

//import Foundation
//import SwiftUI
//
//struct DashboardGachorrView: View{
//    var body: some View {
//        VStack(alignment: .leading, spacing: 8) {
//            Text("Ini dashboard baru kita")
//                .foregroundColor(.black)
//        }
//        .padding()
//        .background(Color.white)
//        .border(Color.black)
//    }
//}

import SwiftUI

struct DashboardGachorrView: View {
    var body: some View {
        ZStack{
            //Blue Gradient background
            LinearGradient(
                gradient: Gradient(colors:[
                    Color(red: 0.05, green: 0.20, blue: 0.40),
                    Color(red: 0.15, green: 0.45, blue: 0.80)
                ]),
                startPoint: .topLeading,
                endPoint: .bottomTrailing
            )
            
            VStack(alignment: .leading, spacing: 8) {
            }
            .padding(16)
        }
        
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .cornerRadius(8)
        .overlay(
            RoundedRectangle(cornerRadius: 8)
                .stroke(Color.white.opacity(0.3), lineWidth: 1)
        )
        .shadow(color: Color.black.opacity(0.2), radius: 4, x: 0, y:2)
    }
}

#Preview {
    DashboardGachorrView()
}


