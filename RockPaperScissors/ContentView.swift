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
enum Target {
    case win, lose
}

struct ContentView: View {
    @State var computerAnswer = Move.allCases.randomElement()
    
    var body: some View {
        ZStack {
            VStack {
                BackgroundRoundedRectangle(cornerRadius: 30, minwidth: 180, maxWidth: 200, minHeight: 180, maxHeight: 200)
                    .overlay(StyledImage(image: Image(computerAnswer?.rawValue ?? Move.rock.rawValue), width: 170, height: 170, cornerRadius: 20))
                
                Spacer()
                
                HStack() {
                    ForEach(Move.allCases, id: \.self) { move in
                        Spacer()
                        
                        Button {
                            let playerAnswer = move
                            
                            startGame(playerAnswer, computerAnswer ?? Move.rock)
                            
                            computerAnswer = Move.allCases.randomElement()
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
        .background(Color("background"))
    }
}

#Preview {
    ContentView()
}

//Game Logic
func startGame(_ player: Move, _ computer: Move) {
    switch(player, computer) {
    case let (player, computer) where player == computer: print("draw")
    case (.rock, .scissors),
        (.scissors, .paper),
        (.paper, .rock): print("player wins")
    default : print("computer wins")
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
