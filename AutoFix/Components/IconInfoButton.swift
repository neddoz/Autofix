//
//  IconInfoButton.swift
//  AutoFix
//
//  Created by kayeli dennis on 10/09/2022.
//

import UIKit

class IconInfoButton: UIButton {
    
    init(icon: UIImage, title: String) {
        super.init(frame: .zero)
        
        var config = UIButton.Configuration.plain()
        config.title = title
        config.image = icon
        
        config.imagePadding = 5
        config.contentInsets = NSDirectionalEdgeInsets(top: 2, leading: 5, bottom: 2, trailing: 5)
        config.imagePlacement = .leading

        configuration = config
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        tintColor = .gray
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
