//
//  CustomCircularProgressView.swift
//  HackGT2020
//
//  Created by Rahil Patel on 10/18/20.
//

import SwiftUI

struct CustomCircularProgressView: View {
    var progress: Double
    
    var body: some View {
        ZStack {
            Circle()
                .stroke(lineWidth: 20.0)
                .opacity(0.3)
                .foregroundColor(Color("primary_color"))
            
            Circle()
                .trim(from: 0.0, to: CGFloat(min(self.progress, 1.0)))
                .stroke(style: StrokeStyle(lineWidth: 20.0, lineCap: .round, lineJoin: .round))
                .foregroundColor(Color("primary_color"))
                .rotationEffect(Angle(degrees: 270.0))
                .animation(.linear)

            Text(String(format: "%.0f %%", min(self.progress, 1.0)*100.0))
                .font(.largeTitle)
                .bold()
        }
    }
}

struct CustomCircularProgressView_Previews: PreviewProvider {
    static var previews: some View {
        CustomCircularProgressView(progress: 0.6)
    }
}
