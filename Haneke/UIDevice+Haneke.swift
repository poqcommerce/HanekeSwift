//
//  UIDevice+Haneke.swift
//  Haneke
//
//  Created by GabrielMassana on 17/06/2021.
//  Copyright © 2021 Haneke. All rights reserved.
//

import UIKit

extension UIDevice {

    func freeDiskSpaceInBits() -> UInt64 {
        do {
            guard let totalDiskSpaceInBytes = try FileManager.default.attributesOfFileSystem(forPath: NSHomeDirectory())[FileAttributeKey.systemFreeSize] as? UInt64 else {
                return 0
            }
            return totalDiskSpaceInBytes
        } catch {
            return 0
        }
    }
    
    // Calculate cache capacity based on the free space on the device.
    // If free space can not be calculated, set 512MB as the Cache capacity
    class func calculateCapacity() -> UInt64 {
        let bits = UIDevice.current.freeDiskSpaceInBits()
        let bytes = bits / 8
        let capacity = bytes / 20 // 5% of free space on disk
        let half: UInt64 = 1024 * 1024 * 1024 // 1GB of disk space
        return UInt64(bits == 0 ? half : capacity)
    }
}
