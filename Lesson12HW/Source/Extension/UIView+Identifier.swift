//
//  UIView+Identifier.swift
//  Lesson12HW
//

//

import UIKit

extension UIView {
    
    var reuseIdentifier: String {
        get {
            return String(describing: self)
        }
    }
}
