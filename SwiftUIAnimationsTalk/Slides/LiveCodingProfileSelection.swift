import DeckUI
import SwiftUI
import AVKit

let LiveCodingProfileSelection = Slide {
    RawView {
        let url = Bundle.main.url(forResource: "Livecoding-ProfileSelection.mov", withExtension: nil)!
        let player: AVPlayer = {
            let player = AVPlayer(url: url)
            player.defaultRate = 1.5
            return player
        }()

        VideoPlayer(player: player)
            .aspectRatio(CGSize(width: 2404, height: 1766), contentMode: .fit)
            .frame(maxWidth: .infinity, alignment: .center)
            .task {
                player.play()
            }
    }
}
