import DeckUI
import SwiftUI

@main
struct SwiftUIAnimationsTalkApp: App {
    var body: some Scene {
        WindowGroup {
            Presenter(deck: deck)
                .foregroundColor(.white)
        }
    }

    private var deck: Deck {
        Deck(title: "From zero to hero: Create stunning animations in SwiftUI like Netflix") {
            WelcomeView().slide()

            WhoAmISlide

            NetflixAppSlide

            Slide {
                Title("Stream Seeker")

                RawView {
                    HStack {
                        Spacer()
                        Media(.assetImage("streamseeker")).buildView(theme: .dark)
                        Spacer()
                    }
                }
            }

            StreamSeekerIntroDemoSlide

            AnimationsInSwiftUIDoku
            AnimationsInSwiftUIExampleWithout
            AnimationsInSwiftUIExampleWith
            AnimationsInSwiftUIValues

            TransitionsInSwiftUIDoku
            TransitionExampleSlide

            LiveCodingProfileSelection

            MatchedGeometryEffectDoku
            MatchedGeometryEffectExampleSlide
            MatchedGeometryEffectExampleSlowSlide
            MatchedGeometryEffectTransitionSlide
            ProfileTransitionSlide
            CustomTransitionsSlide

            LearningsSlide1
            LearningsSlide2
            LearningsSlide3

            HeroSlide

            SummarySlide

            FinalSlide
        }
    }
}
