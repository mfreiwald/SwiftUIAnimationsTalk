import DeckUI
import SwiftUI

public struct Documentation: ContentItem {
    public let id = UUID()
    let title: String
    let description: String
    let code: String
    let example: String?

    public init(_ title: String, description: String, code: String, example: String? = nil) {
        self.title = title
        self.description = description
        self.code = code
        self.example = example
    }

    public func buildView(theme: Theme) -> AnyView {
        return AnyView(
            VStack(alignment: .leading, spacing: 20) {
                VStack(alignment: .leading, spacing: 8) {
                    Text(self.title)
                        .font(.system(size: 50, weight: .bold, design: .default))
                    
                    Text(description)
                        .font(.system(size: 30, weight: .regular, design: .default))
                }

                Divider()

                Text("Declaration")
                    .font(.system(size: 40, weight: .semibold, design: .default))

                Code(.swift, enableHighlight: true) {
                    code
                }
                .buildView(theme: theme)
                .padding()
                .background(.white.opacity(0.1), in: RoundedRectangle(cornerRadius: 16))

                if let example {
                    Text("Example")
                        .font(.system(size: 40, weight: .semibold, design: .default))

                    Code(.swift, enableHighlight: true) {
                        example
                    }
                    .buildView(theme: theme)
                    .padding()
                    .background(.white.opacity(0.1), in: RoundedRectangle(cornerRadius: 16))
                }
            }
                .foregroundColor(.white)
                .padding(.bottom, 20)
        )
    }
}

