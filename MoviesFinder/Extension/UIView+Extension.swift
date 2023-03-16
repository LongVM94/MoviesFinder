//
//  UIView+Extension.swift
//  MoviesFinder
//
//  Created by Long Vo on 15/03/2023.
//

import UIKit

public extension UIView {
    class var identifier: String {
        get {
            return String(describing: self)
        }
    }
    
    class var nib: UINib {
        get {
            let nibName = String(describing: self)
            let bundle = Bundle(for: self)
            return UINib(nibName: nibName, bundle: bundle)
        }
    }
}
