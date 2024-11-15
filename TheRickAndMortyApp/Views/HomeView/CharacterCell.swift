//
//  CharacterCell.swift
//  TheRickAndMortyApp
//
//  Created by Omar Leal on 14/11/24.
//

import Foundation

import UIKit
import SkeletonView

class CharacterCell: UITableViewCell {
    
    static let identifier = "CharacterCell"

       private let nameLabel = UILabel()
       private let statusLabel = UILabel()
       private let speciesLabel = UILabel()
       private let locationLabel = UILabel()
       private let episodeLabel = UILabel()
       private let characterImageView = UIImageView()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
            super.init(style: style, reuseIdentifier: reuseIdentifier)
           setupUI()
       }

       required init?(coder: NSCoder) {
           fatalError("init(coder:) has not been implemented")
       }

       private func setupUI() {

           characterImageView.contentMode = .scaleAspectFill
           characterImageView.clipsToBounds = true
           characterImageView.layer.cornerRadius = 20
           characterImageView.layer.maskedCorners = [.layerMinXMinYCorner, .layerMinXMaxYCorner]
           characterImageView.clipsToBounds = true

           nameLabel.font = UIFont.boldSystemFont(ofSize: 18)
           statusLabel.font = UIFont.systemFont(ofSize: 14)
           speciesLabel.font = UIFont.systemFont(ofSize: 14)
           locationLabel.font = UIFont.systemFont(ofSize: 12)
           episodeLabel.font = UIFont.systemFont(ofSize: 12)
           episodeLabel.textColor = .gray
           
          

           let stack = UIStackView(arrangedSubviews: [nameLabel, statusLabel, speciesLabel, locationLabel, episodeLabel])
           stack.isLayoutMarginsRelativeArrangement = true
           stack.layoutMargins = UIEdgeInsets(top: 0, left: 0, bottom: 40, right: 0)
           stack.axis = .vertical
           stack.alignment = .center
           stack.spacing = 4
           stack.setCustomSpacing(-20, after: nameLabel)
           
           
           
           let container = UIStackView(arrangedSubviews: [characterImageView, stack])
           container.axis = .horizontal
           container.spacing = 8

           contentView.addSubview(container)
           container.translatesAutoresizingMaskIntoConstraints = false
           NSLayoutConstraint.activate([
               container.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
               container.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
               container.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 8),
               container.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -8),
               characterImageView.widthAnchor.constraint(equalToConstant: 120),
               characterImageView.heightAnchor.constraint(equalToConstant: 190)
           ])
           
           container.layer.cornerRadius = 20
           container.layer.masksToBounds = false
           container.layer.shadowColor = UIColor.gray.cgColor
           container.layer.shadowOpacity = 0.1
           container.layer.shadowOffset = CGSize(width: 0, height: 1)
           container.layer.shadowRadius = 4
           container.backgroundColor = .white
           
           
           nameLabel.isSkeletonable = true
           statusLabel.isSkeletonable = true
           speciesLabel.isSkeletonable = true
           locationLabel.isSkeletonable = true
           episodeLabel.isSkeletonable = true
           characterImageView.isSkeletonable = true
           contentView.isSkeletonable = true
       }

    func configure(with character: HomeCharacters?) {
          if let character = character {
   
              hideSkeleton()
              
              nameLabel.text = character.name
              statusLabel.text = character.status
              speciesLabel.text = character.species
              locationLabel.text = "Last known location: \(character.location.name)"

              
              
           
              ImageCache.shared.getImage(for: character.image) { [weak self] image in
                          DispatchQueue.main.async {
                              self?.characterImageView.image = image
                          }
                      }
          } else {
          
              showSkeleton()
          }
      }
    
    
       private func showSkeleton() { contentView.showAnimatedGradientSkeleton() }

       private func hideSkeleton() { contentView.hideSkeleton() }
}

