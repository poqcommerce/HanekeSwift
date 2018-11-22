//
//  Format.swift
//  Haneke
//
//  Created by Hermes Pique on 8/27/14.
//  Copyright (c) 2014 Haneke. All rights reserved.
//

import UIKit

public struct Format<T> {
    
    public let name: String
    
    public let diskCapacity : UInt64
    
    public var transform : ((T) -> (T))?
    
    public var convertToData : ((T) -> Data)?

    public init(name: String, diskCapacity : UInt64 = UINT64_MAX, transform: ((T) -> (T))? = nil) {
        self.name = name
        self.diskCapacity = diskCapacity
        self.transform = transform
    }
    
    public func apply(_ value : T) -> T {
        var transformed = value
        if let transform = self.transform {
            transformed = transform(value)
        }
        return transformed
    }
    
    var isIdentity : Bool {
        return self.transform == nil
    }

}

public struct ImageResizer {
    
    public enum ScaleMode: String {
        case Fill = "fill", AspectFit = "aspectfit", AspectFill = "aspectfill", None = "none"
    }
    
    public typealias T = UIImage
    
    public let allowUpscaling : Bool
    
    public let size : CGSize
    
    public let scaleMode: ScaleMode
    
    public let compressionQuality : Float
    
    public init(size: CGSize = CGSize.zero, scaleMode: ScaleMode = .None, allowUpscaling: Bool = true, compressionQuality: Float = 1.0) {
        self.size = size
        self.scaleMode = scaleMode
        self.allowUpscaling = allowUpscaling
        self.compressionQuality = compressionQuality
    }
    
    public func resizeImage(_ image: UIImage) -> UIImage {
        // Make sure we have non-zero size
        guard size.width > 0, size.height > 0, image.size.width > 0, image.size.height > 0 else {
            return image
        }
        
        var resizeToSize: CGSize
        switch scaleMode {
        case .Fill:
            resizeToSize = size
        case .AspectFit:
            resizeToSize = image.size.hnk_aspectFitSize(size)
        case .AspectFill:
            resizeToSize = image.size.hnk_aspectFillSize(size)
        case .None:
            return image
        }
        
        // If does not allow to scale up the image
        if (!self.allowUpscaling) {
            if (resizeToSize.width > image.size.width || resizeToSize.height > image.size.height) {
                return image
            }
        }
        
        // Avoid unnecessary computations
        if (resizeToSize.width == image.size.width && resizeToSize.height == image.size.height) {
            return image
        }
        
        if let resizedImage = image.hnk_imageByScaling(toSize: resizeToSize) {
            return resizedImage
        }
        
        return image
    }
}
