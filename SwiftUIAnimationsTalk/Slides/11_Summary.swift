import SwiftUI
import DeckUI

let SummarySlide = Slide {
    RawView {
        SlideView()
    }
}

private struct SlideView: View {
    let bigFont: Font = .system(size: 100, weight: .semibold, design: .rounded)
    let smallFont: Font = .system(size: 25, weight: .semibold, design: .rounded)
    let middleFont: Font = .system(size: 55, weight: .semibold, design: .rounded)

    @State private var show1 = false
    @State private var show2 = false
    @State private var show3 = false
    @State private var show4 = false
    @State private var show5 = true
    @State private var show6 = false
    @State private var show7 = false
    @State private var show8 = false
    @State private var show9 = false

    var body: some View {
        VStack {
            Grid {
                GridRow {
                    box(show1) {
                        highlight("Up to", "5x", end: "faster than UIKit", hex: ["#2193b0", "#6dd5ed"])
                    }
                    box(show2) {
                        highlight("Up to", "3.5x", end: "more confusing", hex: ["#00F260", "#0575E6"])
                    }
                    box(show3) {
                        VStack {
                            Text("Easy to use")
                                .font(bigFont)
                                .foregroundStyle(LinearGradient(colors: [Color(hex: "#f7ff00"), Color(hex: "#db36a4")], startPoint: .topLeading, endPoint: .bottomTrailing))

                            Text("for simple use cases")
                                .font(smallFont)
                        }
                    }
                }
                GridRow {
                    box(show4) {
                        Text("Restricted support for earlier iOS versions")
                            .multilineTextAlignment(.center)
                            .font(middleFont)
                            .foregroundStyle(LinearGradient(colors: [Color(hex: "#659999"), Color(hex: "#f4791f")], startPoint: .topLeading, endPoint: .bottomTrailing))
                    }
                    box(show5) {
                        VStack {
                            Text("Animations in SwiftUI")
                                .font(.system(size: 70, weight: .semibold, design: .rounded))
                                .multilineTextAlignment(.center)
                                .padding(30)
                                .background {
                                    RoundedRectangle(cornerRadius: 20)
                                        .fill(.black.gradient)
                                }
                                .padding(20)
                                .background {
                                    let colors: [Color] = [.orange, .yellow, .green, .blue, .purple, .pink, .red]
                                    RoundedRectangle(cornerRadius: 20)
                                        .fill(AngularGradient(colors: colors, center: .center))
                                        .blur(radius: 10)
                                }
                        }
                    }
                    box(show6) {
                        highlight("Up to", "80%", end: "of results", hex: ["#544a7d", "#ffd452"])
                    }
                }
                GridRow {
                    box(show7) {
                        highlight("Up to", "2.5x", end: "less flexible", hex: ["#ED213A", "#93291E"])
                    }
                    box(show8) {
                        Text("Never trust Xcode Previews")
                            .multilineTextAlignment(.center)
                            .font(middleFont)
                            .foregroundStyle(LinearGradient(colors: [Color(hex: "#7F7FD5"), Color(hex: "#86A8E7"), Color(hex: "#91EAE4")], startPoint: .topLeading, endPoint: .bottomTrailing))
                    }
                    box(show9) {
                        highlight("In", "20%", end: "of the time", hex: ["#fdbb2d", "#b21f1f"])
                    }
                }
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity)

            Text("Numbers are fictitious")
                .italic()
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .contentShape(Rectangle())
        .onTapGesture {
            showNext += 1
            if showNext < showOrder.count {
                showOrder[showNext].wrappedValue = true
            }
        }
        .task {
            showOrder = [
                $show5,
                $show1,
                $show3,
                $show7,
                $show2,
                $show6,
                $show9,
                $show4,
                $show8
            ]
        }
    }

    @State private var showNext = 0
    @State private var showOrder: [Binding<Bool>] = []

    @ViewBuilder
    func highlight(_ first: String, _ highlight: String, end: String, hex: [String]) -> some View {
        VStack {
            Text(first)
                .font(smallFont)
            Text(highlight)
                .font(bigFont)
                .foregroundStyle(LinearGradient(colors: hex.map { Color(hex: $0) }, startPoint: .topLeading, endPoint: .bottomTrailing))
            Text(end)
                .font(smallFont)
        }
    }

    @ViewBuilder
    func box<Content: View>(_ isOn: Bool, @ViewBuilder content: () -> Content) -> some View {
        VStack {
            if isOn {
                content()
                    .transition(.scale.animation(.spring()))
            } else {
                Text("")
            }
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .padding()
        .background(.gray.opacity(0.2), in: RoundedRectangle(cornerRadius: 20))
    }
}
