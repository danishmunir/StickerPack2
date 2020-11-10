//
//  Limits.swift
//  StickerApp
//
//  Created by Jigar Thakkar on 20/06/20.
//  Copyright © 2020 WhatsApp. All rights reserved.
//


import UIKit

struct Limits {
    static let MaxStickerFileSize: Int = 100 * 2024
    //100 * 1024
    static let MaxTrayImageFileSize: Int = 50 * 1024

    static let TrayImageDimensions: CGSize = CGSize(width: 96, height: 96)
    static let ImageDimensions: CGSize = CGSize(width: 512, height: 512)

    static let MinStickersPerPack: Int = 3
    static let MaxStickersPerPack: Int = 56

    static let MaxCharLimit128: Int = 128

    static let MaxEmojisCount: Int = 3
}
