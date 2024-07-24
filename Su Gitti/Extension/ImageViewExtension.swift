//
//  ImageViewExtension.swift
//  Su Gitti
//
//  Created by Ozan Çiçek on 20.07.2024.
//

import Foundation
import UIKit


extension UIImageView {
    func addgesture(target: Any?, action: Selector) {
        let gesture = UITapGestureRecognizer(target: target, action: action)
        self.isUserInteractionEnabled = true
        self.addGestureRecognizer(gesture)
    }
}
