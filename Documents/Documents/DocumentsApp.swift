//
//  DocumentsApp.swift
//  Documents
//
//  Created by oozoofrog on 2022/02/26.
//

import SwiftUI

@main
struct DocumentsApp: App {
    let persistenceController = PersistenceController.shared

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}
