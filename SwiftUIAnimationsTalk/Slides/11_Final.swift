import DeckUI
import SwiftUI

let FinalSlide = Slide {
    RawView {
        ThanksView()
    }
}

private struct ThanksView: View {
    @State private var status = false

    let activeTint = Color.purple
    let inactiveTint = Color.purple.opacity(0.8)

    let size: CGFloat = 75

    var body: some View {
        VStack {
            VStack(alignment: .leading) {
                HStack(spacing: 4) {
                    Text("Slidedeck fully written in ")
                    Text("Swift")
                        .italic()
                        .foregroundStyle(Color.orange.gradient)
                    Text(" with DeckUI")
                }
                Text("https://github.com/joshdholtz/DeckUI")
            }
            .font(.system(size: 25))
            .frame(maxWidth: .infinity, alignment: .leading)
            .padding(.top, 20)

            Spacer()

            HStack(spacing: 40) {
                Text("Thank you")
                    .font(.system(size: 70, weight: .semibold, design: .rounded))

                Image(systemName: "heart.fill")
                    .foregroundColor(status ? .pink : .pink.opacity(0.8))
                    .scaleEffect(status ? 1.0 : 0.8)
                    .font(.system(size: 50))
                    .particleEffect(
                        systemImage: "heart.fill",
                        font: .system(size: 50),
                        status: status,
                        activeTint: activeTint,
                        inActiveTint: inactiveTint
                    )
                    .particleEffectStyle(.circle(80...120))
                    .frame(width: 200)
            }

            Spacer()

            VStack() {
                Text("Inspired by")
                    .italic()
                    .font(.system(size: 25))

                HStack(alignment: .top, spacing: 20) {
                    Spacer()

                    VStack {
                        Image("kavsoft")
                            .resizable()
                            .frame(width: size, height: size)

                        Text("https://kavsoft.dev/\n")
                    }
                    .frame(width: 300)

                    Spacer()

                    VStack {
                        Image("holyswift")
                            .resizable()
                            .frame(width: size, height: size)

                        Text("https://holyswift.app\n")
                    }
                    .frame(width: 300)

                    Spacer()

                    VStack {
                        Image("objc")
                            .resizable()
                            .frame(width: size, height: size)
                            .clipShape(RoundedRectangle(cornerRadius: 16))

                        Text("https://www.objc.io\n")
                    }
                    .frame(width: 300)

                    Spacer()

                    VStack {
                        Image("getstream")
                            .resizable()
                            .frame(width: size, height: size)
                            .clipShape(RoundedRectangle(cornerRadius: 16))

                        Text("https://github.com/GetStream/swiftui-spring-animations\n")
                    }
                    .frame(width: 300)

                    Spacer()
                }
                .tint(.white)
                .font(.system(size: 20))

                Text("and a lot more ...")
                    .italic()
                    .font(.system(size: 25))
            }
            .foregroundColor(.white)
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .center)
        .task {
            repeat {
                try? await Task.sleep(for: .milliseconds(800))
                withAnimation {
                    status.toggle()
                }
            } while !Task.isCancelled
        }
    }
}

enum ParticleEffectStyle {
    case move(Direction)
    case circle(ClosedRange<Int>)

    enum Direction {
        case top
        case bottom
        case leading
        case trailing
    }
}

extension ParticleEffectStyle: EnvironmentKey {
    static var defaultValue: ParticleEffectStyle = .circle(15...30)
}

@available(iOS 13, tvOS 13, *)
extension EnvironmentValues {
    var particleEffectStyle: ParticleEffectStyle {
        get { self[ParticleEffectStyle.self] }
        set { self[ParticleEffectStyle.self] = newValue }
    }
}

@available(iOS 15, tvOS 15, *)
extension View {
    func particleEffect(systemImage: String, font: Font, status: Bool, activeTint: Color, inActiveTint: Color) -> some View {
        modifier(ParticleModifier(systemImage: systemImage, font: font, status: status, activeTint: activeTint, inactiveTint: inActiveTint))
    }

    func particleEffectStyle(_ style: ParticleEffectStyle) -> some View {
        environment(\.particleEffectStyle, style)
    }
}

@available(iOS 15, tvOS 15, *)
private struct Particle: Identifiable {
    var id: UUID = .init()
    var randomX: CGFloat = 0
    var randomY: CGFloat = 0
    var scale: CGFloat = 1

    var opacity: CGFloat = 0

    mutating func reset() {
        randomX = 0
        randomY = 0
        scale = 1
        opacity = 0
    }
}

@available(iOS 15, tvOS 15, *)
struct ParticleModifier: ViewModifier {
    var systemImage: String
    var font: Font
    var status: Bool
    var activeTint: Color
    var inactiveTint: Color

    @State private var particles: [Particle] = []
    @Environment(\.particleEffectStyle) private var style: ParticleEffectStyle

    private var numberParticles: Int {
        switch style {
        case .move:
            return 16
        case .circle:
            return 10
        }
    }

    func body(content: Content) -> some View {
        content
            .overlay(alignment: .top) {
                particleOverlay
                    .onAppear {
                        if particles.isEmpty {
                            for _ in 0 ..< numberParticles {
                                let particle = Particle()
                                particles.append(particle)
                            }
                        }
                    }
                    .onChange(of: status) { newValue in
                        if newValue {
                            showAndHideParticles()
                        } else {
                            for index in particles.indices {
                                particles[index].reset()
                            }
                        }
                    }
            }
    }

    @ViewBuilder private var particleOverlay: some View {
        ZStack {
            ForEach(particles) { particle in
                Image(systemName: systemImage)
                    .font(font)
                    .foregroundColor(status ? activeTint : inactiveTint)
                    .scaleEffect(particle.scale)
                    .offset(x: particle.randomX, y: particle.randomY)
                    .opacity(particle.opacity)
                    .opacity(status ? 1 : 0)
                    .animation(.none, value: status)
            }
        }
    }

    private func showAndHideParticles() {
        for index in particles.indices {
            let total: CGFloat = CGFloat(particles.count)
            let progress: CGFloat = CGFloat(index) / total

            let point: CGPoint
            switch style {
            case let .circle(radius):
                point = circlePosition(progress, radius: radius)
            case let .move(direction):
                point = movePosition(progress, direction: direction)
            }

            let randomScale: CGFloat = .random(in: 0.35 ... 1)

            particles[index].opacity = 1
            withAnimation(.interactiveSpring(response: 0.6, dampingFraction: 0.7, blendDuration: 0.7)) {
                particles[index].randomX = point.x
                particles[index].randomY = point.y
            }

            withAnimation(.easeInOut(duration: 0.3)) {
                particles[index].scale = randomScale
            }

            withAnimation(.interactiveSpring(response: 0.6, dampingFraction: 0.7, blendDuration: 0.7)
                .delay(0.25 + (Double(index) * 0.005))) {
                    particles[index].scale = 0.001
                }
        }
    }

    private func circlePosition(_ progress: CGFloat, radius radiusRange: ClosedRange<Int>) -> CGPoint {
        let angle = Angle(degrees: progress * 360).radians
        let radius: Int = .random(in: radiusRange)
        let posX = CGFloat(radius) * cos(angle)
        let posY = CGFloat(radius) * sin(angle)
        return .init(x: posX, y: posY)
    }

    private func movePosition(_ progress: CGFloat, direction: ParticleEffectStyle.Direction) -> CGPoint {
        let maxX: CGFloat = (progress > 0.5) ? 100 : -100
        let maxY: CGFloat = 60

        let randomX: CGFloat = ((progress > 0.5 ? progress - 0.5 : progress) * maxX)
        let randomY: CGFloat = ((progress > 0.5 ? progress - 0.5 : progress) * maxY) + 35

        let extraRandomX: CGFloat = (progress < 0.5 ? .random(in: 0 ... 10) : .random(in: -10 ... 0))
        let extraRandomY: CGFloat = .random(in: 0 ... 30)

        let posX = randomX + extraRandomX
        let posY = -randomY - extraRandomY

        let directionX: CGFloat
        let directionY: CGFloat

        switch direction {
        case .top:
            directionX = posX
            directionY = posY
        case .bottom:
            directionX = posX
            directionY = -posY
        case .leading:
            directionX = posY
            directionY = posX
        case .trailing:
            directionX = -posY
            directionY = posX
        }

        return .init(x: directionX, y: directionY)
    }
}
