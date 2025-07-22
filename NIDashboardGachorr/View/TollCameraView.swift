//
//  TollCameraView.swift
//  NIDashboardGachorr
//
//  Created by Alvin Justine on 22/07/25.
//

import Foundation
import SwiftUI

struct TollCameraView: View{
    var title: String
    
    var body: some View{
        VStack{
            Text(title)
                .font(.headline)
            Rectangle()
                .fill(Color.gray.opacity(0.3))
                .overlay(Text("Video Feed").foregroundColor(.black))
        }
        .border(Color.black)
    }
}
