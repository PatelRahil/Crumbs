//
//  DonateView.swift
//  HackGT2020
//
//  Created by Rahil Patel on 10/17/20.
//

import SwiftUI

struct DonateView: View {
    
    @EnvironmentObject var dataModel: DataModel
    
    var body: some View {
        NavigationView {
            VStack {
                List {
                    ForEach(dataModel.sortedFacilities, id: \.self) { relativeFacility in
                        DonateViewCell(rf: relativeFacility, currentLocation: dataModel.currentLocation)
                    }
                }
            }.navigationTitle("Donate")
        }.onAppear {
            dataModel.refreshFacilities()
        }
    }
}

struct DonateView_Previews: PreviewProvider {
    static var previews: some View {
        DonateView()
    }
}
