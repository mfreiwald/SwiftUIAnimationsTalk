import DeckUI
import SwiftUI

let MatchedGeometryEffectExampleSlide = Slide(transition: .opacity) {
    RawView {
        CodeAndPreview {
            ExampleCode
        } content: {
            ExampleView()
        }
    }
}

let MatchedGeometryEffectExampleSlowSlide = Slide(transition: .opacity) {
    RawView {
        CodeAndPreview {
            ExampleCode
        } content: {
            ExampleViewSlow()
        }
    }
}

private let ExampleCode = """
struct ExampleView: View {
    @State var onTop: Bool = true
    @Namespace private var namespace

    var body: some View {
        VStack {
            if onTop {
                VStack {
                    Rectangle()
                        .fill(.red)
                        .matchedGeometryEffect(id: "box", in: namespace)
                        .frame(width: 100, height: 100)
                }
                .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .topLeading)
            } else {
                VStack {
                    Circle()
                        .fill(.blue)
                        .matchedGeometryEffect(id: "box", in: namespace)
                        .frame(width: 100, height: 100)
                }
                .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .bottomTrailing)
            }
        }
        .animation(.default, value: onTop)
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .overlay(alignment: .topLeading) {
            Toggle("Box on Top", isOn: $onTop)
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
    @State var onTop: Bool = true
    @Namespace private var namespace

    var body: some View {
        VStack {
            if onTop {
                VStack {
                    Rectangle()
                        .fill(.red)
                        .matchedGeometryEffect(id: "box", in: namespace)
                        .frame(width: 100, height: 100)
                        .padding(.top, 60)
                }
                .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .topLeading)
            } else {
                VStack {
                    Circle()
                        .fill(.blue)
                        .matchedGeometryEffect(id: "box", in: namespace)
                        .frame(width: 100, height: 100)
                        .padding(.bottom, 40)
                        .padding(.trailing, 5)
                }
                .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .bottomTrailing)
            }
        }
        .animation(.default, value: onTop)
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .overlay(alignment: .topLeading) {
            Toggle("Box on Top", isOn: $onTop)
                .toggleStyle(.switch)
                .foregroundColor(.black)
                .padding()
                .frame(maxWidth: .infinity)
                .background(.purple.opacity(0.3))
        }
        .task {
            repeat {
                try? await Task.sleep(for: .seconds(2))
                onTop.toggle()
            } while !Task.isCancelled
        }
    }
}

private struct ExampleViewSlow: View {
    @State var onTop: Bool = true
    @Namespace private var namespace

    var body: some View {
        VStack {
            if onTop {
                VStack {
                    Rectangle()
                        .fill(.red)
                        .matchedGeometryEffect(id: "box", in: namespace)
                        .frame(width: 100, height: 100)
                        .padding(.top, 60)
                }
                .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .topLeading)
            } else {
                VStack {
                    Circle()
                        .fill(.blue)
                        .matchedGeometryEffect(id: "box", in: namespace)
                        .frame(width: 100, height: 100)
                        .padding(.bottom, 40)
                        .padding(.trailing, 5)
                }
                .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .bottomTrailing)
            }
        }
        .animation(.default.speed(0.2), value: onTop)
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .overlay(alignment: .topLeading) {
            Toggle("Box on Top (Slow Mode)", isOn: $onTop)
                .toggleStyle(.switch)
                .foregroundColor(.black)
                .padding()
                .frame(maxWidth: .infinity)
                .background(.purple.opacity(0.3))
        }
        .task {
            repeat {
                onTop.toggle()
                try? await Task.sleep(for: .seconds(4))
            } while !Task.isCancelled
        }
    }
}
