import DeckUI
import SwiftUI
import AVKit

let MatchedGeometryEffectTransitionSlide = Slide {
    RawView {
        let url = Bundle.main.url(forResource: "Livecoding-Move.mov", withExtension: nil)!
        let player: AVPlayer = {
            let player = AVPlayer(url: url)
            player.defaultRate = 1.5
            return player
        }()

        VideoPlayer(player: player)
            .aspectRatio(CGSize(width: 2730, height: 1884), contentMode: .fit)
            .frame(maxWidth: .infinity, alignment: .center)
            .task {
                player.play()
            }
    }
}

let ProfileTransitionSlide = Slide {
    RawView {
        let url = Bundle.main.url(forResource: "ProfileLoadingCompareNetflix.mov", withExtension: nil)!
        let player = AVPlayer(url: url)

        VideoPlayer(player: player)
            .aspectRatio(CGSize(width: 1180, height: 1278), contentMode: .fit)
            .frame(maxWidth: .infinity, alignment: .center)
            .task {
                try? await Task.sleep(for: .seconds(1))
                player.play()
            }

    }
}


let CustomTransitionsSlide = Slide {
    RawView {
        HStack {
            Code(.swift) {
"""
private extension AnyTransition {
    static var curve: Self {
        .modifier(
            active: CurveModifier(value: -1),
            identity: CurveModifier(value: 1)
        )
    }

    private struct CurveModifier: AnimatableModifier {
        var value: CGFloat
        var offset: CGFloat = 80

        var animatableData: CGFloat {
            get { value }
            set { value = newValue }
        }

        func body(content: Content) -> some View {
            let offsetX = offset + -offset * pow(value, 2)
            content
                .offset(x: -offsetX)
        }
    }

    static var wave: Self {
        .modifier(
            active: WaveModifier(value: 0),
            identity: WaveModifier(value: 360)
        )
    }

    private struct WaveModifier: AnimatableModifier {
        var value: CGFloat

        var animatableData: CGFloat {
            get { value }
            set { value = newValue }
        }

        func body(content: Content) -> some View {
            let y: CGFloat = sin(Angle(degrees: value).radians * 2)
            content
                .offset(x: y * 50)
        }
    }
}

"""
            }.buildView(theme: .dark)

            Spacer()

            Container()
                .frame(width: 800)

        }
    }
}

private struct Container: View {
    @State private var speed: CGFloat = 2.0
    var duration: Duration {
        .seconds(speed)
    }

    var body: some View {
        VStack(spacing: 20) {
            HStack(spacing: 30) {
                Text("Duration: \(Int(speed)) seconds")
                    .font(.system(size: 20))
                Slider(value: $speed, in: 1.0 ... 4.0, step: 1.0)
            }

            CustomTransitionsView(speed: speed)
                .id(speed)
                .background(Color.white, in: RoundedRectangle(cornerRadius: 20))
        }
    }
}

private struct CustomTransitionsView: View {
    let speed: CGFloat
    @State private var move = false
    @Namespace private var namespace

    var body: some View {
        HStack {
            Spacer()
            movingBox(id: "opacity", .opacity)
            Spacer()
            movingBox(id: "scale", .scale)
            Spacer()
            movingBox(id: "curve", .curve)
            Spacer()
            movingBox(id: "wave", .wave)
            Spacer()
        }
        .padding(.horizontal, 10)
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .animation(.linear(duration: speed), value: move)
        .task {
            repeat {
                try? await Task.sleep(for: .milliseconds(300))
                move.toggle()
                try? await Task.sleep(for: .seconds(speed + 0.5))
            } while !Task.isCancelled
        }
    }

    @ViewBuilder
    func movingBox(id: String, _ transition: AnyTransition) -> some View {
        VStack {
            Text(id)
                .foregroundColor(.black)
                .font(.system(size: 20))
                .padding(.top, 10)

            if move {
                Circle()
                    .fill(.blue)
                    .matchedGeometryEffect(id: id, in: namespace)
                    .transition(transition)
                    .frame(width: 50)
                    .frame(maxHeight: .infinity, alignment: .bottom)
                    .padding(.bottom, 20)
            } else {
                Circle()
                    .fill(.red)
                    .matchedGeometryEffect(id: id, in: namespace)
                    .transition(transition)
                    .frame(width: 50)
                    .frame(maxHeight: .infinity, alignment: .top)
            }
        }
        .background {
            Color.gray
                .frame(width: 4)
                .frame(maxHeight: .infinity)
                .padding(.top, 40)
        }
    }
}

private extension AnyTransition {
    static var curve: Self {
        .modifier(
            active: CurveModifier(value: -1),
            identity: CurveModifier(value: 1)
        )
    }

    private struct CurveModifier: AnimatableModifier {
        var value: CGFloat
        var offset: CGFloat = 80

        var animatableData: CGFloat {
            get { value }
            set { value = newValue }
        }

        func body(content: Content) -> some View {
            let offsetX = offset + -offset * pow(value, 2)
            content
                .offset(x: -offsetX)
        }
    }

    static var wave: Self {
        .modifier(
            active: WaveModifier(value: 0),
            identity: WaveModifier(value: 360)
        )
    }
    
    private struct WaveModifier: AnimatableModifier {
        var value: CGFloat

        var animatableData: CGFloat {
            get { value }
            set { value = newValue }
        }

        func body(content: Content) -> some View {
            let y: CGFloat = sin(Angle(degrees: value).radians * 2)
            content
                .offset(x: y * 50)
        }
    }
}
