//
//  ViewController.swift
//  UIMenuSample
//
//  Created by hirothings on 2019/06/17.
//  Copyright © 2019 hirothings. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
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

extension ViewController: UICollectionViewDataSource, UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return images.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(with: ImageCollectionViewCell.self, for: indexPath)
        cell.setupImage(images[indexPath.row])
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, contextMenuConfigurationForItemAt indexPath: IndexPath, point: CGPoint) -> UIContextMenuConfiguration? {
        
        let previewProvider: () -> PreviewViewController? = { [unowned self] in
            return PreviewViewController(image: self.images[indexPath.row])
        }
        
        let actionProvider: ([UIMenuElement<UIAction>]) -> UIMenu<UIAction>? = { _ in
            let share = UIAction(__title: "Share", image: nil, options: .disabled) { _ in
                // no-op
            }
            let delete = UIAction(__title: "Delete", image: nil, options: .destructive) { _ in
                // no-op
            }
            return UIMenu<UIAction>.create(title: "Edit", children: [share, delete])
        }
        
        return UIContextMenuConfiguration(
            identifier: nil,
            previewProvider: previewProvider,
            actionProvider: actionProvider
        )
    }
}
