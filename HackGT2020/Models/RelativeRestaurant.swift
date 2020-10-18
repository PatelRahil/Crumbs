//
//  RelativeRestaurant.swift
//  HackGT2020
//
//  Created by Rahil Patel on 10/18/20.
//

import GoogleMaps

struct RelativeRestaurant: Hashable {
    static func == (lhs: RelativeRestaurant, rhs: RelativeRestaurant) -> Bool {
        return lhs.restaurant == rhs.restaurant && lhs.dist == rhs.dist
    }
    
    var restaurant: Restaurant
    var coords: CLLocationCoordinate2D?
    var dist: Double?
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(restaurant)
        hasher.combine(dist)
    }
    
    func distToFormattedMiles(currentLocation: CLLocationCoordinate2D) -> String? {
        guard let coords = coords else { return nil }
        let latMult = 69.0
        let longMult = 54.6
        let hMiles = latMult * abs(coords.latitude - currentLocation.latitude)
        let vMiles = longMult * abs(coords.longitude - currentLocation.longitude)
        let distMiles = sqrt(pow((hMiles - vMiles), 2))
        return String.init(format: "%.2f mi", distMiles)
    }
}
