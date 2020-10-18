//
//  MapView.swift
//  HackGT2020
//
//  Created by Rahil Patel on 10/17/20.
//

import SwiftUI

struct MapView: View {
    @EnvironmentObject var dataModel: DataModel
    var body: some View {
        GoogleMapsView(pins: dataModel.relativeRestaurants, currentLocation: Binding(get: {
            dataModel.currentLocation
        }, set: { (newVal) in
            dataModel.currentLocation = newVal
        }))
        .ignoresSafeArea(.all, edges: .top)
        .onAppear {
            dataModel.refreshRestaurants()
        }
    }
}
