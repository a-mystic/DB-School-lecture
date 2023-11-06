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
                if isFetching {
                    ProgressView()
                        .scaleEffect(2)
                        .tint(.white)
                }
            }
            .navigationBarTitleDisplayMode(.inline)
            .navigationTitle("데이터베이스시스템")
            .toolbar {
                ToolbarItem(placement: .topBarLeading) {
                    HStack {
                        eraser
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
                        .padding()
                        .background(
                            RoundedRectangle(cornerRadius: 4)
                                .fill(.purple)
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
    @State private var isFetching = false
    
    private func running() async {
        isFetching = true
        var command = ""
        for index in selectedSqlCommands.indices {
            command += selectedSqlCommands[index] + " " + commands[index] + " "
        }
        command = command.replacingOccurrences(of: "’", with: "'")
        command = command.replacingOccurrences(of: "‘", with: "'")
        let url = "ngrok URL인데 http설정 안돼있어서 접속주소는 반드시 https로 접속해야함." + chooseApiCall(selectedSqlCommands[0]) + "?command=" + command
        guard let url = URL(string: url) else { return }
        do {
            let (data, _) = try await URLSession.shared.data(from: url)
            let returnValue = try JSONDecoder().decode(String.self, from: data)
            resultValue = returnValue
            isFetching = false
            erase()
        } catch {
            print(error)
        }
    }
    
    private func chooseApiCall(_ command: String) -> String {
        if command == "SELECT" {
            return "select"
        } else if command == "INSERT INTO" {
            return "insert"
        } else if command == "종료" {
            return "end"
        } else if command == "ALTER" {
            return "alter"
        } else if command == "UPDATE" {
            return "update"
        } else {
            return "delete"
        }
    }
    
    private var eraser: some View {
        Button {
            erase()
        } label: {
            Image(systemName: "eraser.fill")
        }
    }
    
    private func erase() {
        commands = []
        selectedSqlCommands = []
    }
    
    private let sqlCommands = ["SELECT", "INSERT INTO", "FROM", "WHERE", "ORDER BY", "JOIN", "VALUES", "DROP", "ALTER", "UPDATE", "SET","종료"]
    
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
        .padding()
        .background(Color.gray.opacity(0.4))
        .clipped()
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
