//
//  MyView.swift
//  SwiftUI_Practice
//
//  Created by Chuchu Pro on 2021/12/18.
//

import SwiftUI

struct MyView: View {
    
    let colors: [Color] = [.red, .orange, .yellow, .green, .blue, .purple]
    var body: some View {
        ZStack {
            ZStack {
                ForEach(0..<colors.count) {
                    Rectangle()
                        .fill(colors[$0])
                        .frame(width: 100, height: 100)
                        .offset(x: CGFloat($0) * 10.0, y: CGFloat($0) * 10.0)
                }
            }
            ZStack(alignment: .bottomLeading) {
                Rectangle()
                    .fill(Color.red)
                    .frame(width: 50, height: 100)
                    .offset(x: 160, y: 160)
                Rectangle()
                    .fill(Color.blue)
                    .frame(width: 100, height: 50)
                    .offset(x: 160, y: 160)
            }
            .border(Color.green, width: 1)
        }
    }
}

struct MyView_Previews: PreviewProvider {
    static var previews: some View {
        MyView()
    }
}
