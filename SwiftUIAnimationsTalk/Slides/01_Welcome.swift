import SwiftUI

struct WelcomeView: View {
    let title = Font.system(size: 80, weight: .bold, design: .default)
    let subtitle = Font.system(size: 70, weight: .light, design: .default).italic()

    @State private var animate = false
    @State private var name = "Netflix"

    var body: some View {
        VStack {
            Text("From zero to hero")
                .font(subtitle)

            HStack {
                Text("Create stunning animations in SwiftUI like ")

                Text(name)
                    .rotationEffect(.degrees(animate ? 360 : 0))
            }
            .font(title)
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .foregroundColor(.white)
        .contentShape(Rectangle())
        .onTapGesture {
            if animate {
                animate = false
                name = "Netflix"
                return
            }
            withAnimation(.linear(duration: 0.3).repeatCount(5, autoreverses: false)) {
                animate = true
            }
            withAnimation(.default.delay(1.0)) {
                name = "Joyn"
            }
        }
    }
}

struct WelcomeView_Previews: PreviewProvider {
    static var previews: some View {
        WelcomeView().previewSlide
    }
}
