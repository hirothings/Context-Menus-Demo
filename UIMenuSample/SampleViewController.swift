//
//  SampleViewController.swift
//  UIMenuSample
//
//  Created by hirothings on 2019/06/18.
//  Copyright © 2019 hirothings. All rights reserved.
//

import UIKit

class SampleViewController: UIViewController {
    @IBOutlet weak var imageView: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Simple View"
        
        imageView.isUserInteractionEnabled = true
        let interaction = UIContextMenuInteraction(delegate: self)
        imageView.addInteraction(interaction)
    }
}

extension SampleViewController: UIContextMenuInteractionDelegate {
    func contextMenuInteraction(_ interaction: UIContextMenuInteraction, configurationForMenuAtLocation location: CGPoint) -> UIContextMenuConfiguration? {
        
        let actionProvider: ([UIMenuElement<UIAction>]) -> UIMenu<UIAction>? = { _ in
            let share = UIAction(__title: "Share", image: UIImage(systemName: "square.and.arrow.up")) { _ in
                // some action
            }
            let editMenu: UIMenu<UIAction> = {
                let copy = UIAction(__title: "Copy", image: nil) { _ in
                    // some action
                }
                let delete = UIAction(__title: "Delete", image: UIImage(systemName: "trash"), options: [.destructive]) { _ in
                    // some action
                }
                return UIMenu<UIAction>.create(title: "Edit..", children: [copy, delete])
            }()
            
            return UIMenu<UIAction>.create(title: "Edit", children: [share, editMenu])
        }
        
        return UIContextMenuConfiguration(identifier: nil,
                                          previewProvider: nil,
                                          actionProvider: actionProvider)
    }
}
