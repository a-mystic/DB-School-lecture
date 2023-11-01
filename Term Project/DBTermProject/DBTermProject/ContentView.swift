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
                VStack(spacing: 10) {
                    dropBox
                    Spacer()
                    result
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
                ToolbarItem(placement: .topBarLeading) {
                    HStack {
                        erase
                        run
                    }
                }
                ToolbarItem(placement: .topBarTrailing) {
                    question
                }
            }
            .navigationDestination(isPresented: $showResult) {
                ResultView(resultValue)
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
    
    @State private var showResult = false
    
    private var result: some View {
        Button("Watch result") {
            showResult = true
        }
        .buttonStyle(.borderedProminent)
    }
    
    @State private var commands: [String] = []
    @State private var selectedSqlCommands: [String] = []
    
    private var droppedCommandsList: some View {
        VStack(spacing: 10) {
            Spacer()
                .frame(height: 10)
            ForEach(selectedSqlCommands.indices, id: \.self) { index in
                HStack {
                    Text(selectedSqlCommands[index])
                        .bold()
                        .padding(.horizontal)
                        .background(
                            RoundedRectangle(cornerRadius: 4)
                                .fill(.brown)
                        )
                    TextField("SQL명령어를 입력해주세요", text: $commands[index])
                        .textFieldStyle(.roundedBorder)
                        .textInputAutocapitalization(.never)
                        .autocorrectionDisabled()
                }
                .padding(.horizontal)
            }
            Spacer()
        }
    }
    
    private var run: some View {
        Button {
            Task {
                await running()
            }
        } label: {
            Image(systemName: "arrowtriangle.right.fill")
        }
    }
    
    @State private var resultValue = ""
    
    private func running() async {
        var command = ""
        for index in selectedSqlCommands.indices {
            command += selectedSqlCommands[index] + " " + commands[index] + " "
        }
//        print(command)  // replace post api request to server
        if let encodingCommand = command.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) {
            let url = "url/" + chooseApiCall(selectedSqlCommands[0]) + "?command=" + encodingCommand
            guard let url = URL(string: url) else { return }
            do {
                let (data, _) = try await URLSession.shared.data(from: url)
                let returnValue = try JSONDecoder().decode(String.self, from: data)
                resultValue = returnValue
            } catch {
                print(error)
            }
        }
    }
    
    private func chooseApiCall(_ command: String) -> String {
        if command == "Select" {
            return "select"
        } else if command == "Insert" {
            return "insert"
        } else {
            return "delete"
        }
    }
    
    private var erase: some View {
        Button {
            commands = []
            selectedSqlCommands = []
        } label: {
            Image(systemName: "eraser.fill")
        }
    }
    
    private let sqlCommands = ["SELECT", "INSERT", "FROM", "WHERE", "ORDER BY", "JOIN", "INTO"]
    
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
                                    .fill(.orange.opacity(0.9))
                            }
                    }
                    .draggable(sql)
                }
            }
            .padding(.horizontal)
        }
    }
    
    @State private var showDescription = false
    
    private var question: some View {
        Button {
            showDescription = true
        } label: {
            Image(systemName: "questionmark.circle")
        }
        .sheet(isPresented: $showDescription) {
            NavigationStack {
                Description()
            }
        }
    }
}

#Preview {
    ContentView()
}
