//
//  ScanView.swift
//  HackGT2020
//
//  Created by Rahil Patel on 10/18/20.
//

import SwiftUI
import CodeScanner

struct ScanView: View {
    @EnvironmentObject var dataModel: DataModel
    @EnvironmentObject var userDataModel: UserDataModel
    @State var resultModalPresented = false
    @State var message = String("Success! $1.10 was added to your account for the purpose of donations.")
    @State var numTimesScanned = 0
    @State var loading = false
    var body: some View {
        ZStack {
            CodeScannerView(codeTypes: [.qr]) { (result) in
                loading = true
                DispatchQueue.main.asyncAfter(deadline: .now() + Double.random(in: 2..<4)) {
                    loading = false
                    print(result)
                    if numTimesScanned > 0 {
                        message = "Sorry! You have already scanned this QR Code and redeemed your donation. Make a donation at participating restaurants or directly add money to make more donations."
                    } else {
                        userDataModel.balance += 1.1
                    }
                    resultModalPresented.toggle()
                    numTimesScanned += 1
                }
            }
            if loading {
                ZStack {
                    Color.init(.displayP3, white: 0.6, opacity: 0.6).frame(width: 80, height: 80, alignment: .center).cornerRadius(10)
                    ProgressView()
                }
            }
            VStack {
                HStack {
                    Spacer()
                    Text(String(format: "Balance: $%.2f", userDataModel.balance))
                        .padding(3)
                        .background(Color.white)
                        .cornerRadius(5)
                        .padding(.top, 60)
                        .padding(.trailing, 20)
                }
                Spacer()
            }
        }
        .alert(isPresented: $resultModalPresented, content: {
            Alert(title: Text("QR Code Scanned"), message: Text(message), dismissButton: nil)
        })
        .ignoresSafeArea(.all, edges: .top)

    }
}

struct ScanView_Previews: PreviewProvider {
    static var previews: some View {
        ScanView()
    }
}
