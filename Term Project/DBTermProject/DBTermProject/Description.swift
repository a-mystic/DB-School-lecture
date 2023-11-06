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
            Section("notice") {
                Text("반드시 마지막동작은 종료로 마무리 해주세요.")
            }
            Section("사용가능한 작업") {
                Text("데이터 검색")
                Text("데이터 삽입")
                Text("데이터 삭제")
                Text("데이터 변경")
                Text("테이블 제약사항 변경")
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
