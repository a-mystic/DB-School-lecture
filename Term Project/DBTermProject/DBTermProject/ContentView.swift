//
//  ContentView.swift
//  DBTermProject
//
//  Created by a mystic on 10/29/23.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        ZStack {
            Color.gray
                .opacity(0.1)
                .ignoresSafeArea(edges: .bottom)
            VStack {
                Spacer()
                dropBox
                Spacer()
                sqlSlider
            }
        }
    }
    
    private var dropBox: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 14)
                .foregroundStyle(.black.opacity(0.5))
//                .frame(width: 300, height: 300)
            VStack(spacing: 30) {
                Image(systemName: "rectangle.and.hand.point.up.left.filled")
                    .imageScale(.large)
                    .font(.largeTitle)
                Text("Drop your sql command")
            }
            .foregroundStyle(.white.opacity(0.8))
            droppedCommandsList
        }
        .dropDestination(for: String.self) { items, location in
            drop(items)
        }
    }
    
    private func drop(_ items: [String]) -> Bool {
        return true
    }
    
    @State private var commands: [String] = [""]
    
    private var droppedCommandsList: some View {
        VStack(spacing: 10) {
            Spacer()
                .frame(height: 10)
            HStack {
                Text("Select")
                TextField("SQL명령어를 입력해주세요", text: $commands[0])
                    .textFieldStyle(.roundedBorder)
            }
            .padding(.horizontal)
            Spacer()
        }
    }
    
    private let sqlCommands = ["Select", "Insert", "From", "Where", "Order by", "Join"]
    
    private var sqlSlider: some View {
        ScrollView(.horizontal) {
            HStack {
                ForEach(sqlCommands, id: \.self) { sql in
                    Text(sql)
                        .font(.system(size: 15))
                        .padding()
                        .border(.black)
                        .clipShape(RoundedRectangle(cornerRadius: 3))
                        .draggable(sql)
                }
            }
            .padding(.horizontal)
        }
    }
}

#Preview {
    ContentView()
}
