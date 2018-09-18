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
    
    var imageEndPoint: String? {
        didSet {
            if let endPoint = imageEndPoint {
                loadImage(from: endPoint)
            }
        }
    }
    
    private let activityIndicatorView: UIActivityIndicatorView = {
        let aiv = UIActivityIndicatorView(activityIndicatorStyle: .whiteLarge)
        aiv.translatesAutoresizingMaskIntoConstraints = false
        return aiv
    }()
    
    override func layoutSubviews() {
        self.contentMode = .scaleAspectFill
        self.layer.masksToBounds = true
        
        activityIndicatorView.removeFromSuperview()
        
        addSubview(activityIndicatorView)
        NSLayoutConstraint.activate([
            activityIndicatorView.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            activityIndicatorView.centerYAnchor.constraint(equalTo: self.centerYAnchor),
            ])
        
        activityIndicatorView.startAnimating()
        
        if let endPoint = imageEndPoint {
            loadImage(from: endPoint)
        }
    }
    
    private func loadImage(from endPoint: String) {

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
