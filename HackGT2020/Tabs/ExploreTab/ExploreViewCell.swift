//
//  ExploreViewCell.swift
//  HackGT2020
//
//  Created by Rahil Patel on 10/17/20.
//

import SwiftUI
import GoogleMaps

struct ExploreViewCell: View {
    let rr: RelativeRestaurant
    let currentLocation: CLLocationCoordinate2D
    var body: some View {
        HStack {
            VStack(alignment: HorizontalAlignment.leading, spacing: nil) {
                Text(rr.restaurant.name).bold()
                Text(rr.distToFormattedMiles(currentLocation: currentLocation) ?? "")
                Text(formatDonationRate(donationRate: rr.restaurant.donationRate))
            }
            Spacer()
        }.padding()
    }
    
    func formatDonationRate(donationRate: Double) -> String {
        let outOf = 10.0
        return String(format: "$%.2f for every $%.2f dollars spent", donationRate * outOf, outOf)
    }
}

struct ExploreViewCell_Previews: PreviewProvider {
    static var previews: some View {
        ExploreViewCell(rr: RelativeRestaurant(restaurant: Restaurant(name: "Rocky Mountain Pizza Company", address: "1005 Hemphill Ave NW, Atlanta, GA 30318", donationRate: 0.1), coords: CLLocationCoordinate2D(), dist: 10), currentLocation: CLLocationCoordinate2D())
    }
}
