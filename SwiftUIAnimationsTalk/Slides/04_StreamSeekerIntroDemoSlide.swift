import SwiftUI
import DeckUI
import AVKit

let StreamSeekerIntroDemoSlide = Slide {
    RawView {
        let url = Bundle.main.url(forResource: "StreamSeekerDemo.mov", withExtension: nil)!
        let player = AVPlayer(url: url)

        VideoPlayer(player: player)
            .aspectRatio(CGSize(width: 1270, height: 1080), contentMode: .fit)
            .frame(maxWidth: .infinity, alignment: .center)
            .task {
                try? await Task.sleep(for: .seconds(2))
                player.play()
            }
    }
}
