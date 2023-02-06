//
//  ImageFetcher.swift
//  Disneydex
//
//  Created by Miguel Diaz on 2/6/23.
//

import Foundation
import UIKit.UIImage

class ImageFetcher {
    static let shared: ImageFetcher = ImageFetcher()
    private init() {}
    
    private var cache = NSCache<NSString, UIImage>()
    
    func image(url: URL, completion: ((UIImage?) -> Void)?) {
        if let image = cache.object(forKey: url.absoluteString as NSString) {
            completion?(image)
            return
        }
        
        URLSession.shared.dataTask(with: url) { [weak self] data, response, error in
            guard
                let data = data,
                let image = UIImage(data: data)
            else {
                completion?(nil)
                return
            }
            
            //cache image
            self?.cache.setObject(image, forKey: url.absoluteString as NSString)
            DispatchQueue.main.async {
                completion?(image)
            }
        }.resume()
    }
}
