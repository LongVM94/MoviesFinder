//
//  FilmListViewController.swift
//  MoviesFinder
//
//  Created by Long Vo on 15/03/2023.
//

import UIKit

class FilmListViewController: UIViewController {
    @IBOutlet weak private var searchBar: UISearchBar!
    @IBOutlet weak private var filmCollectionView: UICollectionView!
    
    private let viewModel = FilmListViewModel()
    private var isTyping = true

    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
        handleCallback()
    }

    private func handleCallback() {
        viewModel.listFilmCallback = { [weak self] in
            self?.filmCollectionView.reloadData()
        }
    }
    private func setup() {
        filmCollectionView.registerNib(of: FilmCollectionViewCell.self)
        filmCollectionView.registerNib(of: LoadMoreCell.self)

        let layout = UICollectionViewFlowLayout()
        let width = filmCollectionView.bounds.width/2
        let height = width * 3/4
        let size = CGSize(width: width, height: height)
        layout.itemSize = size
        layout.minimumInteritemSpacing = 0
        layout.minimumLineSpacing = 0
        filmCollectionView.collectionViewLayout = layout
        searchBar.delegate = self
    }
}

extension FilmListViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel.numberOfItemsInSection
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let numberOfFilms = viewModel.numberOfFilms
        if indexPath.item == numberOfFilms {
            let cell = collectionView.dequeueReusableCell(cellClass: LoadMoreCell.self, for: indexPath)
            perform(#selector(search), with: nil, afterDelay: 1)
            return cell
        }
        let cell = collectionView.dequeueReusableCell(cellClass: FilmCollectionViewCell.self, for: indexPath)
        if let film = viewModel.film(index: indexPath.row) {
            cell.loadCell(film)
        }
        return cell
        
    }
    
    @objc private func search() {
        viewModel.getList(name: searchBar.text ?? "")
    }
}

extension FilmListViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        if indexPath.item == viewModel.numberOfFilms {
            let width = filmCollectionView.bounds.width
            let height = 60.0
            return CGSize(width: width, height: height)
        }
        let width = filmCollectionView.bounds.width/2
        let height = width * 3/4
        return CGSize(width: width, height: height)
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {

        if let sectionHeader = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: "SectionHeader", for: indexPath) as? SectionHeader{
//            sectionHeader.sectionHeaderlabel.text = "Section \(indexPath.section)"
            return sectionHeader
        }
        return UICollectionReusableView()
    }
}

extension FilmListViewController: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        perform(#selector(search), with: nil, afterDelay: 2)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        return CGSize(width: collectionView.frame.width, height: 40)
    }
}
