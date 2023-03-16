//
//  UICollectionView+Extension.swift
//  MoviesFinder
//
//  Created by Long Vo on 15/03/2023.
//

import Foundation
import UIKit

extension UICollectionView {
    func registerClass(of cell: UICollectionViewCell.Type) {
        register(cell, forCellWithReuseIdentifier: cell.identifier)
    }
    
    func registerNib(of cell: UICollectionViewCell.Type) {
        let identifier = cell.identifier
        let nib: UINib = cell.nib
        register(nib, forCellWithReuseIdentifier: identifier)
    }
    
    func dequeueReusableCell<T: UICollectionViewCell>(cellClass: T.Type, for indexPath: IndexPath) -> T {
        let identifier = cellClass.identifier
        guard let cell = dequeueReusableCell(withReuseIdentifier: identifier, for: indexPath) as? T else {
            fatalError("Can't dequeue reusable cell with \(T.description())")
        }
        return cell
    }
}
