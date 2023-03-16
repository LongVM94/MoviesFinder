//
//  FilmListViewModel.swift
//  MoviesFinder
//
//  Created by Long Vo on 15/03/2023.
//

import Foundation


class FilmListViewModel {
    var listFilmCallback: () -> Void = {}
    private var listFilm: [Film] = []

    private var isLoadMore = false
    private var limtPerPage = 10
    
    func getList(name: String) {
        let page = Int(listFilm.count/limtPerPage) + 1
        print("page \(page)")
        APIService.share.request(.getFilmList(name, page), responseObjectType: Search.self) { [weak self] result in
            guard let self = self else {return}
            if result.response == "True" {
                self.isLoadMore = !(result.search.count < self.limtPerPage)
                self.listFilm += result.search
            } else {
                self.isLoadMore = false
                self.listFilm = []
            }
            print("isLoadMore \(self.isLoadMore)")
            self.listFilmCallback()
        } failure: { [weak self] error in
            self?.isLoadMore = false
            self?.listFilm = []
            self?.listFilmCallback()
        }
    }
    
    var numberOfFilms: Int {
        return listFilm.count
    }
    
    var numberOfItemsInSection: Int {
        let listCount = numberOfFilms
        if isLoadMore {
            return listCount + 1
        }
        return listCount
    }
    
    func film(index: Int) -> Film? {
        return listFilm[index]
    }
}
