//
//  MovesViewController.swift
//  iOSPokedexApp
//
//  Created by Lenin on 1/16/21.
//

import UIKit

class MovesViewController: UIViewController {

    var pokemon: PokemonData?
    var moves: [Pokemon.Moves]? = []
    @IBOutlet var viewBack: UIView!
    @IBOutlet weak var viewInformation: UIView!
    @IBOutlet weak var btnStats: UIButton!
    @IBOutlet weak var btnEvolutions: UIButton!
    @IBOutlet weak var btnMoves: UIButton!
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var namePokemon: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.moves = pokemon?.moves
        self.tableView.dataSource = self
        self.tableView.delegate = self
        self.designViewBack()
        self.designViewInfo()
        self.designBtnDetail(btn: btnMoves)
        self.btnEvolutions.setTitleColor(pokemon?.color, for: .normal)
        self.btnStats.setTitleColor(pokemon?.color, for: .normal)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "segueEvolutions" {
            if let destino = segue.destination as? EvolutionsViewController {
                destino.pokemon = self.pokemon
                
            }
        }
    }
    
    func designBtnDetail(btn: UIButton) {
        btn.round()
        btn.bounce()
        btn.backgroundColor = self.pokemon?.color
        btn.shadow(colorShadow: (self.pokemon?.color) ?? .lightGray)
    }
    
    func designViewBack() {
        let gradient: CAGradientLayer = CAGradientLayer()
        gradient.frame = self.viewBack.frame
        gradient.colors = [pokemon?.color?.cgColor as Any, pokemon?.color?.withAlphaComponent(CGFloat(0.8)).cgColor as Any]
        gradient.startPoint = CGPoint(x: 0.0, y: 1.0)
        gradient.endPoint = CGPoint(x: 1.0, y: 1.0)
        self.viewBack.layer.insertSublayer(gradient, at: 0)
        let layer: CALayer = CALayer(layer: self.viewBack.layer)
        self.view.layer.insertSublayer(layer, at: 0)
         
    }
    
    func designViewInfo() {
        viewInformation.layer.cornerRadius = CGFloat(50)
        viewInformation.clipsToBounds = true
        viewInformation.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
    }
    
    @IBAction func btnStatsAction(_ sender: Any) {
        _ = navigationController?.popViewController(animated: true)
    }
    
    
    @IBAction func btnEvolutionsAction(_ sender: Any) {
        _ = navigationController?.popViewController(animated: true)
    }
    
    @IBAction func btnBack(_ sender: Any) {
        _ = navigationController?.popToRootViewController(animated: true)
    }
    
}
