//
//  LoopingVideoPlayerView.swift
//  NIDashboardGachorr
//
//  Created by Khresna Sariyanto on 23/07/25.
//

import SwiftUI
import AVKit

struct LoopingVideoPlayerView: NSViewRepresentable {
    let videoName: String
    let videoType: String

    func makeNSView(context: Context) -> AVPlayerView {
        let playerView = AVPlayerView()
        playerView.controlsStyle = .none
        playerView.translatesAutoresizingMaskIntoConstraints = false

        if let path = Bundle.main.path(forResource: videoName, ofType: videoType) {
            let url = URL(fileURLWithPath: path)
            let player = AVQueuePlayer()
            let item = AVPlayerItem(url: url)

            //Looping video
            let looper = AVPlayerLooper(player: player, templateItem: item)
            context.coordinator.looper = looper

            playerView.player = player
            player.play()
        }

        return playerView
    }

    func updateNSView(_ nsView: AVPlayerView, context: Context) {
        //Nothing to update dynamically
    }

    func makeCoordinator() -> Coordinator {
        Coordinator()
    }

    class Coordinator {
        var looper: AVPlayerLooper?
    }
}
