//
//  ExploreView.swift
//  HackGT2020
//
//  Created by Rahil Patel on 10/17/20.
//

import SwiftUI

struct ExploreView: View {
    @EnvironmentObject var dataModel: DataModel
    var body: some View {
        NavigationView {
            VStack {
                List {
                    ForEach(dataModel.sortedRestaurants, id: \.self) { relativeRestaurant in
                        ExploreViewCell(rr: relativeRestaurant, currentLocation: dataModel.currentLocation)
                    }
                }
            }.navigationTitle("Explore")
        }.onAppear {
            dataModel.refreshRestaurants()
        }
    }
}

struct ExploreView_Previews: PreviewProvider {
    static var previews: some View {
        ExploreView()
    }
}
