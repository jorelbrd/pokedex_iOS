//
//  ExtensionViewController.swift
//  iOSPokedexApp
//
//  Created by Lenin on 1/13/21.
//

import UIKit

extension ViewController: UITableViewDataSource, UITableViewDelegate, UISearchBarDelegate {
    
    //DATA SOURCE
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return Service.shared.numRowsSection(section: section)
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! PokemonTableViewCell
        
        let pokemons = Service.shared.cellRowAt(indexPath: indexPath)
        cell.setCellWithValuesOf(pokemons)

        return cell
    }
    
    
    
    
    
    
    
    //DELEGATE
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        DispatchQueue.main.async {
            self.tableViews.reloadData()
        }
        self.pokemon = Service.shared.cellRowAt(indexPath: indexPath)
        performSegue(withIdentifier: "segueInfoPokemon", sender: self)
        
    }
    
   
    
   
    
    
    //SEARCH BAR
    
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        if searchText.isEmpty {
            view.endEditing(true)
            Service.shared.getAllDataPokemon{ (poke) in
                DispatchQueue.main.async {
                    self.tableViews.reloadData()
                }
            }
            
        } else {
            self.tableViews.reloadData()
            Service.shared.fetchPokemonEspecific(namePokemon: searchText.lowercased())
        }
        self.tableViews.reloadData()
    }
    
    
    	
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        view.endEditing(true)
        self.tableViews.reloadData()
    }
    
    
    
    
}
