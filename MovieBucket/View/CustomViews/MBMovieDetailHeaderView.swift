//
//  MBMovieDetailHeaderView.swift
//  MovieBucket
//
//  Created by Olijujuan Green on 5/22/20.
//  Copyright © 2020 Olijujuan Green. All rights reserved.
//

import UIKit

class MBMovieDetailHeaderView: UIViewController {
    
    let backdropImageView   = MBImageView(frame: .zero)
    let posterImageView     = MBImageView(frame: .zero)
    
    let titleLabel          = UILabel()
    let releaseDateLabel    = UILabel()
    let ratingView          = UIView()
    let ratingLabel         = UILabel()
    let runtimeLabel        = UILabel()
    
    var movie: Movie!
    
    init(movie: Movie) {
        super.init(nibName: nil, bundle: nil)
        self.movie = movie
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureImages()
        configureLabels()
        view.backgroundColor = .systemFill
    }
    
    
    
    
    func configureImages() {
        backdropImageView.downloadImage(from: movie.backdropPath)
        posterImageView.downloadImage(from: movie.posterPath)
        posterImageView.layer.cornerRadius = 10
        
        [backdropImageView, posterImageView].forEach { view.addSubview($0) }
        
        NSLayoutConstraint.activate([
            backdropImageView.topAnchor.constraint(equalTo: view.topAnchor),
            backdropImageView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            backdropImageView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            backdropImageView.heightAnchor.constraint(equalTo: backdropImageView.widthAnchor, multiplier: 9 / 16),
            
            posterImageView.centerYAnchor.constraint(equalTo: backdropImageView.bottomAnchor),
            posterImageView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 12),
            posterImageView.heightAnchor.constraint(equalToConstant: 150),
            posterImageView.widthAnchor.constraint(equalTo: posterImageView.heightAnchor, multiplier: 2 / 3)
        ])
        
    }
    
    func configureLabels() {
        titleLabel.text                 = movie.title
        titleLabel.font                 = UIFont.boldSystemFont(ofSize: 16 )
        
        releaseDateLabel.text           = movie.releaseDate
        releaseDateLabel.font           = UIFont.systemFont(ofSize: 16)
        
        
        if movie.voteAverage >= 8.0 {
            ratingView.backgroundColor = .systemGreen
        } else if movie.voteAverage >= 7.0{
            ratingView.backgroundColor = .systemBlue
        }else if movie.voteAverage >= 6.0 {
            ratingView.backgroundColor = .systemYellow
        } else {
            ratingView.backgroundColor = .systemRed
        }
        ratingView.layer.cornerRadius   = 30
        
        ratingLabel.text                = "\(movie.voteAverage)"
        ratingLabel.textColor           = .white
        ratingLabel.font                = UIFont.boldSystemFont(ofSize: 32)
        ratingLabel.textAlignment       = .center
        
        if let runtime = movie.runtime {
            runtimeLabel.text = "\(runtime)min."
        }
        
        [titleLabel, releaseDateLabel, ratingView, ratingLabel, runtimeLabel].forEach {
            $0.translatesAutoresizingMaskIntoConstraints = false
            view.addSubview($0)
        }
        
        NSLayoutConstraint.activate([
            titleLabel.leadingAnchor.constraint(equalTo: posterImageView.trailingAnchor, constant: 12),
            titleLabel.topAnchor.constraint(equalTo: backdropImageView.bottomAnchor, constant: 8),
            titleLabel.heightAnchor.constraint(equalToConstant: 18),
            titleLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -4),
            
            releaseDateLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 4),
            releaseDateLabel.leadingAnchor.constraint(equalTo: titleLabel.leadingAnchor),
            releaseDateLabel.trailingAnchor.constraint(equalTo: ratingLabel.leadingAnchor),
            releaseDateLabel.heightAnchor.constraint(equalToConstant: 18),
            
            ratingView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -12),
            ratingView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: 20),
            ratingView.widthAnchor.constraint(equalToConstant: 60),
            ratingView.heightAnchor.constraint(equalToConstant: 60),
            
            ratingLabel.centerXAnchor.constraint(equalTo: ratingView.centerXAnchor),
            ratingLabel.centerYAnchor.constraint(equalTo: ratingView.centerYAnchor),
            ratingLabel.widthAnchor.constraint(equalTo: ratingView.widthAnchor),
            ratingLabel.heightAnchor.constraint(equalToConstant: 34),
            
            runtimeLabel.leadingAnchor.constraint(equalTo: releaseDateLabel.leadingAnchor),
            runtimeLabel.topAnchor.constraint(equalTo: releaseDateLabel.bottomAnchor, constant: 2),
            runtimeLabel.trailingAnchor.constraint(equalTo: ratingView.leadingAnchor),
            runtimeLabel.heightAnchor.constraint(equalToConstant: 18)
        ])
    }
    
}
