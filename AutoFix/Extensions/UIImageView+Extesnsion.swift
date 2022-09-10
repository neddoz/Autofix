//
//  UIImageView.swift
//  AutoFix
//
//  Created by kayeli dennis on 10/09/2022.
//

import UIKit

// MARK: - TODO build a good caching mechanism
var imageCache = NSCache<AnyObject, AnyObject>()

extension UIImageView {
    
    func loadImage(_ url: URL) {
        
        if let cachedImage = imageCache.object(forKey: url.absoluteString as NSString) {
            DispatchQueue.main.async {
                self.image = cachedImage as? UIImage
                return
            }
        }
        
        let task = URLSession.shared.dataTask(with: url) { [weak self] (data, response, error) in
            guard let data = data else {
                return
            }
            if let image = UIImage(data: data) {
                imageCache.setObject(image, forKey: url.absoluteString as NSString)
                DispatchQueue.main.async {
                    self?.image = image
                }
            }
        }
        task.resume()
    }
}
