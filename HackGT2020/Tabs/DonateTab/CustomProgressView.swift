//
//  ProgressBar.swift
//  HackGT2020
//
//  Created by Rahil Patel on 10/17/20.
//

import SwiftUI

struct CustomProgressView: View {
    let currentProgress: Double
    let totalProgress: Double
    let title: String
    var body: some View {
        VStack {
            Text(title)
            GeometryReader { geometry in
                ZStack(alignment: .leading) {
                    Rectangle().frame(width: geometry.size.width , height: geometry.size.height)
                        .opacity(0.3)
                        .foregroundColor(Color("primary_color"))
                    
                    Rectangle().frame(width: min(CGFloat(self.currentProgress/self.totalProgress)*geometry.size.width, geometry.size.width), height: geometry.size.height)
                        .foregroundColor(Color("primary_color"))
                        .animation(.linear)
                }.cornerRadius(45.0)
            }
        }
    }
}

struct ProgressBar_Previews: PreviewProvider {
    static var previews: some View {
        CustomProgressView(currentProgress: 5, totalProgress: 10, title: "")
    }
}
