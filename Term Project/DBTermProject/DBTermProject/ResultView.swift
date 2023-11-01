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
        Text(result)
    }
}

#Preview {
    ResultView("Preview")
}
