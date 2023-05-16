import SwiftUI
import DeckUI

let TransitionsInSwiftUIDoku = Slide {
    Title("Transitions in SwiftUI")

    Columns {
        Column {
            Documentation("transition(_:)",
                          description: "Associates a transition with the view.",
                          code: """
func transition(_ t: AnyTransition) -> some View

// MARK: - example of build-in transitions

static let identity: AnyTransition
static let opacity: AnyTransition
static var scale: AnyTransition
static var slide: AnyTransition
static func move(edge: Edge) -> AnyTransition
static func offset(x: CGFloat, y: CGFloat) -> AnyTransition
"""
            )
        }
        Column {
            RawView {
                Group {
                    Words("Example", font: .system(size: 40, weight: .semibold, design: .default)).buildView(theme: .dark)
                    Code(.swift) {
"""
struct Example: View {
    @Binding var showBox: Bool
    var body: some View {
        VStack {
            if showBox {
                Rectangle()
                    .transition(.opacity)
            }
        }
        .animation(.default, value: showBox)
    }
}

struct Example: View {
    @Binding var showBox: Bool
    var body: some View {
        VStack {
            if showBox {
                Rectangle()
                    .transition(.opacity.animation(.default))
            }
        }
    }
}
"""
                    }.buildView(theme: .dark)
                }
                .padding(.leading, 20)
            }
        }
    }
}

let TransitionExampleSlide = Slide(transition: .opacity) {
    RawView {
        CodeAndPreview {
            ExampleCode
        } content: {
            ExampleView()
        }
    }
}

private let ExampleCode: String = """
private struct ExampleView: View {
    @State var show = false

    var body: some View {
        VStack {
            if show {
                Rectangle()
                    .fill(.blue)
                    .frame(width: 100, height: 100)
                    .transition(.opacity.animation(.default.speed(0.3)))

                Rectangle()
                    .fill(.red)
                    .frame(width: 100, height: 100)
                    .transition(.scale.animation(.default.speed(0.3)))

                Rectangle()
                    .fill(.green)
                    .frame(width: 100, height: 100)
                    .transition(
                        .opacity
                            .combined(with: .scale(scale: 2, anchor: .leading))
                            .animation(.default.speed(0.3))
                    )
            }
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .overlay(alignment: .topLeading) {
            Toggle("Transition", isOn: $show)
                .toggleStyle(.switch)
                .foregroundColor(.black)
                .padding()
                .frame(maxWidth: .infinity)
                .background(.purple.opacity(0.3))
        }
    }
}
"""

private struct ExampleView: View {
    @State var show = true

    var body: some View {
        VStack {
            if show {
                Rectangle()
                    .fill(.blue)
                    .frame(width: 100, height: 100)
                    .transition(.opacity.animation(.default.speed(0.3)))

                Rectangle()
                    .fill(.red)
                    .frame(width: 100, height: 100)
                    .transition(.scale.animation(.default.speed(0.3)))

                Rectangle()
                    .fill(.green)
                    .frame(width: 100, height: 100)
                    .transition(
                        .opacity
                            .combined(with: .scale(scale: 2, anchor: .leading))
                            .animation(.default.speed(0.3))
                    )
            }
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .overlay(alignment: .topLeading) {
            Toggle("Transition", isOn: $show)
                .toggleStyle(.switch)
                .foregroundColor(.black)
                .padding()
                .frame(maxWidth: .infinity)
                .background(.purple.opacity(0.3))
        }
        .task {
            repeat {
                try? await Task.sleep(for: .seconds(2))
                show.toggle()
            } while !Task.isCancelled
        }
    }
}
