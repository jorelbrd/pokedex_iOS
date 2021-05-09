//
//  PokemonTableViewCell.swift
//  iOSPokedexApp
//
//  Created by Lenin on 1/8/21.
//

import UIKit

class PokemonTableViewCell: UITableViewCell {
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
    }
    
    

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

    @IBOutlet weak var imgPokemon: UIImageView!
    @IBOutlet weak var namePokemon: UILabel!
    @IBOutlet weak var numId: UILabel!
    
    private func updateUI(title: String?, img: UIImage?, id: Int?) {
        self.namePokemon.text = title
        self.imgPokemon.image = img
        self.numId.text = "#000" + String(id ?? 0)
    }
    
    func setCellWithValuesOf(_ pokemon: PokemonData) {
        updateUI(title: pokemon.name, img: pokemon.image, id: pokemon.id)
    }
}
