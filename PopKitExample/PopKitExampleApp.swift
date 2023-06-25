//
//  PopKitExampleApp.swift
//  PopKitExample
//
//  Created by Pakornpat Sinjiranon on 24/6/23.
//

import SwiftUI
import PopKit

@main
struct PopKitExampleApp: App {
    init() {
        PopKit.setUp(theme: .vanGogh)
    }

    var body: some Scene {
        WindowGroup {
            ContentView()
        }
    }
}
