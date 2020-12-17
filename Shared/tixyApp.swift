import SwiftUI

@main
struct tixyApp: App {
    var body: some Scene {
        WindowGroup {
            TixyMatrix(
                size: 16
            )
        }
    }
}
