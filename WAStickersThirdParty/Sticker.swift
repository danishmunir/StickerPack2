//
//  Sticker.swift
//  StickerApp
//
//  Created by Jigar Thakkar on 20/06/20.
//  Copyright © 2020 WhatsApp. All rights reserved.
//

import UIKit

struct StickerEmojis {

    static func canonicalizedEmojis(rawEmojis: [String]?) throws -> [String]? {

        guard let rawEmojis = rawEmojis else { return nil }

        if rawEmojis.count > Limits.MaxEmojisCount {
          throw StickerPackError.tooManyEmojis
        }

        var canonicalizedEmojis: [String] = []

        rawEmojis.forEach { rawEmoji in

          var emojiToAdd = canonicalizedEmoji(emoji: rawEmoji)

          // If the emoji somehow isn't canonicalized, we'll use the original emoji
          if emojiToAdd.isEmpty {
            emojiToAdd = rawEmoji
          }

          canonicalizedEmojis.append(emojiToAdd)
        }

        return canonicalizedEmojis
    }

    private static func canonicalizedEmoji(emoji: String) -> String {
        var nonExtensionUnicodes: [Character] = []

        for scalar in emoji.unicodeScalars {
            switch scalar.value {
            case 0x1F600...0x1F64F,    // Emoticons
            0x1F300...0x1F5FF,         // Misc symbols and pictographs
            0x1F680...0x1F6FF,         // Transport and maps
            0x2600...0x26FF,           // Misc symbols
            0x2700...0x27BF,           // Dingbats
            0x1F1E6...0x1F1FF,         // Flags
            0x1F900...0x1F9FF,         // Supplemental symbols and pictographs
            0x200D:                    // Zero-width joiner
                nonExtensionUnicodes.append(Character(UnicodeScalar(scalar.value)!))

            default:
                continue
            }
        }

        var canonicalizedEmoji = ""

        nonExtensionUnicodes.forEach { canonicalizedEmoji.append($0) }
        return canonicalizedEmoji
    }
}

/**
 *  Main class that deals with each individual sticker.
 */
class Sticker {

    let imageData: ImageData
    let emojis: [String]?

    var bytesSize: Int64 {
        return imageData.bytesSize
    }

    /**
     *  Initializes a sticker with an image file and emojis.
     *
     *  - Parameter filename: name of the image in the bundle, including extension. Must be either png or webp.
     *  - Parameter emojis: emojis associated with this sticker.
     *
     *  - Throws:
     - .fileNotFound if file has not been found
     - .unsupportedImageFormat if image is not png or webp
     - .imageTooBig if the image file size is above the supported limit (100KB)
     - .incorrectImageSize if the image is not within the allowed size
     - .animatedImagesNotSupported if the image is animated
     - .tooManyEmojis if there are too many emojis assigned to the sticker
     */
    init(contentsOfFile filename: String, emojis: [String]?) throws {
        self.imageData = try ImageData.imageDataIfCompliant(contentsOfFile: filename, isTray: false)
        self.emojis = try StickerEmojis.canonicalizedEmojis(rawEmojis: emojis)
    }

    /**
     *  Initializes a sticker with image data, type and emojis.
     *
     *  - Parameter imageData: Data of the image. Must be png or webp encoded data
     *  - Parameter type: format type of the sticker (png or webp)
     *  - Parameter emojis: array of emojis associated with this sticker.
     *
     *  - Throws:
     - .imageTooBig if the image file size is above the supported limit (100KB)
     - .incorrectImageSize if the image is not within the allowed size
     - .animatedImagesNotSupported if the image is animated
     - .tooManyEmojis if there are too many emojis assigned to the sticker
     */
    init(imageData: Data, type: ImageDataExtension, emojis: [String]?) throws {
        self.imageData = try ImageData.imageDataIfCompliant(rawData:imageData, extensionType: type, isTray: false)
        self.emojis = try StickerEmojis.canonicalizedEmojis(rawEmojis: emojis)
    }

    func copyToPasteboardAsImage() {
        if let image = imageData.image {
            Interoperability.copyImageToPasteboard(image: image)
        }
    }
}
