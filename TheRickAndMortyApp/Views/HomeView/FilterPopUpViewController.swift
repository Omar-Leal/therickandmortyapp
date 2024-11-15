//
//  FilterPopUpViewController.swift
//  TheRickAndMortyApp
//
//  Created by Omar Leal on 15/11/24.
//

import UIKit

class FilterPopUpViewController: UIViewController {

    // Bloque que pasará los filtros seleccionados de regreso
       var onApplyFilters: ((String?, String?, String?) -> Void)?
       
       // Opciones de los filtros (puedes usar UIPickerView, UISegmentedControl, etc.)
       private let statusTextField: UITextField = {
           let textField = UITextField()
           textField.placeholder = "Status (alive, dead, unknown)"
           textField.borderStyle = .roundedRect
           return textField
       }()
       
       private let speciesTextField: UITextField = {
           let textField = UITextField()
           textField.placeholder = "Species (e.g., Human, Alien)"
           textField.borderStyle = .roundedRect
           return textField
       }()
       
       private let genderTextField: UITextField = {
           let textField = UITextField()
           textField.placeholder = "Gender (male, female, unknown)"
           textField.borderStyle = .roundedRect
           return textField
       }()
       
       private let applyButton: UIButton = {
           let button = UIButton(type: .system)
           button.setTitle("Apply Filters", for: .normal)
           button.addTarget(self, action: #selector(applyFilters), for: .touchUpInside)
           return button
       }()
       
       private let resetButton: UIButton = {
           let button = UIButton(type: .system)
           button.setTitle("Reset Filters", for: .normal)
           button.addTarget(self, action: #selector(resetFilters), for: .touchUpInside)
           return button
       }()
       
       override func viewDidLoad() {
           super.viewDidLoad()
           setupUI()
       }
       
       private func setupUI() {
           view.backgroundColor = .white
           view.layer.cornerRadius = 16
           
           // Agregar subviews
           let stack = UIStackView(arrangedSubviews: [
               statusTextField,
               speciesTextField,
               genderTextField,
               applyButton,
               resetButton
           ])
           stack.axis = .vertical
           stack.spacing = 16
           stack.translatesAutoresizingMaskIntoConstraints = false
           
           view.addSubview(stack)
           
           // Configurar constraints
           NSLayoutConstraint.activate([
               stack.centerXAnchor.constraint(equalTo: view.centerXAnchor),
               stack.centerYAnchor.constraint(equalTo: view.centerYAnchor),
               stack.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
               stack.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16)
           ])
       }
       
       @objc private func applyFilters() {
           // Recuperar valores seleccionados
           let status = statusTextField.text
           let species = speciesTextField.text
           let gender = genderTextField.text
           
           // Enviar los filtros al controlador principal
           onApplyFilters?(status, species, gender)
           dismiss(animated: true, completion: nil)
       }
       
       @objc private func resetFilters() {
           statusTextField.text = nil
           speciesTextField.text = nil
           genderTextField.text = nil
           dismiss(animated: true, completion: nil)
       }
}
