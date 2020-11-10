//
//  AllStickerPacksViewController.swift
//  StickerApp
//
//  Created by Jigar Thakkar on 20/06/20.
//  Copyright © 2020 WhatsApp. All rights reserved.
//

import UIKit

class AllStickerPacksViewController: UIViewController {

    @IBOutlet private weak var stickerPacksTableView: UITableView!
    @IBOutlet weak var topView: UIView!
    private var needsFetchStickerPacks = true
    private var stickerPacks: [StickerPack] = []
    private var selectedIndex: IndexPath?

    @objc func topViewTapped(){
        
        if let url = URL(string: "itms-apps://apple.com/app/id1524062886") {
            UIApplication.shared.open(url)
        }
        
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        let tap = UITapGestureRecognizer(target: self, action: #selector(topViewTapped))
        topView.addGestureRecognizer(tap)
        if #available(iOS 11.0, *) {
            navigationItem.largeTitleDisplayMode = .automatic
        }
        navigationController?.navigationBar.shadowImage = UIImage()
        navigationController?.navigationBar.alpha = 0.0
        stickerPacksTableView.register(UINib(nibName: "StickerPackTableViewCell", bundle: nil), forCellReuseIdentifier: "StickerPackCell")
        stickerPacksTableView.tableFooterView = UIView()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.navigationBar.isHidden = true
        if let selectedIndex = selectedIndex {
            stickerPacksTableView.deselectRow(at: selectedIndex, animated: true)
        }
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(true)
        navigationController?.navigationBar.isHidden = false
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        self.needsFetchStickerPacks = false
        self.fetchStickerPacks()
        
    }

    private func fetchStickerPacks() {
        let loadingAlert = UIAlertController(title: "Loading stickers", message: "\n\n", preferredStyle: .alert)
        loadingAlert.addSpinner()
        present(loadingAlert, animated: true)
        do {
            try StickerPackManager.fetchStickerPacks(fromJSON: StickerPackManager.stickersJSON(contentsOfFile: "sticker_packs")) { stickerPacks in
                loadingAlert.dismiss(animated: false) {
                    self.navigationController?.navigationBar.alpha = 1.0
                    if stickerPacks.count > 1 {
                        self.stickerPacks = stickerPacks
                        self.stickerPacksTableView.reloadData()
                    } else {
                        self.show(stickerPack: stickerPacks[0], animated: false)
                    }
                }
            }
        } catch StickerPackError.fileNotFound {
            fatalError("sticker_packs.wasticker not found.")
        } catch {
            fatalError(error.localizedDescription)
        }
    }

    private func show(stickerPack: StickerPack, animated: Bool) {
        // "stickerPackNotAnimated" still animates the push transition on iOS 8 and earlier.
        let identifier = animated ? "stickerPackAnimated" : "stickerPackNotAnimated"
        performSegue(withIdentifier: identifier, sender: stickerPack)
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let vc = segue.destination as? StickerPackViewController,
            let stickerPack = sender as? StickerPack {
            vc.title = stickerPack.name
            vc.stickerPack = stickerPack
            vc.navigationItem.hidesBackButton = stickerPacks.count <= 1
        }
    }

    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        if let navigationBar = navigationController?.navigationBar {

            let contentInset: UIEdgeInsets = {
                if #available(iOS 11.0, *) {
                    return scrollView.adjustedContentInset
                } else {
                    return scrollView.contentInset
                }
            }()

            if scrollView.contentOffset.y <= -contentInset.top {
                navigationBar.shadowImage = UIImage()
            } else {
                navigationBar.shadowImage = nil
            }
        }
    }

    @objc func addButtonTapped(button: UIButton) {
        let loadingAlert: UIAlertController = UIAlertController(title: "Sending to WhatsApp", message: "\n\n", preferredStyle: .alert)
        loadingAlert.addSpinner()
        present(loadingAlert, animated: true)

        stickerPacks[button.tag].sendToWhatsApp { completed in
            loadingAlert.dismiss(animated: true)
        }
    }
}

// MARK: - UITableViewDelegate

extension AllStickerPacksViewController: UITableViewDelegate {

  func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
      selectedIndex = indexPath

      show(stickerPack: stickerPacks[indexPath.row], animated: true)
  }
}

// MARK: - UITableViewDataSource

extension AllStickerPacksViewController: UITableViewDataSource {

  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
      return stickerPacks.count
  }

  func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
      return 125
  }

  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
      guard let cell: StickerPackTableViewCell = tableView.dequeueReusableCell(withIdentifier: "StickerPackCell") as? StickerPackTableViewCell else { return UITableViewCell() }
      cell.stickerPack = stickerPacks[indexPath.row]
    cell.contentView.setCardView()
//      let addButton = UIButton(type: .contactAdd)
//      addButton.tag = indexPath.row
//      addButton.isEnabled = Interoperability.canSend()
//      addButton.addTarget(self, action: #selector(addButtonTapped(button:)), for: .touchUpInside)
//      cell.accessoryView = addButton
    cell.selectionStyle = .none
      return cell
  }
}

extension UIView {

    func setCardView(){
        layer.cornerRadius = 5.0
        layer.borderColor  =  UIColor.clear.cgColor
        layer.borderWidth = 5.0
        layer.shadowOpacity = 0.5
        layer.shadowColor =  UIColor.lightGray.cgColor
        layer.shadowRadius = 5.0
        layer.shadowOffset = CGSize(width:5, height: 5)
        layer.masksToBounds = true
    }
}
