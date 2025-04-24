//
//  ContentView.swift
//  RockPaperScissors
//
//  Created by Fazliddin Abdazimov on 11/04/25.
//

import SwiftUI

//Moving options to choose
enum Move: String, CaseIterable, Identifiable {
    case rock, paper, scissors
    
    var id: String { rawValue }
    
    var image: Image { Image(rawValue) }
}

//Rule of Game
enum Target: String, CaseIterable {
    case win, lose
}

struct ContentView: View {
    @State var computerAnswer = Move.allCases.randomElement()!
    @State var target = Target.allCases.randomElement()!
    @State var score: Int = 0
    
    var body: some View {
        ZStack {
            VStack {
                //Text to show player to win or lose
                StyledText(text: target == .win ? "Try To Beat Me" : "I'm Winning Now", textSize: .title2, textColor: Color("secondaryUserColor"), textWeight: .semibold)
                    .background(BackgroundRoundedRectangle(cornerRadius: 10, minwidth: 180, maxWidth: 200, minHeight: 40, maxHeight: 40))
                
                //Image to show the random chose of computer
                BackgroundRoundedRectangle(cornerRadius: 30, minwidth: 180, maxWidth: 200, minHeight: 180, maxHeight: 200)
                    .overlay(StyledImage(image: Image(computerAnswer.rawValue), width: 170, height: 170, cornerRadius: 20))
                
                //Section to show the score
                StyledText(text: "\(score)", textSize: .title2, textColor: Color("secondaryUserColor"), textWeight: .semibold)
                    .background(BackgroundRoundedRectangle(cornerRadius: 10, minwidth: 80, maxWidth: 100, minHeight: 40, maxHeight: 40))
                
                Spacer()
                
                //Section to show buttons that user chooses
                HStack() {
                    ForEach(Move.allCases) { move in
                        Spacer()
                        
                        Button {
                            playRound(player: move)
                        } label: {
                            StyledImage(image: move.image, width: 100, height: 100, cornerRadius: 20)
                        }
                        Spacer()
                    }
                }
                .background(BackgroundRoundedRectangle(cornerRadius: 30, minwidth: 320, maxWidth: .infinity, minHeight: 120, maxHeight: 130))
            }
        }
        .padding()
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(Color("secondaryUserColor"))
    }
    //Starting new round after tapping a button
    func playRound(player: Move) {
        let currentTarget = target
        let currentComputer = computerAnswer
        
        startGame(player, currentComputer, currentTarget, &score)
        
        target = Target.allCases.randomElement( )!
        computerAnswer = Move.allCases.randomElement()!
    }
}

#Preview {
    ContentView()
}

//Game Logic
func startGame(_ player: Move, _ computer: Move, _ target: Target, _ score: inout Int) {
    
    switch(player, computer, target) {
    case (.paper, .rock, .win),
        (.scissors, .paper, .win),
        (.rock, .scissors, .win),
        (.scissors, .rock, .lose),
        (.rock, .paper, .lose),
        (.paper, .scissors, .lose): score += 1
    default: score += 0
    }
}

//Background Rectangle
struct BackgroundRoundedRectangle: View {
    let cornerRadius: CGFloat
    let minwidth: CGFloat
    let maxWidth: CGFloat
    let minHeight: CGFloat
    let maxHeight: CGFloat
    
    var body: some View {
        RoundedRectangle(cornerRadius: cornerRadius)
            .frame(minWidth: minwidth, maxWidth: maxWidth, minHeight: minHeight, maxHeight: maxHeight)
            .foregroundStyle(Color("mainShapeColor"))
    }
}

//Styling Images
struct StyledImage: View {
    let image: Image
    let width: CGFloat
    let height: CGFloat
    let cornerRadius: CGFloat
    
    var body: some View {
        image
            .resizable()
            .frame(width: width, height: height)
            .clipShape(RoundedRectangle(cornerRadius: cornerRadius))
    }
}

struct StyledText: View {
    let text: String
    let textSize: Font
    let textColor: Color
    let textWeight: Font.Weight
    
    var body: some View {
        Text(text)
            .font(textSize)
            .foregroundColor(textColor)
            .fontWeight(textWeight)
            .padding()
    }
}
