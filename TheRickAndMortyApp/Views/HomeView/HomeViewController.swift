//
//  HomeViewController.swift
//  TheRickAndMortyApp
//
//  Created by Omar Leal on 13/11/24.
//

import UIKit

class HomeViewController: UIViewController {
    private var viewModel = HomeViewModel()
    private let tableView: UITableView = {
           let tableView = UITableView()
           
           tableView.translatesAutoresizingMaskIntoConstraints = false
           return tableView
       }()
    private var searchBar = UISearchBar()
    var debounceWorkItem: DispatchWorkItem?
    
    private let filterButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Filters", for: .normal)
        button.addTarget(self, action: #selector(showFiltersPopup), for: .touchUpInside)
        return button
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        setupSearchBar()
        setupUI()
        bindViewModel()
               
        viewModel.loadCharacters()

        
    }
    private func setupSearchBar() {
            searchBar.delegate = self
            searchBar.placeholder = "Search by name"
            navigationItem.titleView = searchBar
        }

    private func setupUI() {
                searchBar.delegate = self
                searchBar.placeholder = "Search by name"
                print(tableView)
                tableView.register(CharacterCell.self, forCellReuseIdentifier: CharacterCell.identifier)
                tableView.dataSource = self
                tableView.delegate = self
                tableView.rowHeight = UITableView.automaticDimension
                tableView.backgroundColor = .clear
                tableView.estimatedRowHeight = 100
                tableView.separatorStyle = .none
                
                let stack = UIStackView(arrangedSubviews: [searchBar, filterButton, tableView])
                stack.axis = .vertical
                view.addSubview(stack)
                stack.translatesAutoresizingMaskIntoConstraints = false
                NSLayoutConstraint.activate([
                    stack.leadingAnchor.constraint(equalTo: view.leadingAnchor),
                    stack.trailingAnchor.constraint(equalTo: view.trailingAnchor),
                    stack.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
                    stack.bottomAnchor.constraint(equalTo: view.bottomAnchor)
                ])
        
            
       }
    
    private func bindViewModel() {
           viewModel.onCharactersUpdated = { [weak self] in
               self?.tableView.reloadData()
           }
        
        viewModel.onLoadingStatusChanged = { [weak self] in
               self?.tableView.reloadData()
           }
        
          
       }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
            // Cancelar cualquier trabajo previo pendiente
            debounceWorkItem?.cancel()
            debounceWorkItem = DispatchWorkItem { [weak self] in
                    self?.viewModel.searchCharacters(with: searchText)
            }
             if let workItem = debounceWorkItem {
                    DispatchQueue.main.asyncAfter(deadline: .now() + 0.5, execute: workItem)
                }
            
        }
    
    func applyFilters(status: String?, species: String?, gender: String?) {
        viewModel.loadCharacters(status: status, species: species, gender: gender)
    }

    
    @objc private func showFiltersPopup() {
        let popup = FilterPopUpViewController()
        
        // Pasar los filtros seleccionados de regreso al ViewModel
        popup.onApplyFilters = { [weak self] status, species, gender in
            self?.viewModel.loadCharacters(status: status, species: species, gender: gender)
        }
        
        // Configurar presentación como popup modal
        popup.modalPresentationStyle = .formSheet
        popup.modalTransitionStyle = .crossDissolve
        present(popup, animated: true, completion: nil)
    }



}

extension HomeViewController: UITableViewDataSource, UITableViewDelegate, UISearchBarDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
         return viewModel.isLoading ? 10 : viewModel.filteredCharacters.count
        }

        func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
            let customCell = tableView.dequeueReusableCell(withIdentifier: CharacterCell.identifier, for: indexPath) as! CharacterCell
            customCell.backgroundColor = .clear
            customCell.selectedBackgroundView = .none
            if viewModel.isLoading { customCell.configure(with: nil) }
            else { customCell.configure(with: viewModel.filteredCharacters[indexPath.row]) }
               
            return customCell
        }

       
    
}
