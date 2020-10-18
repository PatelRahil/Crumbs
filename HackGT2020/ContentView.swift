//
//  ContentView.swift
//  HackGT2020
//
//  Created by Rahil Patel on 10/17/20.
//

import SwiftUI

struct ContentView: View {
    @State var selection = 0
    var body: some View {
        TabView(selection: $selection,
                content:  {
                    MapView().tabItem {
                        Image(selection == 0 ? "map_icon_selected" : "map_icon_unselected")
                        Text("Map")
                    }.tag(0)
                    ExploreView().tabItem {
                        Image(selection == 1 ? "explore_icon_selected" : "explore_icon_unselected")
                        Text("Explore")
                    }.tag(1)
                    ScanView().tabItem {
                        Image(selection == 2 ? "qr_icon_selected" : "qr_icon_unselected")
                        Text("Scan")
                    }.tag(2)
                    DonateView().tabItem {
                        Image(selection == 3 ? "donate_icon_selected" : "donate_icon_unselected")
                        Text("Donate")
                    }.tag(3)
                    Text("Profile").tabItem {
                        Image(selection == 4 ? "profile_icon_selected" : "profile_icon_unselected")
                        Text("Profile")
                    }.tag(4)
                }).accentColor(Color("accent_color"))
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
