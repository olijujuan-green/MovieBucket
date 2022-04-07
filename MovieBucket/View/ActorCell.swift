//
//  ActorCell.swift
//  MovieBucket
//
//  Created by Olijujuan Green on 6/16/20.
//  Copyright © 2020 Olijujuan Green. All rights reserved.
//

import UIKit

class ActorCell: UICollectionViewCell {
    static let reuseId = "actorCellId"
    
    let actorImageView  = MBImageView(frame: .zero)
    
    let nameLabel: UILabel = {
        let label   = UILabel()
        label.font  = UIFont.systemFont(ofSize: 14)
        return label
    }()
    
    let characterLabel: UILabel = {
        let label   = UILabel()
        label.font  = UIFont.systemFont(ofSize: 14)
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
        [actorImageView, nameLabel, characterLabel].forEach {
            addSubview($0)
            $0.translatesAutoresizingMaskIntoConstraints = false
        }
        
        actorImageView.layer.cornerRadius = 8
        actorImageView.clipsToBounds = true
        
        NSLayoutConstraint.activate([
            actorImageView.topAnchor.constraint(equalTo: topAnchor),
            actorImageView.leadingAnchor.constraint(equalTo: leadingAnchor),
            actorImageView.trailingAnchor.constraint(equalTo: trailingAnchor),
            actorImageView.heightAnchor.constraint(equalToConstant: 200),
            
            nameLabel.topAnchor.constraint(equalTo: actorImageView.bottomAnchor, constant: 2),
            nameLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 2),
            nameLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -2),
            nameLabel.heightAnchor.constraint(equalToConstant: 16),
            
            characterLabel.topAnchor.constraint(equalTo: nameLabel.bottomAnchor, constant: 2),
            characterLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 2),
            characterLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -2),
            characterLabel.heightAnchor.constraint(equalToConstant: 16)
        ])
        
    }
    
    func setActor(actor: Actor) {
        actorImageView.downloadImage(from: actor.profilePath)
        nameLabel.text = actor.name
        characterLabel.text = actor.character
    }
    
    
    
    
    
}
