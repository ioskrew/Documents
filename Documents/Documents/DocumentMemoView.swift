//
//  DocumentMemoView.swift
//  Documents
//
//  Created by oozoofrog on 2022/02/26.
//

import UIKit
import SwiftLayout
import SwiftUI

class DocumentMemoView: UIView, LayoutBuilding {
   
    var deactivable: Deactivable?
    
    lazy var textView: UITextView = {
        let textView = UITextView()
        textView.font = .systemFont(ofSize: 24.0)
        textView.isEditable = false
        textView.backgroundColor = .clear
        return textView
    }()
    
    var layout: some Layout {
        self {
            if textView.text.isEmpty {
                UILabel().config { label in
                    label.text = "tap to insert text"
                    label.font = .systemFont(ofSize: 21.0)
                }.anchors {
                    Anchors(.centerX, .centerY)
                }
            } else {
                textView.anchors {
                    Anchors.allSides()
                }
            }
        }
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
        backgroundColor = .white
        updateLayout()
        addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(insertText)))
    }

    @objc
    private func insertText() {
        textView.text = """
        우리나라의 말이 중국말과 달라 한문 글자와는 서로 통하지 않으므로 어리석은 백성이 말하고자 하는 것이 있어도 마침내 제 뜻을 (글로) 표현하지 못하는 사람이 많다. 내가 이를 딱하게 여기어 새로 스물여덟 글자를 만드니, 사람들로 하여금 쉽게 익혀 날마다 쓰는 데 편하게 하고자 할 따름이다.
        """
        updateLayout()
    }
}

struct DocumentMemoViewRepresentable: UIViewRepresentable {
    func makeUIView(context: Context) -> some UIView {
        DocumentMemoView(frame: .zero)
    }
    func updateUIView(_ uiView: UIViewType, context: Context) {
        
    }
}

struct DocumentMemoView_Previews: PreviewProvider {
    static var previews: some View {
        DocumentMemoViewRepresentable()
    }
}
