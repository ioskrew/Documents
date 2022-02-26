//
//  FakeDocumentCameraViewController.swift
//  Documents
//
//  Created by oozoofrog on 2022/02/26.
//

import UIKit
import SwiftLayout
import SwiftUI

class FakeDocumentCameraViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        view {
            UIImageView(image: UIImage(named: "documentcamera")).anchors {
                Anchors.allSides()
            }
        }.finalActive()
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        setNeedsStatusBarAppearanceUpdate()
        setNeedsUpdateOfHomeIndicatorAutoHidden()
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
