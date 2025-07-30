//
//  ContentView.swift
//  NIDashboardGachorr
//
//  Created by Alvin Justine on 22/07/25.
//

import SwiftUI

struct ContentView: View {
    var body: some View{
        GeometryReader { geometry in
            Grid(horizontalSpacing: 0, verticalSpacing: 0){
                GridRow {
                    Camera1View()
                        .frame(height: geometry.size.height / 2 - 8)
                    
                    Camera2View()
                        .frame(height: geometry.size.height / 2 - 8)
                }
                
                GridRow {
                    DashboardGachorrView()
                        .frame(height: geometry.size.height / 2 - 8)
                    
                    KeyboardView()
                        .frame(height: geometry.size.height / 2 - 8)
                }
            }
            .frame(width: geometry.size.width, height: geometry.size.height)
            .padding()
        }
    }
}

#Preview {
    ContentView()
}

