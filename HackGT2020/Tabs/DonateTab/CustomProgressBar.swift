//
//  CustomProgressBar.swift
//  HackGT2020
//
//  Created by Rahil Patel on 10/17/20.
//

import SwiftUI

struct CustomProgressBar<Label: View, CurrentValueLabel: View>: View {
    let progressBar: ProgressView<Label, CurrentValueLabel>
    var body: some View {
        progressBar
            .progressViewStyle(LinearProgressViewStyle(tint: Color("primary_color")))
            .frame(width: nil, height: 4, alignment: .center)
    }
}

struct CustomProgressBar_Previews: PreviewProvider {
    static var previews: some View {
        CustomProgressBar(progressBar: ProgressView(""))
    }
}
