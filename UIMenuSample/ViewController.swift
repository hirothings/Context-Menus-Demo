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
        UIImage(named: "image2")!
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
        flowLayout.itemSize = CGSize(width: 103.5, height: 103.5)
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
}
