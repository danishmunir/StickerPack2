//
//  SecondaryTextTableViewCell.swift
//  StickerApp
//
//  Created by Jigar Thakkar on 20/06/20.
//  Copyright © 2020 WhatsApp. All rights reserved.
//

import UIKit

class SecondaryTextTableViewCell: UITableViewCell {

    @IBOutlet private weak var leftLabel: UILabel!
    @IBOutlet private weak var rightLabel: UILabel!
    @IBOutlet private weak var rightImageView: UIImageView!

    var primaryText: String? {
        get {
            return rightLabel.text
        }

        set {
            rightLabel.text = newValue
            rightImageView.image = nil
        }
    }

    var secondaryText: String? {
        get {
            return leftLabel.text
        }

        set {
            leftLabel.text = newValue
        }
    }

    var primaryImage: UIImage? {
        get {
            return rightImageView.image
        }

        set {
            rightImageView.image = newValue;
            rightLabel.text = nil
        }
    }
}
