//
//  SampleViewController.swift
//  ContextMenusSample
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
        
        let actionProvider: ([UIMenuElement]) -> UIMenu? = { _ in
            let share = UIAction(title: "Share", image: UIImage(systemName: "square.and.arrow.up"), identifier: UIAction.Identifier(rawValue: "share")) { _ in
                // some action
            }
            let editMenu: UIMenu = {
                let copy = UIAction(title: "Copy", image: nil, identifier: UIAction.Identifier(rawValue: "copy")) { _ in
                    // some action
                }
                let delete = UIAction(title: "Delete", image: UIImage(systemName: "trash"), identifier: UIAction.Identifier("delete")) { _ in
                    // some action
                }
                delete.attributes = [.destructive]
                return UIMenu(title: "Edit..", image: nil, identifier: nil, children: [copy, delete])
            }()
            
            return UIMenu(title: "Edit..", image: nil, identifier: nil, children: [share, editMenu])
        }
        
        return UIContextMenuConfiguration(identifier: nil,
                                          previewProvider: nil,
                                          actionProvider: actionProvider)
    }
}
