//
//  MovieListVC.swift
//  MovieBucket
//
//  Created by Olijujuan Green on 5/21/20.
//  Copyright © 2020 Olijujuan Green. All rights reserved.
//

import UIKit

class MovieListVC: UIViewController {
    
    enum Section { case main }
    
    var collectionView: UICollectionView!
    var dataSource: UICollectionViewDiffableDataSource<Section, Movie>!
    
    var movies          : [Movie]   = []
    var filteredMovies  : [Movie]   = []
    var searchQuery     : String    = QueryStrings.topRated
    var page            = 1
    var areMoreMovies   = true
    var isSearching     = false
    
    
    

    override func viewDidLoad() {
        super.viewDidLoad()
        configureViewController()
        configureCollectionView()
        getMovies(for: searchQuery, page: page)
        configureDataSource()
        configureSearchController()
    }
    
    
    
    
    
    
    func configureViewController() {
        navigationController?.navigationBar.prefersLargeTitles = true
        view.backgroundColor = .systemBackground
    }
    
    func getMovies(for queryString: String, page: Int) {
        displayLoadingView()
        NetworkManager.shared.getMovies(for: searchQuery, page: page) { [weak self] (movies, error) in
            guard let self = self else { return }
            self.dismissLoadingView()
            
            guard let movies = movies else { return }
            if movies.count < 20 { self.areMoreMovies = false }
            
            self.movies.append(contentsOf: movies)
            self.searchQuery = queryString
            self.updateData(on: self.movies)
        }
    }
    
    func configureSearchController() {
        let searchController                    = UISearchController()
        searchController.searchResultsUpdater   = self
        searchController.searchBar.delegate     = self
        searchController.searchBar.placeholder  = "Movie Search"
        navigationItem.searchController         = searchController
    }
    
    func configureCollectionView() {
        collectionView  = UICollectionView(frame: view.bounds, collectionViewLayout: UIHelper.createFlowLayout(for: view))
        collectionView.backgroundColor = .clear
        collectionView.delegate = self
        view.addSubview(collectionView)
        
        collectionView.register(MovieCell.self, forCellWithReuseIdentifier: MovieCell.reuseId)
    }
    
    func configureDataSource() {
        dataSource = UICollectionViewDiffableDataSource<Section, Movie>(collectionView: collectionView, cellProvider: { (collectionView, indexPath, Movie) -> UICollectionViewCell? in
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: MovieCell.reuseId, for: indexPath) as! MovieCell
            cell.setMovie(movie: Movie)
            return cell
        })
    }
    
    func updateData(on movies: [Movie]) {
        var snapshotp = NSDiffableDataSourceSnapshot<Section, Movie>()
        snapshotp.appendSections([.main])
        snapshotp.appendItems(movies)
        DispatchQueue.main.async { self.dataSource.apply(snapshotp, animatingDifferences: true) }
    }


}









extension MovieListVC: UISearchResultsUpdating, UISearchBarDelegate {
    
    func updateSearchResults(for searchController: UISearchController) {
        guard let filter = searchController.searchBar.text, !filter.isEmpty else { return }
        isSearching = true
        
        filteredMovies = movies.filter { $0.title.lowercased().contains(filter.lowercased()) }
        updateData(on: filteredMovies)
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        updateData(on: movies)
        isSearching = false
    }
    
}




extension MovieListVC: UICollectionViewDelegate {
    
    func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
        let offsetY         = scrollView.contentOffset.y
        let contentHeight   = scrollView.contentSize.height
        let height          = scrollView.frame.size.height
        
        if offsetY > contentHeight - height {
            guard areMoreMovies else { return }
            page += 1
            getMovies(for: searchQuery, page: page)
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let activeArray         = isSearching ? filteredMovies : movies
        let movie               = activeArray[indexPath.item]
        
        let movieDetailVC       = MovieDetailVC()
        movieDetailVC.queryId   = movie.id
        let navController       = UINavigationController(rootViewController: movieDetailVC)
        self.present(navController, animated: true)
    }
    
}

