import SwiftUI
import DeckUI
import AVKit

let HeroSlide = Slide {
    Title("Hero Animation")

    RawView {
        let url = Bundle.main.url(forResource: "HeroSlowMode.mov", withExtension: nil)!
        let player = AVPlayer(url: url)

        VideoPlayer(player: player)
            .aspectRatio(CGSize(width: 590, height: 1278), contentMode: .fit)
            .frame(maxWidth: .infinity, alignment: .center)
            .task {
                try? await Task.sleep(for: .seconds(1))
                player.play()
            }
    }
}
