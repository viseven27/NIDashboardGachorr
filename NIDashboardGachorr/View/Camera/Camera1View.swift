//
//  Camera1View.swift
//  NIDashboardGachorr
//
//  Created by Khresna Sariyanto on 23/07/25.
//


import SwiftUI

struct Camera1View: View {
    var body: some View {
        ZStack{
            Color.gray.opacity(0.2)
            LoopingVideoPlayerView(videoName: "Camera1Video", videoType: "mp4")
                .frame(maxWidth: .infinity, maxHeight: .infinity)
        }
        .border(Color.black)
    }
}
