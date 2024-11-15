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
           // Configure the views here
           characterImageView.contentMode = .scaleAspectFill
           characterImageView.clipsToBounds = true
           characterImageView.layer.cornerRadius = 8

           nameLabel.font = UIFont.boldSystemFont(ofSize: 18)
           statusLabel.font = UIFont.systemFont(ofSize: 14)
           speciesLabel.font = UIFont.systemFont(ofSize: 14)
           locationLabel.font = UIFont.systemFont(ofSize: 12)
           episodeLabel.font = UIFont.systemFont(ofSize: 12)
           episodeLabel.textColor = .gray

           let stack = UIStackView(arrangedSubviews: [nameLabel, statusLabel, speciesLabel, locationLabel, episodeLabel])
           stack.axis = .vertical
           stack.spacing = 4

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
               characterImageView.widthAnchor.constraint(equalToConstant: 80),
               characterImageView.heightAnchor.constraint(equalToConstant: 140)
           ])
           
           container.layer.cornerRadius = 10  // Bordes redondeados
           container.layer.masksToBounds = false
           container.layer.shadowColor = UIColor.black.cgColor
           container.layer.shadowOpacity = 0.2
           container.layer.shadowOffset = CGSize(width: 0, height: 2)
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
              episodeLabel.text = "First seen in: \(character.firstEpisode ?? "Unknown")"
              
              if let url = URL(string: character.image) {
                  URLSession.shared.dataTask(with: url) { data, _, _ in
                      if let data = data {
                          DispatchQueue.main.async {
                              self.characterImageView.image = UIImage(data: data)
                          }
                      }
                  }.resume()
              }
          } else {
              // Mostrar Skeleton si los datos aún no están disponibles
              showSkeleton()
          }
      }
    
    
       private func showSkeleton() { contentView.showAnimatedGradientSkeleton() }

       private func hideSkeleton() { contentView.hideSkeleton() }
}

