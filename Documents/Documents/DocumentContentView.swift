//
//  DocumentContentView.swift
//  Documents
//
//  Created by oozoofrog on 2022/02/26.
//

import Combine
import UIKit
import SwiftUI
import SwiftLayout
import VisionKit

class DocumentContentView: UIView, LayoutBuilding {
    
    var image: UIImage? {
        didSet {
            updateLayout()
        }
    }
    
    var requestDocumentAction: AnyPublisher<Void, Never> {
        requestDocumentClickSubject.eraseToAnyPublisher()
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        initViews()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        initViews()
    }
    
    private func initViews() {
        updateLayout()
    }
    
    private let requestDocumentClickSubject = PassthroughSubject<Void, Never>()
    
    var deactivable: Deactivable?
    
    private lazy var backgroundView = UIView()
    private lazy var toggleButton: UIButton = {
        let image = UIImage(systemName: "plus",
                            withConfiguration: UIImage.SymbolConfiguration(font: .boldSystemFont(ofSize: 40.0)))
        let toggleAction = UIAction(title: "", image: image) { [weak self] _ in
            self?.requestDocumentClickSubject.send()
        }
        let button = UIButton(primaryAction: toggleAction)
        button.tintColor = .black
        return button
    }()
    
    var layout: some Layout {
        self {
            backgroundView.anchors {
                Anchors.allSides()
            }
            if let image = image {
                UIImageView(image: image).anchors {
                    Anchors.allSides()
                }
            } else {
                toggleButton.anchors {
                    Anchors.allSides()
                }
            }
        }
    }
    
}

struct DocumentContentView_Preview: PreviewProvider, UIViewRepresentable {
    func makeUIView(context: Context) -> some UIView {
        DocumentContentView(frame: .zero)
    }
    func updateUIView(_ uiView: UIViewType, context: Context) {
        
    }
    
    static var previews: some View {
        DocumentContentView_Preview()
    }
}
