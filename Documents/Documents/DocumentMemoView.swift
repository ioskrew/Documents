//
//  DocumentMemoView.swift
//  Documents
//
//  Created by oozoofrog on 2022/02/26.
//

import UIKit
import SwiftLayout

class DocumentMemoView: UIView, LayoutBuilding {
   
    var deactivable: Deactivable?
    
    lazy var backgroundView = UIView()
    
    var layout: some Layout {
        self {
            backgroundView.config({ backgroundView in
                backgroundView.backgroundColor = .green
            }).anchors {
                Anchors.allSides()
            }
            UILabel().config { label in
                label.text = "Memo"
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
