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
    
    lazy var sampleView = SampleView()
    lazy var contentView = DocumentContentView()
    lazy var scroller = DocumentScroller()
    lazy var memoView = DocumentMemoView()
    
    var contentMultiplier: CGFloat = 0.6
    var hideBottom: Bool { contentMultiplier == 1.0 }
    
    var layout: some Layout {
        view {
            sampleView.anchors {
                Anchors.cap()
            }
//            contentView.identifying("document").anchors {
//                Anchors.cap()
//                Anchors(.height).equalTo(view).setMultiplier(contentMultiplier)
//            }
//            scroller.setAnimationHandler({ [weak self] view in
//                guard let self = self else { return }
//                view.alpha = self.hideBottom ? 0.0 : 1.0
//            }).identifying("scroller").anchors {
//                if hideBottom {
//                    Anchors(.top).equalTo(view.bottomAnchor)
//                } else {
//                    Anchors(.top).equalTo("document", attribute: .bottom)
//                }
//                Anchors.horizontal()
//                Anchors(.height).equalTo(constant: hideBottom ? 0.0 : 44.0)
//            }
//            memoView.setAnimationHandler({ [weak self] view in
//                guard let self = self else { return }
//                view.alpha = self.hideBottom ? 0.0 : 1.0
//            }).anchors {
//                if hideBottom {
//                    Anchors(.top).equalTo(view.bottomAnchor)
//                    Anchors.horizontal()
//                } else {
//                    Anchors(.top).equalTo("scroller", attribute: .bottom)
//                    Anchors.shoe()
//                }
//            }
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

final class SampleView: UIView, LayoutBuilding {
    enum Show {
        case showYellow
        case showBlack
        case showAll
    }
    var deactivable: Deactivable?
    lazy var yellow = UIView()
    lazy var black = UIView()
    var show: Show = .showAll {
        didSet {
            updateLayout(animated: true)
        }
    }
    
    @LayoutBuilder
    var layout: some Layout {
        self {
            switch show {
            case .showYellow:
                yellow.anchors {
                    Anchors.allSides()
                }
                black.setAnimationHandler({ view in
                    view.alpha = 0.0
                }).anchors {
                    Anchors(.height).equalTo(constant: 0.0)
                    Anchors.shoe()
                }
            case .showBlack:
                yellow.setAnimationHandler({ view in
                    view.alpha = 0.0
                }).anchors {
                    Anchors(.height).equalTo(constant: 0.0)
                    Anchors.cap()
                }
                black.anchors {
                    Anchors.allSides()
                }
            case .showAll:
                yellow.setAnimationHandler({ view in
                    view.alpha = 1.0
                }).anchors {
                    Anchors.cap()
                    Anchors(.bottom).equalTo(black, attribute: .top)
                    Anchors(.height).equalTo(black)
                }
                black.setAnimationHandler({ view in
                    view.alpha = 1.0
                }).anchors {
                    Anchors.shoe()
                }
            }
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        initViews()
    }
    
    required init?(coder: NSCoder) {
        fatalError()
    }
    
    func initViews() {
        yellow.backgroundColor = .yellow
        black.backgroundColor = .darkGray
        updateLayout(.automaticIdentifierAssignment)
        isUserInteractionEnabled = true
        addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(toggle)))
    }
    
    @objc
    func toggle() {
        switch show {
        case .showYellow:
            self.show = .showAll
        case .showBlack:
            self.show = .showAll
        case .showAll:
            self.show = Bool.random() ? .showYellow : .showBlack
        }
    }
    
}

struct ContentView: UIViewRepresentable {
    func makeUIView(context: Context) -> some UIView {
        SampleView()
    }
    func updateUIView(_ uiView: UIViewType, context: Context) {
        
    }
//    func makeUIViewController(context: Context) -> some UIViewController {
//        MainViewController(nibName: nil, bundle: nil)
//    }
//
//    func updateUIViewController(_ uiViewController: UIViewControllerType, context: Context) {
//
//    }
    
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView().environment(\.managedObjectContext, PersistenceController.preview.container.viewContext).previewDevice(.init(stringLiteral: "iPhone 13"))
    }
}
