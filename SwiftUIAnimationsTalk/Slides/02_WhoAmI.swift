import DeckUI
import SwiftUI

let WhoAmISlide = Slide {
    let hSpacing: CGFloat = 20
    Title("About me")
    Columns {
        Column {
            RawView {
                VStack(alignment: .leading, spacing: 40) {
                    HStack(spacing: hSpacing) {
                        Text("👨‍💻")

                        Text("Michael Freiwald")
                    }

                    HStack(spacing: hSpacing) {
                        Text("👨‍💻")
                            .hidden()
                            .overlay {
                                Image("netlight")
                                    .resizable()
                                    .scaledToFit()
                            }

                        Text("IT-Consultant @ \(Text("Netlight").italic().foregroundColor(.purple))")
                    }

                    HStack(spacing: hSpacing) {
                        Text("👨‍💻")
                            .hidden()
                            .overlay {
                                Image("swift")
                                    .resizable()
                                    .scaledToFit()
                            }

                        HStack(spacing: 4) {
                            Text("In love with ")
                            Text("Swift")
                                .italic()
                                .foregroundStyle(Color.orange.gradient)
                            Text(" & ")
                            Text("SwiftUI")
                                .italic()
                                .foregroundStyle(Color.blue.gradient)
                        }

                    }

                    HStack(spacing: hSpacing) {
                        RotatingSwift()

                        Text("Enjoy making animations")
                    }
                }
                .apply(\.body)
                .font(.system(size: 50))
            }
        }
        Column {
            
        }
    }
}

private struct RotatingSwift: View {
    @State var animate = false
    var body: some View {
        Text("🥰")
            .scaleEffect(animate ? 1.2 : 0.8)
            .onAppear {
                withAnimation(.easeInOut.speed(0.6).repeatForever(autoreverses: true)) {
                    animate = true
                }
            }
    }
}

struct WhoAmI: View {
    let theme = Theme.dark
    var body: some View {
        VStack {
            Text("About me")
                .font(theme.title.font)
        }
        .font(theme.body.font)
        .foregroundColor(theme.body.color)
    }
}

struct WhoAmI_Previews: PreviewProvider {
    static var previews: some View {
        WhoAmISlide.buildView(theme: .dark)
    }
}
