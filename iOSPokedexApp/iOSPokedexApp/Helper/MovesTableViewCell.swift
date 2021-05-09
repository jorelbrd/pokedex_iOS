//
//  MovesTableViewCell.swift
//  iOSPokedexApp
//
//  Created by Lenin on 1/16/21.
//

import UIKit

class MovesTableViewCell: UITableViewCell {
    
    
    @IBOutlet weak var nameMove: UILabel!
    @IBOutlet weak var levelMove: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    private func updateUI(name: String?, level: Int?) {
        self.nameMove.text = name
        self.levelMove.text = "Level. " + String(level ?? 0)
    }
    
    func setCellWithValuesOf(_ moves: PokemonData.Moves) {
        self.updateUI(name: moves.name, level: moves.level)
    }

}
