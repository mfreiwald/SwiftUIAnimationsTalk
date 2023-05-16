import SwiftUI
import DeckUI
import AVKit

let LearningsSlide1 = Slide {
    Title("Learnings")

    Words("ViewModifier order matters")

    Code(.swift) { """
/// ✅ This works
Rectangle()
    .fill(.red)
    .matchedGeometryEffect(id: "box", in: namespace)
    .frame(width: 100, height: 100)

/// ❌ This doesn't work, if the size (frame) should change over time
Rectangle()
    .fill(.red)
    .frame(width: 100, height: 100)
    .matchedGeometryEffect(id: "box", in: namespace)
"""
    }
}

let LearningsSlide2 = Slide {
    Title("Learnings")

    Bullets {
        Words(".transition does not work on child views")
        Words(".transition only works immediately after condition")
    }
    Code(.swift) { """
/// ✅ This works
if show {
    Rectangle()
        .fill(.red)
        .frame(width: 100, height: 100)
        .transition(.scale)
}

/// ❌ This doesn't work
if show {
    VStack {
        Circle()
            .fill(.blue)
            .frame(width: 100, height: 100)

        Rectangle()
            .fill(.red)
            .frame(width: 100, height: 100)
            .transition(.scale) // ⚠️ may or may not work as expected
    }
}
"""
    }
}

let LearningsSlide3 = Slide {
    Title("Xcode Preview vs. Simulator")

    RawView {
        let url = Bundle.main.url(forResource: "Transition-Preview-Simulator.mov", withExtension: nil)!
        let player = AVPlayer(url: url)

        VideoPlayer(player: player)
            .aspectRatio(CGSize(width: 1784, height: 1122), contentMode: .fit)
            .frame(maxWidth: .infinity, alignment: .center)
            .task {
                player.play()
            }
    }
}
