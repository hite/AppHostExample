//
//  View_Preview.swift
//  AppHostExample
//
//  Created by liang on 2020/1/2.
//  Copyright © 2020 liang. All rights reserved.
//

import Foundation

#if canImport(SwiftUI)
import SwiftUI

@available(iOS 13.0, *)
struct View_Preview: PreviewProvider {
    static var previews: some View {
        UIViewPreview {
            let name = DescTableViewCell(style: .subtitle, reuseIdentifier: "cell2")
            name.configure(withTitle: "有关埋点", desc: "数据希望规范内容体系")
            return name
        }.padding()
    }
}

#endif
