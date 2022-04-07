//
//  MovieDetailVC.swift
//  MovieBucket
//
//  Created by Olijujuan Green on 5/22/20.
//  Copyright © 2020 Olijujuan Green. All rights reserved.
//

import UIKit

class MovieDetailVC: UIViewController {
    var movie       : Movie?
    var queryId     : Int!
    var cast        : [Actor] = []
    
    let scrollView          = UIScrollView()
    let containerView       = UIView()
    let headerView          = UIView()
    let overviewTitleLabel  = UILabel()
    let overviewTextLabel   = UILabel()
    let castLabel           = UILabel()
    
    let castCollectionView: UICollectionView = {
        let layout                  = SnappingCollectionViewLayout()
        layout.scrollDirection      = .horizontal
        let colView                 = UICollectionView(frame: .zero, collectionViewLayout: layout)
        colView.decelerationRate    = .fast
        colView.backgroundColor     = .clear
        colView.layer.cornerRadius  = 10
        colView.translatesAutoresizingMaskIntoConstraints = false
        return colView
    }()
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        getMovieDetails(for: queryId)
        getCredits(for: queryId)
        configureNC()
        configureScrollView()
        layoutUI()
        configureCollectionView()
        
    }
    
    
    
    func configureNC() {
        let doneButton  = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(dismissDetailVC))
        navigationItem.leftBarButtonItem = doneButton
        let addButton   = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(addButtonTapped))
        
        navigationItem.rightBarButtonItem = addButton
        navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
        navigationController?.navigationBar.shadowImage = UIImage()
        let gradientBlackColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.8)
        navigationController?.navigationBar.setBackgroundGradient(firstColor: gradientBlackColor, secondColor: .clear)
    }
    
    func configureScrollView() {
        view.addSubview(scrollView)
        scrollView.addSubview(containerView)
        
        scrollView.frame                = view.bounds
        scrollView.backgroundColor      = .systemBackground
        scrollView.contentSize          = CGSize(width: view.frame.width, height: view.frame.height + 500)
        
        containerView.frame             = scrollView.bounds
        containerView.backgroundColor   = .systemBackground
        
        NSLayoutConstraint.activate([
            containerView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor),
            containerView.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor),
            containerView.topAnchor.constraint(equalTo: scrollView.topAnchor),
            containerView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor)
        ])
        
    }
    
    func getMovieDetails(for movieId: Int) {
        NetworkManager.shared.getMovieDetails(for: movieId) { [weak self] movie, error in
            guard let self              = self else { return }
            guard let retrievedMovie    = movie else { return }
            
            DispatchQueue.main.async {
                self.add(childVC: MBMovieDetailHeaderView(movie: retrievedMovie), to: self.headerView)
                self.overviewTextLabel.text = retrievedMovie.overview
            }
        }
    }
    
    func getCredits(for movieId: Int) {
        NetworkManager.shared.getCredits(for: movieId) { [weak self] actors, error in
            guard let self      = self else { return }
            guard let actors    = actors else { return }
            
            self.cast = actors
        }
    }
    
    func configureCollectionView() {
        castLabel.text = "Cast"
        castLabel.font = UIFont.boldSystemFont(ofSize: 24)
        
        castCollectionView.delegate     = self
        castCollectionView.dataSource   = self
        castCollectionView.register(ActorCell.self, forCellWithReuseIdentifier: ActorCell.reuseId)
        
        [castLabel, castCollectionView].forEach {
            scrollView.addSubview($0)
            $0.translatesAutoresizingMaskIntoConstraints = false
        }
        
        NSLayoutConstraint.activate([
            castLabel.leadingAnchor.constraint(equalTo: overviewTextLabel.leadingAnchor),
            castLabel.topAnchor.constraint(equalTo: overviewTextLabel.bottomAnchor, constant: 24),
            castLabel.heightAnchor.constraint(equalToConstant: 26),
            castLabel.trailingAnchor.constraint(equalTo: scrollView.centerXAnchor),
            
            castCollectionView.topAnchor.constraint(equalTo: castLabel.bottomAnchor, constant: 12),
            castCollectionView.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 12),
            castCollectionView.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -12),
            castCollectionView.heightAnchor.constraint(equalToConstant: 250),
        ])
    }
    
    func layoutUI() {
        overviewTitleLabel.text = "Overview"
        overviewTitleLabel.font = UIFont.boldSystemFont(ofSize: 20)
        
        overviewTextLabel.numberOfLines = 0
        overviewTextLabel.sizeToFit(
        )
        
        [headerView, overviewTitleLabel, overviewTextLabel].forEach {
            $0.translatesAutoresizingMaskIntoConstraints = false
            containerView.addSubview($0)
        }
        
        let height = view.frame.width * (9 / 16) + 85
        NSLayoutConstraint.activate([
            headerView.leadingAnchor.constraint(equalTo: containerView.leadingAnchor),
            headerView.trailingAnchor.constraint(equalTo: containerView.trailingAnchor),
            headerView.topAnchor.constraint(equalTo: containerView.topAnchor),
            headerView.heightAnchor.constraint(equalToConstant: height),
            
            overviewTitleLabel.topAnchor.constraint(equalTo: headerView.bottomAnchor, constant: 12),
            overviewTitleLabel.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 12),
            overviewTitleLabel.heightAnchor.constraint(equalToConstant: 22),
            overviewTitleLabel.trailingAnchor.constraint(equalTo: containerView.centerXAnchor),
            
            overviewTextLabel.leadingAnchor.constraint(equalTo: overviewTitleLabel.leadingAnchor),
            overviewTextLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -12),
            overviewTextLabel.topAnchor.constraint(equalTo: overviewTitleLabel.bottomAnchor, constant: 4)
        ])
    }
    
    func add(childVC: UIViewController, to containerView: UIView)  {
        addChild(childVC)
        containerView.addSubview(childVC.view)
        childVC.view.frame = containerView.bounds
        childVC.didMove(toParent: self)
    }
    
    @objc func dismissDetailVC() {
        dismiss(animated: true)
    }
    
    @objc func addButtonTapped() {
        NetworkManager.shared.getMovieDetails(for: queryId) { [weak self] movie, error in
            guard let self = self else { return }
            if let _ = error {
                return
            }
            
            guard let movie = movie else { return }
            let favorite = Movie(adult: movie.adult, id: movie.id, revenue: movie.revenue, budget: movie.budget, runtime: movie.runtime, voteAverage: movie.voteAverage, homepage: movie.homepage, title: movie.title, overview: movie.overview, posterPath: movie.posterPath, backdropPath: movie.backdropPath, releaseDate: movie.releaseDate, tagline: movie.tagline)
            
            PersistenceManager.updateWith(favorite: favorite, actionType: .add) { [weak self] error in
                guard let self = self else { return }
                guard let error = error else {
                    
                    let alert = UIAlertController(title: "Success", message: "Movie saved to favorites", preferredStyle: .alert)
                    alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: { action in
                        alert.dismiss(animated: true)
                    }))
                    DispatchQueue.main.async {
                        self.present(alert, animated: true, completion: nil)
                    }
                    return
                }
                
                let alert = UIAlertController(title: "Something Went Wrong", message: error.rawValue, preferredStyle: .alert)
                alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: { action in
                    alert.dismiss(animated: true)
                }))
                DispatchQueue.main.async {
                    self.present(alert, animated: true)
                }
                return
            }
            
            
        }
    }
}




extension MovieDetailVC: UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout{
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return cast.count
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        navigationController?.present(UIViewController(), animated: true, completion: nil)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 150 , height: castCollectionView.frame.height)
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ActorCell.reuseId, for: indexPath) as! ActorCell
        cell.setActor(actor: cast[indexPath.row])
        return cell
    
    }
    
    
    
    
    
    
    
    
    
    
    
}
