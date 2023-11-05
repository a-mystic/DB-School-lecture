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
                    .bold()
            }
        }
    }
}

#Preview {
    ResultView("Preview\n1123123123\n212312313123\n312312313123\n41231313123\n5123131312313")
}
