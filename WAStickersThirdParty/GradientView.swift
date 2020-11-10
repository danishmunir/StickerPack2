//
//  GradientView.swift
//  StickerApp
//
//  Created by Jigar Thakkar on 20/06/20.
//  Copyright © 2020 WhatsApp. All rights reserved.
//

import UIKit

class GradientView: UIView {

    override var layer: CAGradientLayer {
        return super.layer as! CAGradientLayer
    }

    convenience init(topColor: UIColor, bottomColor: UIColor) {
        self.init(frame: .zero)

        backgroundColor = .clear

        layer.startPoint = CGPoint(x: 0.5, y: 0.0)
        layer.endPoint = CGPoint(x: 0.5, y: 1.0)

        layer.colors = [topColor.cgColor, bottomColor.cgColor]
    }

    override class var layerClass: AnyClass {
        return CAGradientLayer.self
    }

}
