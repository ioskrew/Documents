//
//  FakeDocumentCameraViewController.swift
//  Documents
//
//  Created by oozoofrog on 2022/02/26.
//

import UIKit
import SwiftLayout
import SwiftUI

protocol FakeDocumentCameraViewDelegate: AnyObject {
    func fakeDocumentCameraFinished(_ image: UIImage?)
}

class FakeDocumentCameraViewController: UIViewController {

    weak var delegate: FakeDocumentCameraViewDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        view {
            UIImageView(image: UIImage(named: "camera")).anchors {
                Anchors.allSides()
            }
        }.finalActive()
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        setNeedsStatusBarAppearanceUpdate()
        setNeedsUpdateOfHomeIndicatorAutoHidden()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        delegate?.fakeDocumentCameraFinished(UIImage(named: "hunmin"))
        super.viewWillDisappear(animated)
    }
    
    override var prefersStatusBarHidden: Bool { true }
    override var prefersHomeIndicatorAutoHidden: Bool { true }

}

struct FakeDocumentCameraViewControllerRepresentable: UIViewControllerRepresentable {
    func makeUIViewController(context: Context) -> some UIViewController {
        FakeDocumentCameraViewController(nibName: nil, bundle: nil)
    }
    func updateUIViewController(_ uiViewController: UIViewControllerType, context: Context) {
        
    }
}

struct FakeDocumentCameraViewController_Previews: PreviewProvider {
    static var previews: some View {
        FakeDocumentCameraViewControllerRepresentable()
    }
}
