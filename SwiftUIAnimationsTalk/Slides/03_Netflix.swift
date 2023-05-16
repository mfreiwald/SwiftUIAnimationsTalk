import SwiftUI
import DeckUI
import AVKit

let NetflixAppSlide = Slide {
    RawView {
        let url = Bundle.main.url(forResource: "NetflixApp.mov", withExtension: nil)!
        let player = AVPlayer(url: url)

        VideoPlayer(player: player)
            .aspectRatio(CGSize(width: 1080, height: 1920), contentMode: .fit)
            .frame(maxWidth: .infinity, alignment: .center)
            .task {
                player.play()
            }
    }
}
