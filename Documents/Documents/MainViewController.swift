//
//  ContentView.swift
//  Documents
//
//  Created by oozoofrog on 2022/02/26.
//

import Combine
import SwiftLayout
import SwiftUI
import UIKit

final class MainViewController: UIViewController, LayoutBuilding {
    
    var deactivable: Deactivable?
    
    lazy var contentView = DocumentContentView()
    lazy var scroller = DocumentScroller()
    lazy var memoView = DocumentMemoView()
    
    var contentMultiplier: CGFloat = 0.6
    var hideBottom: Bool { contentMultiplier == 1.0 }
    
    var layout: some Layout {
        view {
            contentView.identifying("document").anchors {
                Anchors.cap()
                Anchors(.height).equalTo(view).setMultiplier(contentMultiplier)
            }
            scroller.config({ view in
                view.isHidden = hideBottom
            }).identifying("scroller").anchors {
                Anchors(.top).equalTo("document", attribute: .bottom)
                Anchors.horizontal()
                Anchors(.height).equalTo(constant: hideBottom ? 0.0 : 44.0)
            }
            memoView.config({ view in
                view.isHidden = hideBottom
            }).anchors {
                Anchors(.top).equalTo("scroller", attribute: .bottom)
                Anchors.shoe()
                if hideBottom {
                    Anchors(.height).equalTo(constant: .zero)
                }
            }
        }
    }
    
    var stores = Set<AnyCancellable>()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        updateLayout()
        
        contentView.requestDocumentAction.sink { [weak self] in
            self?.showDocumentCamera()
        }.store(in: &stores)
        
        contentView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(extendingContent)))
    }
    
    @objc
    func extendingContent() {
        if contentView.image == nil { return }
        if contentMultiplier == 1.0 {
            contentMultiplier = 0.6
        } else {
            contentMultiplier = 1.0
        }
        updateLayout(animated: true)
    }
    
    func showDocumentCamera() {
        let camera = FakeDocumentCameraViewController(nibName: nil, bundle: nil)
        camera.delegate = self
        present(camera, animated: true)
    }
    
    override var prefersStatusBarHidden: Bool { false }
    override var prefersHomeIndicatorAutoHidden: Bool { false }
    
}

extension MainViewController: FakeDocumentCameraViewDelegate {
    func fakeDocumentCameraFinished(_ image: UIImage?) {
        contentView.image = image
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
