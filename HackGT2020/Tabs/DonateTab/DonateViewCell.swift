//
//  DonateViewCell.swift
//  HackGT2020
//
//  Created by Rahil Patel on 10/17/20.
//

import SwiftUI
import GoogleMaps

struct DonateViewCell: View {
    let rf: RelativeFacility
    let currentLocation: CLLocationCoordinate2D
    @State var modalPresented = false
    
    var body: some View {
        Button {
            modalPresented.toggle()
        } label: {
            HStack {
                VStack(alignment: HorizontalAlignment.leading, spacing: nil) {
                    Text(rf.facility.name).bold()
                    Text(rf.distToFormattedMiles(currentLocation: currentLocation) ?? "")
                    if let mf = rf.facility.microfund {
                        CustomProgressView(currentProgress: mf.progress, totalProgress: mf.goal, title: String(format: "$%.2f out of $%.2f", mf.progress, mf.goal)).padding([.top])
                    }
                }
                Spacer()
            }
        }.padding()
        .sheet(isPresented: $modalPresented) {
            DonationPageView(rf: rf)
        }
    }
}

struct DonateViewCell_Previews: PreviewProvider {
    static var previews: some View {
        let facility = Facility(name: "AllCare Family Medicine & Urgent Care - Buckhead GA", address: "3867 Roswell Rd NE, Atlanta, GA 30342    ", ownerName: "AllCare Family Medicine & Urgent Care", microfund: nil)
        DonateViewCell(rf: RelativeFacility(facility: facility, dist: 100), currentLocation: CLLocationCoordinate2D.init())
    }
}
