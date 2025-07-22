//
//  ContentView.swift
//  NIDashboardGachorr
//
//  Created by Alvin Justine on 22/07/25.
//

//import SwiftUI
//
//struct ContentView: View {
//    var body: some View{
//        Grid(horizontalSpacing: 8, verticalSpacing: 8){
//            GridRow{
//                TollCameraView(title: "Camera 1")
//                TollCameraView(title: "Camera 2")
//            }
//            .frame(height: 300)
//            
//            GridRow{
//                DashboardGachorrView()
//                KeyboardView()
//            }
//            .frame(height: 300)
//        }
//        .padding()
//    }
//}
//
//#Preview {
//    ContentView()
//}

import SwiftUI

struct ContentView: View {
    var body: some View{
        GeometryReader { geometry in
            Grid(horizontalSpacing: 0, verticalSpacing: 0){
                GridRow {
                    TollCameraView(title: "Camera 1")
                        .frame(height: geometry.size.height / 2 - 8)
                    
                    TollCameraView(title: "Camera 2")
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

