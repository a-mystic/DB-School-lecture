//
//  ResultView.swift
//  DBTermProject
//
//  Created by a mystic on 11/1/23.
//

import SwiftUI

struct ResultView: View {
    let result: String
    
    init(_ result: String) {
        self.result = result
    }
    
    var body: some View {
        Form {
            Section("실행결과") {
                Text(result)
            }
        }
    }
}

#Preview {
    ResultView("Preview\n1\n2\n3\n4\n5")
}
