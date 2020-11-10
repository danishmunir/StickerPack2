//
//  AquaButton.swift
//  StickerApp
//
//  Created by Jigar Thakkar on 20/06/20.
//  Copyright © 2020 WhatsApp. All rights reserved.
//

import UIKit

class RoundedButton: UIButton {
    override init(frame: CGRect) {
        super.init(frame: frame)

        adjustsImageWhenHighlighted = false

        layer.masksToBounds = true
        layer.cornerRadius = 10.0

        titleLabel?.font = .boldSystemFont(ofSize: titleLabel!.font.pointSize)
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

class AquaButton: RoundedButton {

    override var isHighlighted: Bool {
        get {
            return super.isHighlighted
        }

        set (newHighlighted) {
            super.isHighlighted = newHighlighted

            imageView?.tintColor = newHighlighted ? UIColor.white.withAlphaComponent(0.5) : .white
        }
    }
    
    override var isEnabled: Bool {
        didSet{
            if isEnabled {
                imageView!.tintColor = .white
            } else {
                imageView!.tintColor = .lightGray
            }
        }
    }

    override init(frame: CGRect) {
        super.init(frame: frame)

        adjustsImageWhenHighlighted = false

        backgroundColor = UIColor(red: 0.0, green: 0.5, blue: 1.0, alpha: 1.0)

        imageView!.tintColor = .white
        setTitleColor(UIColor.white.withAlphaComponent(0.5), for: .highlighted)
        setTitleColor(UIColor.lightGray.withAlphaComponent(1.0), for: .disabled)
        imageEdgeInsets.left = -25
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

class GrayRoundedButton: RoundedButton {
    private let aquaColor: UIColor = UIColor(red: 0.0, green: 0.5, blue: 1.0, alpha: 1.0)

    override var isHighlighted: Bool {
        get {
            return super.isHighlighted
        }

        set (newHighlighted) {
            super.isHighlighted = newHighlighted

            imageView?.tintColor = newHighlighted ? aquaColor.withAlphaComponent(0.5) : aquaColor
        }
    }
    
    override var isEnabled: Bool {
        didSet{
            if isEnabled {
                tintColor = UIColor.white
            } else {
                tintColor = UIColor.gray
            }
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)

        adjustsImageWhenHighlighted = false

        backgroundColor = UIColor(red: 0.973, green: 0.969, blue: 0.988, alpha: 1.0)
        layer.borderColor = UIColor.black.withAlphaComponent(0.1).cgColor
        layer.borderWidth = 1.0

        imageView!.tintColor = aquaColor
        setTitleColor(aquaColor, for: .normal)
        setTitleColor(aquaColor.withAlphaComponent(0.5), for: .highlighted)
        imageEdgeInsets.left = -25
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
