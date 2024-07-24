//
//  UIViewExtension.swift
//  Su Gitti
//
//  Created by Ozan Çiçek on 21.07.2024.
//

import Foundation
import UIKit



extension UIView {
    
    //.layerMaxXMinYCorner - topRight
    //.layerMinXMinYCorner - topLeft
    //.layerMaxXMaxYCorner - bottomLeft
    //.layerMinXMaxYCorner - bottomRight
    
    func applyCornerRadiusWithShadow(
        cornerRadius: CGFloat = 10,
        shadowColor: UIColor = .black,
        shadowOffset: CGSize = CGSize(width: 0.5, height: 0.5),
        shadowRadius: CGFloat = 1,
        shadowOpacity: Float = 0.5,
        roundedCorners: CACornerMask = [.layerMinXMinYCorner, .layerMaxXMinYCorner, .layerMinXMaxYCorner, .layerMaxXMaxYCorner]
    ) {
        let containerView = UIView()
        containerView.translatesAutoresizingMaskIntoConstraints = false
        containerView.layer.cornerRadius = cornerRadius
        containerView.layer.maskedCorners = roundedCorners
        containerView.layer.shadowColor = shadowColor.cgColor
        containerView.layer.shadowOffset = shadowOffset
        containerView.layer.shadowRadius = shadowRadius
        containerView.layer.shadowOpacity = shadowOpacity
        containerView.layer.masksToBounds = false
        
        if let superview = self.superview {
            superview.addSubview(containerView)
            containerView.addSubview(self)
            
            NSLayoutConstraint.activate([
                containerView.centerXAnchor.constraint(equalTo: self.centerXAnchor),
                containerView.centerYAnchor.constraint(equalTo: self.centerYAnchor),
                containerView.widthAnchor.constraint(equalTo: self.widthAnchor),
                containerView.heightAnchor.constraint(equalTo: self.heightAnchor),
                self.leadingAnchor.constraint(equalTo: containerView.leadingAnchor),
                self.trailingAnchor.constraint(equalTo: containerView.trailingAnchor),
                self.topAnchor.constraint(equalTo: containerView.topAnchor),
                self.bottomAnchor.constraint(equalTo: containerView.bottomAnchor)
            ])
            
            self.layer.cornerRadius = cornerRadius
            self.layer.maskedCorners = roundedCorners
            self.layer.masksToBounds = true
        }
    }
}
