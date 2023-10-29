//
//  Description.swift
//  DBTermProject
//
//  Created by a mystic on 10/29/23.
//

import SwiftUI

struct Description: View {
    @Environment(\.dismiss) var dismiss
    
    var body: some View {
        Form {
            Section("사용가능한 작업") {
                Text("데이터 검색")
                Text("데이터 삽입")
                Text("데이터 삭제")
                Text("테이블 보기")
            }
        }
        .toolbar {
            ToolbarItem(placement: .topBarLeading) {
                Button("Close") {
                    dismiss()
                }
            }
        }
    }
}

#Preview {
    Description()
}
