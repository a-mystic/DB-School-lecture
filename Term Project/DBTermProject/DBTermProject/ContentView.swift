//
//  ContentView.swift
//  DBTermProject
//
//  Created by a mystic on 10/29/23.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        NavigationStack {
            ZStack {
                Color.gray
                    .opacity(0.1)
                    .ignoresSafeArea(edges: .bottom)
                VStack(spacing: 30) {
                    dropBox
                    Spacer()
                }
                .frame(height: 500)
                VStack {
                    Spacer()
                    sqlSlider
                }
            }
            .navigationBarTitleDisplayMode(.inline)
            .navigationTitle("데이터베이스시스템")
            .toolbar {
                ToolbarItem(placement: .topBarTrailing) {
                    run
                }
            }
            .toolbar {
                ToolbarItem(placement: .topBarLeading) {
                    erase
                }
            }
        }
    }
    
    private var dropBox: some View {
        ZStack {
            Color.black
                .opacity(0.5)
                .ignoresSafeArea(edges: .bottom)
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
        if let item = items.first {
            selectedSqlCommands.append(item)
            commands.append("")
        }
        return true
    }
    
    @State private var commands: [String] = []
    @State private var selectedSqlCommands: [String] = []
    
    private var droppedCommandsList: some View {
        VStack(spacing: 10) {
            Spacer()
                .frame(height: 10)
            ForEach(selectedSqlCommands.indices, id: \.self) { index in
                HStack {
                    Text(selectedSqlCommands[index]).bold()
                    TextField("SQL명령어를 입력해주세요", text: $commands[index])
                        .textFieldStyle(.roundedBorder)
                }
                .padding(.horizontal)
            }
            Spacer()
        }
    }
    
    private var run: some View {
        Button {
            running()
        } label: {
            Image(systemName: "arrowtriangle.right.fill")
        }
    }
    
    private func running() {
        var command = ""
        for index in selectedSqlCommands.indices {
            command += selectedSqlCommands[index] + " " + commands[index] + " "
        }
        print(command)
    }
    
    private var erase: some View {
        Button {
            commands = []
            selectedSqlCommands = []
        } label: {
            Image(systemName: "eraser.fill")
        }
    }
    
    private let sqlCommands = ["Select", "Insert", "From", "Where", "Order by", "Join", "Into"]
    
    private var sqlSlider: some View {
        ScrollView(.horizontal) {
            HStack {
                ForEach(sqlCommands, id: \.self) { sql in
                    ZStack {
                        Text(sql)
                            .foregroundStyle(.white)
                            .font(.system(size: 15))
                            .padding()
                            .background {
                                RoundedRectangle(cornerRadius: 14)
                                    .fill(.blue.opacity(0.9))
                            }
                    }
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
