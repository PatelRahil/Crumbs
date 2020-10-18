//
//  HackGT2020App.swift
//  HackGT2020
//
//  Created by Rahil Patel on 10/17/20.
//

import SwiftUI
import GoogleMaps
import GooglePlaces

@main
struct HackGT2020App: App {
    
    init() {
        getAPIKeys()
        setupGMSServices()
    }
    
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(DataModel())
                .environmentObject(UserDataModel())
        }
    }
}

extension HackGT2020App {
    func getAPIKeys() {
        let url = Bundle.main.url(forResource: "keys", withExtension: "json")
        var data = Data()
        var keys = [String:String]()
        do { data = try Data(contentsOf: url!) }
        catch let error { print("Error: \(error)") }
        do { keys = try JSONSerialization.jsonObject(with: data, options: .allowFragments) as! [String:String]}
        catch let error { print("Error: \(error)") }
        APIKeys.GoogleMapsKey = keys["GoogleMaps"]!
        
    }
    
    func setupGMSServices() {
        GMSServices.provideAPIKey(APIKeys.GoogleMapsKey)
        GMSPlacesClient.provideAPIKey(APIKeys.GoogleMapsKey)
    }
}

struct APIKeys {
    static var GoogleMapsKey: String = ""
}
