//
//  DocumentScroller.swift
//  Documents
//
//  Created by oozoofrog on 2022/02/26.
//

import UIKit
import SwiftLayout

class DocumentScroller: UIView, LayoutBuilding {

    var deactivable: Deactivable?
    
    var layout: some Layout {
        self {
            UIView().config { view in
                view.backgroundColor = .lightGray.withAlphaComponent(0.5)
            }.anchors {
                Anchors.allSides()
            }
            UILabel().config { label in
                label.text = "Scroller"
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
