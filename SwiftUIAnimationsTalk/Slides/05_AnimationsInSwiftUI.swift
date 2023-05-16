import SwiftUI
import DeckUI

let AnimationsInSwiftUIDoku = Slide {
    Title("Animations in SwiftUI")

    Columns {
        Column {
            Documentation("animation(_:value)",
                          description: "Applies the given animation to this view when the specified value changes.",
                          code: """
func animation<V>(
    _ animation: Animation?,
    value: V
) -> some View where V : Equatable
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
            }
        }
        .animation(.default, value: showBox)
    }
}
"""
                    }.buildView(theme: .dark)
                }
                .padding(.leading, 80)
            }
        }
    }
}

let AnimationsInSwiftUIExampleWithout = Slide(transition: .opacity) {
    RawView {
        CodeAndPreview {
            ExampleWithoutAnimationCode
        } content: {
            ExampleWithoutAnimation()
        }
    }
}

let AnimationsInSwiftUIExampleWith = Slide(transition: .opacity) {
    RawView {
        CodeAndPreview {
            ExampleWithAnimationCode
        } content: {
            ExampleWithAnimation()
        }
    }
}

let AnimationsInSwiftUIValues = Slide(transition: .opacity) {
    RawView {
        CodeAndPreview {
            AnimationCode
        } content: {
            AnimationView()
        }
    }
}

let ExampleWithoutAnimationCode = """
struct Example: View {
    @State var show = false

    var body: some View {
        VStack {
            Rectangle()
                .fill(.blue)
                .frame(width: 100, height: 100)

            if show {
                Rectangle()
                    .fill(.red)
                    .frame(width: 100, height: 100)
            }

            Rectangle()
                .fill(.green)
                .frame(width: 100, height: 100)
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .overlay(alignment: .topLeading) {
            Toggle("Show Red Box without Animation", isOn: $show)
                .toggleStyle(.switch)
                .foregroundColor(.black)
                .padding()
        }
    }
}
"""

private struct ExampleWithoutAnimation: View {
    @State var show = false

    var body: some View {
        VStack {
            Rectangle()
                .fill(.blue)
                .frame(width: 100, height: 100)

            if show {
                Rectangle()
                    .fill(.red)
                    .frame(width: 100, height: 100)
            }

            Rectangle()
                .fill(.green)
                .frame(width: 100, height: 100)
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .overlay(alignment: .topLeading) {
            Toggle("Show Red Box without Animation", isOn: $show)
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

let ExampleWithAnimationCode = """
struct Example: View {
    @State var show = false

    var body: some View {
        VStack {
            Rectangle()
                .fill(.blue)
                .frame(width: 100, height: 100)

            if show {
                Rectangle()
                    .fill(.red)
                    .frame(width: 100, height: 100)
            }

            Rectangle()
                .fill(.green)
                .frame(width: 100, height: 100)
        }
        .animation(.default, value: show) // <-- only one line added!
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .overlay(alignment: .topLeading) {
            Toggle("Show Red Box with Animation", isOn: $show)
                .toggleStyle(.switch)
                .foregroundColor(.black)
                .padding()
        }
    }
}
"""
private struct ExampleWithAnimation: View {
    @State var show = false

    var body: some View {
        VStack {
            Rectangle()
                .fill(.blue)
                .frame(width: 100, height: 100)

            if show {
                Rectangle()
                    .fill(.red)
                    .frame(width: 100, height: 100)
            }

            Rectangle()
                .fill(.green)
                .frame(width: 100, height: 100)
        }
        .animation(.default, value: show)
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .overlay(alignment: .topLeading) {
            Toggle("Show Red Box with Animation", isOn: $show)
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

let AnimationCode = """
struct AnimationView: View {
    @State var animate = false

    var body: some View {
        VStack {
            Rectangle()
                .fill(.blue)
                .frame(width: 100, height: 100)
                .scaleEffect(animate ? 0.7 : 1.0)

            Rectangle()
                .fill(.red)
                .frame(width: 100, height: 100)
                .rotationEffect(.degrees(animate ? 90 : 0))

            Rectangle()
                .fill(.green)
                .frame(width: animate ? 200 : 100, height: 100)
        }
        .animation(.default, value: animate)
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .overlay(alignment: .topLeading) {
            Toggle("Animation", isOn: $animate)
                .toggleStyle(.switch)
                .foregroundColor(.black)
                .padding()
                .frame(maxWidth: .infinity)
                .background(.purple.opacity(0.3))
        }
    }
}
"""

struct AnimationView: View {
    @State var notAnimate = false
    @State var animate = false

    var body: some View {
        VStack {
            VStack {
                Rectangle()
                    .fill(.blue)
                    .frame(width: 100, height: 100)
                    .scaleEffect(notAnimate ? 0.7 : 1.0)

                Rectangle()
                    .fill(.red)
                    .frame(width: 100, height: 100)
                    .rotationEffect(.degrees(notAnimate ? 90 : 0))

                Rectangle()
                    .fill(.green)
                    .frame(width: notAnimate ? 200 : 100, height: 100)
            }

            Color.gray
                .frame(height: 4)
                .frame(maxWidth: .infinity)
                .cornerRadius(2)
                .padding()

            VStack {
                Rectangle()
                    .fill(.blue)
                    .frame(width: 100, height: 100)
                    .scaleEffect(animate ? 0.7 : 1.0)

                Rectangle()
                    .fill(.red)
                    .frame(width: 100, height: 100)
                    .rotationEffect(.degrees(animate ? 90 : 0))

                Rectangle()
                    .fill(.green)
                    .frame(width: animate ? 200 : 100, height: 100)
            }
            .animation(.default, value: animate)
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .overlay(alignment: .topLeading) {
            Toggle("Animation", isOn: .init(get: {
                animate && notAnimate
            }, set: {
                animate = $0
                notAnimate = $0
            }))
                .toggleStyle(.switch)
                .foregroundColor(.black)
                .padding()
                .frame(maxWidth: .infinity)
                .background(.purple.opacity(0.3))
        }
        .task {
            repeat {
                try? await Task.sleep(for: .seconds(2))
                notAnimate.toggle()
                animate.toggle()
            } while !Task.isCancelled
        }
    }
}
