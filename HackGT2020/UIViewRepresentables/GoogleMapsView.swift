//
//  GoogleMapsView.swift
//  HackGT2020
//
//  Created by Rahil Patel on 10/17/20.
//

import SwiftUI
import GoogleMaps

struct GoogleMapsView: UIViewRepresentable {
    var pins: [RelativeRestaurant] = []
    private let zoom: Float = 15.0
    private let locationManager = CLLocationManager()
    @Binding public var currentLocation: CLLocationCoordinate2D
    
    func makeUIView(context: Context) -> GMSMapView {
        self.locationManager.requestWhenInUseAuthorization()
        var camera = GMSCameraPosition.camera(withLatitude: 0, longitude: 0, zoom: zoom)
        if CLLocationManager.locationServicesEnabled() {
            locationManager.desiredAccuracy = kCLLocationAccuracyNearestTenMeters
            locationManager.startUpdatingLocation()
            camera = GMSCameraPosition.camera(withLatitude: currentLocation.latitude, longitude: currentLocation.longitude, zoom: zoom)
        }
        
        let mapView = GMSMapView.map(withFrame: CGRect.zero, camera: camera)
        for pin in pins {
            let marker = GMSMarker()
            marker.position = pin.coords!
            marker.title = pin.restaurant.name
            marker.snippet = pin.restaurant.address
            marker.map = mapView
        }
        return mapView
    }
    
    func updateUIView(_ uiView: GMSMapView, context: Context) {
        
        let camera = GMSCameraPosition.camera(withLatitude: currentLocation.latitude, longitude: currentLocation.longitude, zoom: zoom)
        uiView.animate(to: camera)
    }
    
    func makeCoordinator() -> Coordinator {
        Coordinator(locationManager: locationManager) { location in
            let buff = 0.01
            if abs(location.latitude - self.currentLocation.latitude) > buff || abs(location.longitude - self.currentLocation.longitude) > 0.01 {
                self.currentLocation = location
            }
        }
    }
    
    class Coordinator: NSObject, CLLocationManagerDelegate {
        var setCurrentLocation: (CLLocationCoordinate2D) -> ()
        init(locationManager: CLLocationManager, _setCurrentLocation: @escaping (CLLocationCoordinate2D) -> ()) {
            setCurrentLocation = _setCurrentLocation
            super.init()
            if CLLocationManager.locationServicesEnabled() {
                locationManager.delegate = self
            }
        }
        func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
            guard let locValue = manager.location?.coordinate else { return }
            setCurrentLocation(locValue)
        }
    }
}
