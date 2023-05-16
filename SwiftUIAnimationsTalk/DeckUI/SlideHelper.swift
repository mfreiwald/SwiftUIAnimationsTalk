import DeckUI
import SwiftUI

extension View {
    func slide(alignment: Alignment = .topLeading, padding: CGFloat = 40, comment: String? = nil, theme: Theme? = nil, transition: SlideTransition? = nil) -> Slide {
        Slide(alignment: alignment, padding: padding, comment: comment, theme: theme, transition: transition) {
            RawView {
                self
            }
        }
    }
}

extension View {
    var previewSlide: some View {
        Presenter(deck: Deck(title: "Preview", slides: {
           self.slide()
        }))
    }
}

struct ForegroundStyleViewModifier: ViewModifier {
    let foreground: KeyPath<Theme, Foreground>
    @Environment(\.theme) private var theme

    func body(content: Content) -> some View {
        content
            .foregroundColor(theme[keyPath: foreground].color)
            .font(theme[keyPath: foreground].font)
    }
}
extension View {
    func apply(_ foreground: KeyPath<Theme, Foreground>) -> some View {
        modifier(ForegroundStyleViewModifier(foreground: foreground))
    }
}

extension Theme: EnvironmentKey {
    public static var defaultValue: Theme = .dark
}

extension EnvironmentValues {
    public var theme: Theme {
        get { self[Theme.self] }
        set { self[Theme.self] = newValue }
    }
}

