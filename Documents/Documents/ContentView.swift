//
//  ContentView.swift
//  Documents
//
//  Created by oozoofrog on 2022/02/26.
//

import SwiftUI
import CoreData

struct ContentView: View {
    
    var body: some View {
        GeometryReader { proxy in
            VStack {
                Color.yellow.overlay(Text("Document")).frame(height: proxy.size.height * 0.7)
                Color.green.overlay(Text("Memo")).frame(height: proxy.size.height * 0.3)
            }
        }
    }
    
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView().environment(\.managedObjectContext, PersistenceController.preview.container.viewContext)
    }
}
