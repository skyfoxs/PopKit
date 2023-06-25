//
//  ContentView.swift
//  PopKitExample
//
//  Created by Pakornpat Sinjiranon on 24/6/23.
//

import SwiftUI
import PopKit

struct ContentView: View {
    var body: some View {
        VStack {
            Image(systemName: "globe")
                .imageScale(.large)
                .foregroundColor(.accentColor)
            Text("Hello, world!")
                .foregroundColor(
                    Color(uiColor: PopKit.color(for: .backgroundPrimary))
                )
        }
        .padding()
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
