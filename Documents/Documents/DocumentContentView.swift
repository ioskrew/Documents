//
//  DocumentContentView.swift
//  Documents
//
//  Created by oozoofrog on 2022/02/26.
//

import UIKit
import SwiftUI
import SwiftLayout

class DocumentContentView: UIView, LayoutBuilding {

    var deactivable: Deactivable?
    
    lazy var backgroundView = UIView()
    
    var layout: some Layout {
        self {
            backgroundView.config({ backgroundView in
                backgroundView.backgroundColor = .yellow
            }).anchors {
                Anchors.allSides()
            }
            UILabel().config { label in
                label.text = "Document"
                label.textColor = .darkText
            }.anchors {
                Anchors(.centerX, .centerY)
            }
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        updateLayout()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        updateLayout()
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
