//
//  DataModel.swift
//  HackGT2020
//
//  Created by Rahil Patel on 10/17/20.
//

import GoogleMaps
import GooglePlaces
import Alamofire

class DataModel: ObservableObject {
    @Published var currentLocation: CLLocationCoordinate2D = CLLocationCoordinate2D.init(latitude: 0, longitude: 0)
    
    var facilities = [
        Facility(name: "AllCare Family Medicine & Urgent Care - Buckhead GA", address: "3867 Roswell Rd NE, Atlanta, GA 30342    ", ownerName: "AllCare Family Medicine & Urgent Care", microfund: Microfund(goal: 100, progress: 42.55, deadline: Date(timeIntervalSinceNow: 60 * 60  * 24 * 7))),
        Facility(name: "CVS Health COVID-19 Drive Thru Testing Site - By Appointment Only", address: "352 Peachtree Place, Atlanta, GA, 30332", ownerName: "CVS Health", microfund: Microfund(goal: 200, progress: 82.89, deadline: Date(timeIntervalSinceNow: 60 * 60  * 24 * 10))),
        Facility(name: "Emory University Hospital Midtown", address: "550 Peachtree St NE, Atlanta, GA 30308", ownerName: "Emory Healthcare", microfund: Microfund(goal: 150, progress: 128.21, deadline: Date(timeIntervalSinceNow: 60 * 60  * 24 * 4)))
    ]
    
    var restaurants = [
        Restaurant(name: "Rocky Mountain Pizza Company", address: "1005 Hemphill Ave NW, Atlanta, GA 30318", donationRate: 0.1),
        Restaurant(name: "Goodfellas", address: "615 Spring St NW, Atlanta, GA 30308", donationRate: 0.05),
        Restaurant(name: "Satto Thai and Sushi Bar", address: "768 Marietta St NW, Atlanta, GA 30318", donationRate: 0.2),
        Restaurant(name: "The Yard Milkshake Bar", address: "341 Marietta St. NW, Atlanta, GA 30313", donationRate: 0.2)
    ]
    
    @Published var relativeFacilities: [RelativeFacility] = []
    @Published var relativeRestaurants: [RelativeRestaurant] = []
    
    var sortedFacilities: [RelativeFacility] {
        relativeFacilities.sorted { (m1, m2) -> Bool in
            let _d1 = m1.dist
            let _d2 = m2.dist
            guard let d1 = _d1 else { return false }
            guard let d2 = _d2 else { return true }
            return d1 < d2
        }
    }
    
    var sortedRestaurants: [RelativeRestaurant] {
        relativeRestaurants.sorted { (m1, m2) -> Bool in
            let _d1 = m1.dist
            let _d2 = m2.dist
            guard let d1 = _d1 else { return false }
            guard let d2 = _d2 else { return true }
            return d1 < d2
        }
    }
    
    func refreshFacilities() {
        print("Refreshing facilities")
        for facility in facilities {
            if !relativeFacilities.contains(where: { $0.facility == facility }) {
                getRelativeFacility(for: facility)
            }
        }
    }
    
    func getRelativeFacility(for facility: Facility) {
        geocode(address: facility.address) { (coords) in
            let diff = sqrt(pow((self.currentLocation.latitude - coords.latitude), 2) + pow((self.currentLocation.longitude - coords.longitude), 2))
            self.relativeFacilities.append(RelativeFacility(facility: facility, coords: coords, dist: diff))
        }
    }
    
    func refreshRestaurants() {
        for restaurant in restaurants {
            if !relativeRestaurants.contains(where: { $0.restaurant == restaurant }) {
                getRelativeRestaurant(for: restaurant)
            }
        }
    }
    
    func getRelativeRestaurant(for restaurant: Restaurant) {
        geocode(address: restaurant.address) { (coords) in
            let diff = sqrt(pow((self.currentLocation.latitude - coords.latitude), 2) + pow((self.currentLocation.longitude - coords.longitude), 2))
            
            self.relativeRestaurants.append(RelativeRestaurant(restaurant: restaurant, coords: coords, dist: diff))
        }
    }
    
    private func geocode(address: String, onComplete: @escaping (CLLocationCoordinate2D) -> Void) {
        print("Geocoding")
        
        let key : String = APIKeys.GoogleMapsKey
        let postParameters:[String: Any] = [ "address": address,"key":key]
        var allowedQueryParamAndKey = NSCharacterSet.urlQueryAllowed
        allowedQueryParamAndKey.remove(charactersIn: ";/?:@&=+$, ")
        let encodedAddress = address.addingPercentEncoding(withAllowedCharacters: allowedQueryParamAndKey)
        let url : String = "https://maps.googleapis.com/maps/api/geocode/json?address=\(encodedAddress ?? "")&key=\(key)"

        AF.request(url, method: .get, parameters: postParameters, encoding: URLEncoding.default, headers: nil).responseJSON {  response in
            print("Requested result: \(response)")
            switch response.result {
                case .success(let value):
                    print("Success! \(value)")
                    if let json = value as? [String: Any] {
                        print("Result:")
                        print(json["results"]!)
                        guard let results = (json["results"] as? [[String: Any]]) else { return }
                        guard let result = results.first else { return }
                        guard let geo = result["geometry"] as? [String: Any] else { return }
                        guard let loc = geo["location"] as? [String: Any] else { return }
                        guard let lat = loc["lat"] as? Double else { return }
                        guard let long = loc["lng"] as? Double else { return }
                        let coord = CLLocationCoordinate2D(latitude: lat, longitude: long)
                        onComplete(coord)
                    }
                case .failure(let error):
                    print(error)
            }
        }
    }
    
    struct CoordDist {
        let dist: Double?
        let coords: CLLocationCoordinate2D?
    }
}
