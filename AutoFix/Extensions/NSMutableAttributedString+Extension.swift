//
//  NSMutableAttributedString+Extension.swift
//  AutoFix
//
//  Created by kayeli dennis on 10/09/2022.
//

import UIKit

extension NSMutableAttributedString {
    var fontSize: CGFloat { return 16 }
    var boldFont: UIFont { return UIFont.boldSystemFont(ofSize: fontSize) }
    var normalFont: UIFont { return UIFont.systemFont(ofSize: 12)}

    func bold(_ value:String) -> NSMutableAttributedString {

        let attributes:[NSAttributedString.Key : Any] = [
            .foregroundColor: UIColor.white
        ]

        self.append(NSAttributedString(string: value, attributes:attributes))
        return self
    }

    func normal(_ value:String) -> NSMutableAttributedString {

        let attributes:[NSAttributedString.Key : Any] = [
            .foregroundColor: UIColor.white
        ]

        self.append(NSAttributedString(string: value, attributes:attributes))
        return self
    }
}
