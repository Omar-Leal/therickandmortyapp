//
//  HomeViewModel.swift
//  TheRickAndMortyApp
//
//  Created by Omar Leal on 14/11/24.
//

import Foundation

class HomeViewModel {
    private let service = RickAndMortyService()
    private(set) var characters: [HomeCharacters] = []
    private var currentPage = 1
    var isLoading: Bool = true {
            didSet {
                onLoadingStatusChanged?()
            }
    }
    
    var filteredCharacters: [HomeCharacters] = []
    var onCharactersUpdated: (() -> Void)?
    var onLoadingStatusChanged: (() -> Void)?
    
    // Inicializar Filtros
    private var currentStatus: String?
    private var currentSpecies: String?
    private var currentGender: String?
        
    
    func loadCharacters(status: String? = nil, species: String? = nil, gender: String? = nil) {
    
        isLoading = true
        
        // Actualizando filtros
        currentStatus = status
        currentSpecies = species
        currentGender = gender

        service.fetchCharacters(page: currentPage, status: currentStatus, species: currentSpecies, gender: currentGender) { [weak self] result in
            DispatchQueue.main.async {
                guard let self = self else { return }
           
                
                switch result {
                case .success(let newCharacters):
                    self.characters = newCharacters
                    self.filteredCharacters = self.characters
                    self.onCharactersUpdated?()
                    self.isLoading = false
                    self.currentPage += 1
                case .failure(let error):
                    print("Error loading characters: \(error)")
                    self.isLoading = false
                }
            }
        }
    }
    
    func searchCharacters(with query: String) {
        if query.isEmpty {
            filteredCharacters = characters
        } else {
            filteredCharacters = characters.filter { $0.name.lowercased().contains(query.lowercased()) }
        }
        onCharactersUpdated?()
    }
    
    
    // Limpiando filtros
    func resetFilters() {
          currentStatus = nil
          currentSpecies = nil
          currentGender = nil
          loadCharacters() // Recargar sin filtros
      }
    
}
