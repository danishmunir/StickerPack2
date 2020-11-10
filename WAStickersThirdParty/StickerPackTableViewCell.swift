//
//  StickerPackTableViewCell.swift
//  StickerApp
//
//  Created by Jigar Thakkar on 20/06/20.
//  Copyright © 2020 WhatsApp. All rights reserved.
//

import UIKit

final class StickerPackTableViewCell: UITableViewCell, UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {

    @IBOutlet weak var backView: UIView!{
        didSet {
            backView.layer.cornerRadius = 10
            backView.layer.shadowOpacity = 0.5
            backView.layer.shadowRadius = 6
            backView.layer.shadowColor = UIColor(ciColor: .black).cgColor
            backView.layer.shadowOffset = CGSize(width: 3, height: 3)
            backView.backgroundColor = UIColor(ciColor: .white)
            backView.layer.masksToBounds = true
            }
    }
    private let cellLength: CGFloat = 48
    private let interimSpacing: CGFloat = 10

    @IBOutlet private weak var stickerPackTitleLabel: UILabel!
    @IBOutlet private weak var stickerPackDescriptionLabel: UILabel!
    @IBOutlet private weak var stickerPackCollectionView: UICollectionView!
    
    var stickerPack: StickerPack? {
        didSet {
            stickerPackTitle = stickerPack?.name
            stickerPackSecondaryInfo = stickerPack?.publisher
            stickerPackCollectionView.reloadData()
        }
    }

    var stickerPackTitle: String? {
        get {
            return stickerPackTitleLabel.text
        }
        set {
            stickerPackTitleLabel.text = newValue
        }
    }

    var stickerPackSecondaryInfo: String? {
        get {
            return stickerPackDescriptionLabel.text!
        }
        set {
            stickerPackDescriptionLabel.text = newValue
        }
    }

    override func awakeFromNib() {
        super.awakeFromNib()
        stickerPackCollectionView.dataSource = self
        stickerPackCollectionView.delegate = self
        stickerPackCollectionView.register(StickerCell.self, forCellWithReuseIdentifier: "StickerCell")
        backgroundColor = .clear
        
    }

    // MARK: Collectionview

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return interimSpacing;
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: cellLength, height: cellLength)
    }

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        guard let stickerPack = stickerPack else { return 0 }

        return stickerPack.stickers.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "StickerCell", for: indexPath) as! StickerCell
        if let sticker = stickerPack?.stickers[indexPath.row] {
            cell.sticker = sticker
        }
        return cell
    }
}
