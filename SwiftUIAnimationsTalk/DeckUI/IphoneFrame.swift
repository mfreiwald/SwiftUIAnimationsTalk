import SwiftUI

public struct IphoneFrame<Content>: View where Content: View {
    @ViewBuilder var content: () -> Content

    public init(_ content: @escaping () -> Content) {
        self.content = content
    }

    let iphone14Pro: CGSize = .init(width: 393.0, height: 852.0)

    public var body: some View {
            VStack {
                content()
                    .padding(.top, 56)
            }
            .frame(
                width: iphone14Pro.width,
                height: iphone14Pro.height
            )
            .overlay(alignment: .top) {
                RoundedRectangle(cornerRadius: 20, style: .circular)
                    .fill(Color.black)
                    .frame(width: 120, height: 40)
                    .padding(.top, 20)
            }
            .padding(5)
            .background {
                Color.white
                    .clipShape(RoundedRectangle(cornerRadius: 50, style: .continuous))
            }
            .overlay {
                RoundedRectangle(cornerRadius: 50, style: .continuous)
                    .stroke(.black.opacity(1), lineWidth: 10)
            }
    }
}

struct IphoneFrame_Previews: PreviewProvider {
    static var previews: some View {
        IphoneFrame() {
            Text("asdfasdf")
                .frame(maxWidth: .infinity, maxHeight: .infinity)
                .border(.red)
                .background(.red)
        }
        .frame(width: 1080, height: 1920)
    }
}
