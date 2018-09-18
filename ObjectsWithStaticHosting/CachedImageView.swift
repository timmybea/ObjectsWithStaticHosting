//
//  CachedImageView.swift
//  ObjectsWithStaticHosting
//
//  Created by Tim Beals on 2018-09-18.
//  Copyright © 2018 Roobi Creative. All rights reserved.
//

import UIKit

class CachedImageView: UIImageView {
    
    static let imageCache = NSCache<AnyObject, AnyObject>()
    
    var imageEndPoint: String?
    
    let activityIndicatorView: UIActivityIndicatorView = {
        let aiv = UIActivityIndicatorView(activityIndicatorStyle: .whiteLarge)
        aiv.translatesAutoresizingMaskIntoConstraints = false
        aiv.startAnimating()
        return aiv
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        addSubview(activityIndicatorView)
        NSLayoutConstraint.activate([
            activityIndicatorView.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            activityIndicatorView.centerYAnchor.constraint(equalTo: self.centerYAnchor),
            ])
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    func loadImage(from endPoint: String) {
        
        self.imageEndPoint = endPoint

        if let imageFromCache = type(of: self).imageCache.object(forKey: endPoint as AnyObject) as? UIImage {
            self.image = imageFromCache
            activityIndicatorView.stopAnimating()
            return
        }
        
        APIService.fetchData(with: .image(endPoint: endPoint)) { (data, error) in
            
            guard error == nil else {
                print(error!.localizedDescription)
                return
            }
            
            DispatchQueue.main.async {
                
                let imageToCache = UIImage(data: data!)
                
                if self.imageEndPoint == endPoint {
                    self.image = imageToCache
                    self.activityIndicatorView.stopAnimating()
                }
                
                type(of: self).imageCache.setObject(imageToCache!, forKey: endPoint as AnyObject)
            }
            
        }
    }
}
