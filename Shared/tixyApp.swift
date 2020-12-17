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
                transform: { (t, i, x, y) in
                    let a = pow(x-7.5, 2)
                    let b = pow(y-6, 2)
                    return sin(t-sqrt(a + b))
                }
            )
        }
    }
}
