//
//  FilmCollectionViewCell.swift
//  MoviesFinder
//
//  Created by Long Vo on 15/03/2023.
//

import UIKit
import SDWebImage

class FilmCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak private var filmTitle: UILabel!
    @IBOutlet weak private var filmImageView: UIImageView!
    override func awakeFromNib() {
        super.awakeFromNib()
        filmImageView.layer.cornerRadius = 10
    }
    
    func loadCell(_ film: Film) {
        filmTitle.text = film.title
        if let url = URL(string: film.poster) {
            filmImageView.sd_setImage(with: url, placeholderImage: UIImage(named: "place_holder"))
        }
    }
}
