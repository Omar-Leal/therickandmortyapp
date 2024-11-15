//
//  HomeCharactersService.swift
//  TheRickAndMortyApp
//
//  Created by Omar Leal on 14/11/24.
//

import Foundation

class RickAndMortyService {
    private var baseURL = "https://rickandmortyapi.com/api/character"
    
    func fetchCharacters(
        page: Int,
        status: String? = nil,
        species: String? = nil,
        gender: String? = nil,
        completion: @escaping (Result<[HomeCharacters], Error>) -> Void) {
        var queryItems = [URLQueryItem(name: "page", value: "\(page)")]
               
               if let status = status, !status.isEmpty {
                   queryItems.append(URLQueryItem(name: "status", value: status))
               }
               
               if let species = species, !species.isEmpty {
                   queryItems.append(URLQueryItem(name: "species", value: species))
               }
               
               if let gender = gender, !gender.isEmpty {
                   queryItems.append(URLQueryItem(name: "gender", value: gender))
               }
               
               var urlComponents = URLComponents(string: baseURL)!
               urlComponents.queryItems = queryItems
               
               // Verificar si la URL se generó correctamente
               guard let url = urlComponents.url else { return }
        
             URLSession.shared.dataTask(with: url) { data, response, error in
                if let error = error {
                    completion(.failure(error))
                    return
                }
                
            guard let data = data else { return }
             do {
                let response = try JSONDecoder().decode(CharacterResponse.self, from: data)
                completion(.success(response.results))
            } catch {
                completion(.failure(error))
            }
        }.resume()
    }
}
