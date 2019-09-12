//
//  CollectionViewController.swift
//  ContextMenusSample
//
//  Created by hirothings on 2019/06/17.
//  Copyright © 2019 hirothings. All rights reserved.
//

import UIKit

class CollectionViewController: UIViewController {
    @IBOutlet weak private var collectionView: UICollectionView!
    private let images: [UIImage] = [
        UIImage(named: "image1")!,
        UIImage(named: "image2")!,
        UIImage(named: "image3")!,
        UIImage(named: "image4")!,
        UIImage(named: "image5")!,
        UIImage(named: "image6")!,
        UIImage(named: "image7")!,
        UIImage(named: "image8")!
    ]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title = "CollectionView with Preview"
        
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.register(cellType: ImageCollectionViewCell.self)
        
        let flowLayout = UICollectionViewFlowLayout()
        flowLayout.scrollDirection = .vertical
        flowLayout.minimumLineSpacing = 0
        flowLayout.minimumInteritemSpacing = 0
        let width = self.view.bounds.width / 2
        flowLayout.itemSize = CGSize(width: width, height: width)
        collectionView.collectionViewLayout = flowLayout
    }
}

extension CollectionViewController: UICollectionViewDataSource, UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return images.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(with: ImageCollectionViewCell.self, for: indexPath)
        let width = self.view.bounds.width
        cell.setupImage(images[indexPath.row], size: CGSize(width: width, height: width))
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, contextMenuConfigurationForItemAt
        indexPath: IndexPath, point: CGPoint) -> UIContextMenuConfiguration? {
        
        let previewProvider: () -> PreviewViewController? = { [unowned self] in
            return PreviewViewController(image: self.images[indexPath.row])
        }
        
        let actionProvider: ([UIMenuElement]) -> UIMenu? = { _ in
            let share = UIAction(title: "Share", image: UIImage(systemName: "square.and.arrow.up"), identifier: UIAction.Identifier(rawValue: "share")) { _ in
                // some action
            }
            let editMenu: UIMenu = {
                let copy = UIAction(title: "Copy", image: nil, identifier: UIAction.Identifier(rawValue: "copy")) { _ in
                    // some action
                }
                let delete = UIAction(title: "Delete", image: UIImage(systemName: "trash"), identifier: UIAction.Identifier(rawValue: "delete")) { _ in
                    // some action
                }
                delete.attributes = [.destructive]
                return UIMenu(title: "Edit..", image: nil, identifier: nil, children: [copy, delete])
            }()
            
            return UIMenu(title: "Edit..", image: nil, identifier: nil, children: [share, editMenu])
        }
        
        return UIContextMenuConfiguration(identifier: nil,
                                          previewProvider: previewProvider,
                                          actionProvider: actionProvider)
    }
}
