//
//  LinkTableViewCell.swift
//  StickerApp
//
//  Created by Jigar Thakkar on 20/06/20.
//  Copyright © 2020 WhatsApp. All rights reserved.
//
import UIKit

class LinkTableViewCell: UITableViewCell {

    @IBOutlet private weak var linkLabel: UILabel!
    @IBOutlet private weak var linkImageView: UIImageView!

    var link: String?

    var linkTitle: String? {
        get {
            return linkLabel.text
        }

        set {
            linkLabel.text = newValue
        }
    }

    var linkImage: UIImage? {
        get {
            return linkImageView.image
        }

        set {
            linkImageView.image = newValue
        }
    }

}
