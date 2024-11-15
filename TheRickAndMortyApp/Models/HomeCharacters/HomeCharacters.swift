//
//  HomeCharacters.swift
//  TheRickAndMortyApp
//
//  Created by Omar Leal on 14/11/24.
//

import Foundation

struct HomeCharacters: Decodable {
    let id: Int
    let name: String
    let status: String
    let species: String
    let gender: String
    let image: String
    let location: Location
    let firstEpisode: String?
}

struct Location: Decodable {
    let name: String
}

struct CharacterResponse: Decodable {
    let results: [HomeCharacters]
}
