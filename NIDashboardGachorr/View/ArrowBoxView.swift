//
//  ArrowBoxView.swift
//  NIDashboardGachorr
//
//  Created by Alvin Justine on 22/07/25.
//

import Foundation
import SwiftUI

struct ArrowBoxView: View {
    var body: some View {
        ZStack(alignment: .topTrailing) {
            //1) The grey box
            Rectangle()
                .fill(Color.gray.opacity(0.7))
            
            Image(systemName: "arrow.down")
                .resizable()
                .scaledToFit()
                .frame(width: 20, height: 20)
                .foregroundColor(.green)
                .padding(6)
        }
        .frame(width: 60, height: 60)
        .cornerRadius(6)
    }
}
