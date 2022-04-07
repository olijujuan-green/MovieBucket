//
//  MovieCell.swift
//  MovieBucket
//
//  Created by Olijujuan Green on 5/21/20.
//  Copyright © 2020 Olijujuan Green. All rights reserved.
//

import UIKit

class MovieCell: UICollectionViewCell {
    static let reuseId          = "movieCellId"
    let moviePosterImageView    = MBImageView(frame: .zero)
    
    
    
    let movieTitleLabel: UILabel = {
       let label = UILabel()
        label.text = "Movie Title"
        label.font = UIFont.boldSystemFont(ofSize: 18)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    
    let releaseDateLabel: UILabel = {
       let label = UILabel()
        label.text = "mm/dd/yyyy"
        label.font = UIFont.systemFont(ofSize: 14)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    
    
    func configure() {
        moviePosterImageView.layer.cornerRadius = 10
        [moviePosterImageView, movieTitleLabel, releaseDateLabel].forEach { addSubview($0) }
        
        NSLayoutConstraint.activate([
            
            releaseDateLabel.bottomAnchor.constraint(equalTo: bottomAnchor),
            releaseDateLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 4),
            releaseDateLabel.trailingAnchor.constraint(equalTo: trailingAnchor),
            releaseDateLabel.heightAnchor.constraint(equalToConstant: 16),
            
            movieTitleLabel.leadingAnchor.constraint(equalTo: releaseDateLabel.leadingAnchor),
            movieTitleLabel.bottomAnchor.constraint(equalTo: releaseDateLabel.topAnchor, constant: 2),
            movieTitleLabel.trailingAnchor.constraint(equalTo: trailingAnchor),
            movieTitleLabel.heightAnchor.constraint(equalToConstant: 20),
            
            moviePosterImageView.bottomAnchor.constraint(equalTo: movieTitleLabel.topAnchor, constant: 2),
            moviePosterImageView.leadingAnchor.constraint(equalTo: leadingAnchor),
            moviePosterImageView.trailingAnchor.constraint(equalTo: trailingAnchor),
            moviePosterImageView.topAnchor.constraint(equalTo: topAnchor)
            
        ])
    }
    
    func setMovie(movie: Movie) {
        movieTitleLabel.text    = movie.title
        releaseDateLabel.text   = movie.releaseDate
        moviePosterImageView.downloadImage(from: movie.posterPath)
    }
}



