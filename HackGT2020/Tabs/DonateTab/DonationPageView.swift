//
//  DonationPageView.swift
//  HackGT2020
//
//  Created by Rahil Patel on 10/17/20.
//

import SwiftUI

struct DonationPageView: View {
    @EnvironmentObject var userDataModel: UserDataModel
    @State var isPresented = false
    @State var deduct = 0.0
    @State var additional = 0.0
    let rf: RelativeFacility
    
    var body: some View {
        ZStack {
            VStack {
                Text(rf.facility.name).font(.title).padding(10)
                if let mf = rf.facility.microfund {
                    VStack {
                        CustomCircularProgressView(progress: (mf.progress + additional) / mf.goal).padding()
                        Text(String(format: "$%.2f out of $%.2f", mf.progress + additional, mf.goal)).padding(.bottom)
                    }
                }
                Divider()
                HStack {
                    Text("Donate").bold()
                    Spacer()
                    Text(String(format: "Balance: $%.2f", userDataModel.balance))
                }.padding(10)
                Button {
                    isPresented.toggle()
                    deduct = 1
                } label: {
                    HStack {
                        Spacer()
                        Text("$1").bold().foregroundColor(.white).padding()
                        Spacer()
                    }
                }.disabled(self.userDataModel.balance < 1).background(Color("primary_color")).frame(width: nil, height: 50, alignment: .center).cornerRadius(25).padding().opacity(self.userDataModel.balance < 1 ? 0.8 : 1)

                Button {
                    isPresented.toggle()
                    deduct = 5
                } label: {
                    HStack {
                        Spacer()
                        Text("$5").bold().foregroundColor(.white).padding()
                        Spacer()
                    }
                }.disabled(self.userDataModel.balance < 5).background(Color("primary_color")).frame(width: nil, height: 50, alignment: .center).cornerRadius(25).padding().opacity(self.userDataModel.balance < 5 ? 0.8 : 1)
                
                Button {
                    isPresented.toggle()
                    deduct = 10
                } label: {
                    HStack {
                        Spacer()
                        Text("$10").bold().foregroundColor(.white).padding()
                        Spacer()
                    }
                }.disabled(self.userDataModel.balance < 10).background(Color("primary_color")).frame(width: nil, height: 50, alignment: .center).cornerRadius(25).padding().opacity(self.userDataModel.balance < 10 ? 0.8 : 1)
                
                Button {
                    isPresented.toggle()
                    deduct = 7.25
                } label: {
                    HStack {
                        Spacer()
                        Text("Custom").bold().foregroundColor(.white).padding()
                        Spacer()
                    }
                }.disabled(self.userDataModel.balance < 100).background(Color("primary_color")).frame(width: nil, height: 50, alignment: .center).cornerRadius(25).padding().opacity(self.userDataModel.balance < 100 ? 0.8 : 1)
                
                Spacer()
            }
        }
        .alert(isPresented: $isPresented, content: {
            Alert(title: Text(String(format: "Donate $%.2f", deduct)), message: Text(String(format: "Are you sure you would like to donate $%.2f", deduct)), primaryButton: Alert.Button.default(Text("Yes"), action: {
                self.userDataModel.balance -= deduct
                self.additional += deduct
            }), secondaryButton: Alert.Button.cancel())
        })
        .ignoresSafeArea(.all, edges: .bottom)
    }
}

struct DonationPageView_Previews: PreviewProvider {
    static var previews: some View {
        let facility = Facility(name: "AllCare Family Medicine & Urgent Care - Buckhead GA", address: "3867 Roswell Rd NE, Atlanta, GA 30342    ", ownerName: "AllCare Family Medicine & Urgent Care", microfund: nil)
        DonationPageView(rf: RelativeFacility(facility: facility, dist: 100))
    }
}
