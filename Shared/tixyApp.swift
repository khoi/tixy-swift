//
//  tixyApp.swift
//  Shared
//
//  Created by khoi on 12/17/20.
//

import SwiftUI

@main
struct tixyApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView(
                size: 16,
                transform: { (_, _, _, y) in
                    CGFloat(y) - 7.5
                }
            )
        }
    }
}
