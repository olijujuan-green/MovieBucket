
//
//  FavoriteCell.swift
//  MovieBucket
//
//  Created by Olijujuan Green on 6/16/20.
//  Copyright © 2020 Olijujuan Green. All rights reserved.
//

import UIKit

class FavoriteCell: UITableViewCell {
    static let reuseId = "favoriteReuseId"
    let moviePosterImageView = MBImageView(frame: .zero)
    let movieNameLabel = UILabel()
    
    
    
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        configure()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    
    
    func configure() {
        
        [moviePosterImageView, movieNameLabel].forEach {
            addSubview($0)
            $0.translatesAutoresizingMaskIntoConstraints = false
        }
        
        accessoryType = .disclosureIndicator
        let padding: CGFloat = 12
        let height : CGFloat = 100
        let width  : CGFloat = height / 3 * 2
        NSLayoutConstraint.activate([
            moviePosterImageView.centerYAnchor.constraint(equalTo: centerYAnchor),
            moviePosterImageView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: padding),
            moviePosterImageView.heightAnchor.constraint(equalToConstant: height),
            moviePosterImageView.widthAnchor.constraint(equalToConstant: width),
            
            movieNameLabel.leadingAnchor.constraint(equalTo: moviePosterImageView.trailingAnchor, constant: 24),
            movieNameLabel.centerYAnchor.constraint(equalTo: centerYAnchor),
            movieNameLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -padding),
            movieNameLabel.heightAnchor.constraint(equalToConstant: 22)
        ])
    }
    
    func configureLabel() {
        movieNameLabel.textAlignment = .left
        movieNameLabel.font = UIFont.boldSystemFont(ofSize: 20)
    }
    
    func set(favorite: Movie) {
        movieNameLabel.text = favorite.title
        moviePosterImageView.downloadImage(from: favorite.posterPath)
    }
    
}
