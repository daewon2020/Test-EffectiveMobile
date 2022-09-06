//
//  ImageLoader.swift
//  Test-EffectiveMobile
//
//  Created by Константин Андреев on 28.08.2022.
//

import Foundation
import UIKit

final class ImageLoader {
    static var shared = ImageLoader()
    
    private var cacheImages: NSCache<NSString, UIImage> = NSCache()
    
    private init() { }
    
    func getImageFromCache(for url: String, completion: @escaping (UIImage?) -> Void){
        if let image = cacheImages.object(forKey: url as NSString) {
            completion(image)
        } else {
            NetworkManager.shared.fetchImage(with: url, comletion: { data in
                guard let image = UIImage(data: data) else { return }
                self.cacheImages.setObject(image, forKey: url as NSString)
                completion(image)
            })
        }
    }

    func clearCache() {
        cacheImages = NSCache()
    }

}
