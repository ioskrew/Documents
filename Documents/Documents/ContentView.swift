//
//  ContentView.swift
//  Documents
//
//  Created by oozoofrog on 2022/02/26.
//

import SwiftLayout
import SwiftUI
import UIKit

final class MainViewController: UIViewController, LayoutBuilding {
    
    var deactivable: Deactivable?
    
    var layout: some Layout {
        view {
            DocumentContentView().identifying("document").anchors {
                Anchors.cap()
                Anchors(.height).equalTo(view).setMultiplier(0.6)
            }
            DocumentScroller().identifying("scroller").anchors {
                Anchors(.top).equalTo("document", attribute: .bottom)
                Anchors.horizontal()
                Anchors(.height).equalTo(constant: 44)
            }
            DocumentMemoView().anchors {
                Anchors(.top).equalTo("scroller", attribute: .bottom)
                Anchors.shoe()
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        updateLayout()
    }
    
}

struct ContentView: UIViewControllerRepresentable {
    
    func makeUIViewController(context: Context) -> some UIViewController {
        MainViewController(nibName: nil, bundle: nil)
    }
    
    func updateUIViewController(_ uiViewController: UIViewControllerType, context: Context) {
        
    }
    
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView().environment(\.managedObjectContext, PersistenceController.preview.container.viewContext).previewDevice(.init(stringLiteral: "iPhone 13"))
    }
}
