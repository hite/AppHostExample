//
//  ViewController_Preview.swift
//  AppHostExample
//
//  Created by liang on 2020/1/2.
//  Copyright © 2020 liang. All rights reserved.
//

import Foundation
import SwiftUI

#if canImport(SwiftUI)

@available(iOS 13.0, *)
struct ViewController_Preview: PreviewProvider, UIViewControllerRepresentable {
    
    typealias UIViewControllerType = UIViewController

    static var previews: some View {
        ViewController_Preview()
    }
    
    func makeUIViewController(context: UIViewControllerRepresentableContext<ViewController_Preview>) -> UIViewController {
        let vc = MasterViewController()
//        vc.title = "标题"
//        let nav = UINavigationController(rootViewController: vc)
        return vc
    }
    
    func updateUIViewController(_ uiViewController: UIViewController, context: UIViewControllerRepresentableContext<ViewController_Preview>) {
        
    }
}

#endif
