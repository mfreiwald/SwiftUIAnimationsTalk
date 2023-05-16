import DeckUI
import SwiftUI

struct CodeAndPreview<Content>: View where Content: View {
    var text: () -> String
    @ViewBuilder var content: () -> Content

    @Environment(\.theme) var theme

    var body: some View {
        HStack {
            Code(.swift, enableHighlight: true, text: text).buildView(theme: theme)
            
            Spacer()

            DevicePreview(content: content)
        }
    }
}

struct DevicePreview<Content>: View where Content: View {
    @ViewBuilder var content: () -> Content

    var body: some View {
        IphoneFrame(content)
    }
}
