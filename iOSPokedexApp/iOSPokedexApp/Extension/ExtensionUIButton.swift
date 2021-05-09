//
//  ExtensionUIButton.swift
//  iOSPokedexApp
//
//  Created by Lenin on 1/7/21.
//


import UIKit

// MARK: - UIButton Extension
extension UIButton {

    // Borde redondo
    func round() {
        layer.cornerRadius = bounds.height / 2
        //clipsToBounds = true
    }
    
    //shadow
    func shadow(colorShadow: UIColor) {
        
        layer.shadowOffset = CGSize(width: 0, height: 0)
        layer.shadowRadius = 10
        layer.shadowColor = colorShadow.cgColor
        layer.shadowOpacity = 0.7
    }
    
    // Rebote
    func bounce() {
        UIView.animate(withDuration: 0.1, animations: {
            self.transform = CGAffineTransform(scaleX: 1.1, y: 1.1)
        }) { (completion) in
            UIView.animate(withDuration: 0.1, animations: {
                self.transform = .identity
            })
        }
    }
    
    // Brilla
    func shine() {
        UIView.animate(withDuration: 0.1, animations: {
            self.alpha = 0.5
        }) { (completion) in
            UIView.animate(withDuration: 0.1, animations: {
                self.alpha = 1
            })
        }
    }
    
    // Salta
    func jump() {
        UIView.animate(withDuration: 0.1, animations: {
            self.transform = CGAffineTransform(translationX: 0, y: -10)
        }) { (completion) in
            UIView.animate(withDuration: 0.1, animations: {
                self.transform = .identity
            })
        }
    }
    
}

