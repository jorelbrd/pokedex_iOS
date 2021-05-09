//
//  EvolutionsViewController.swift
//  iOSPokedexApp
//
//  Created by Lenin on 1/13/21.
//

import UIKit

class EvolutionsViewController: UIViewController {

    var pokemon: PokemonData?
    var evolutions: [PokemonData]? = []
    @IBOutlet var viewBack: UIView!
    @IBOutlet weak var btnStatsAction: UIButton!
    @IBOutlet weak var btnEvolutionsAction: UIButton!
    @IBOutlet weak var btnMovesAction: UIButton!
    @IBOutlet weak var viewInformation: UIView!
    @IBOutlet weak var lbNamePokemon: UILabel!
    
    @IBOutlet weak var img1: UIImageView!
    @IBOutlet weak var lbName1: UILabel!
    @IBOutlet weak var lbLevel1: UILabel!
    
    @IBOutlet weak var img2: UIImageView!
    @IBOutlet weak var lbName2: UILabel!
    
    @IBOutlet weak var img3: UIImageView!
    @IBOutlet weak var lbName3: UILabel!
    @IBOutlet weak var lbLevel3: UILabel!
    
    @IBOutlet weak var img4: UIImageView!
    @IBOutlet weak var lbName4: UILabel!
    
    @IBOutlet weak var img5: UIImageView!
    @IBOutlet weak var lbName5: UILabel!
    @IBOutlet weak var lbLevel5: UILabel!
    
    
    @IBOutlet weak var img6: UIImageView!
    @IBOutlet weak var lbName6: UILabel!
    @IBOutlet weak var lbEvolutionFinish: UILabel!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.lbNamePokemon.text = pokemon?.name
        evolutions = self.pokemon?.nextEvolution
        evolutions?.sort {
            $0.order! < $1.order!
        }
        self.showEvolutions()
        self.designViewInfo()
        self.btnStatsAction.setTitleColor(pokemon?.color, for: .normal)
        self.designBtnDetail(btn: btnEvolutionsAction)
        self.btnMovesAction.setTitleColor(pokemon?.color, for: .normal)
        self.designViewBack()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "segueEvolutionsMoves" {
            if let destino = segue.destination as? MovesViewController {
                destino.pokemon = self.pokemon
                
            }
        }
    }
    
    
    @IBAction func btnActionSTATS(_ sender: Any) {
        _ = navigationController?.popViewController(animated: true)
        
    }
    
    @IBAction func btnActionMOVES(_ sender: Any) {
        performSegue(withIdentifier: "segueEvolutionsMoves", sender: self)
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
    
    func designBtnDetail(btn: UIButton) {
        btn.round()
        btn.bounce()
        btn.backgroundColor = self.pokemon?.color
        btn.shadow(colorShadow: (self.pokemon?.color)!)
    }
    
    
    

    @IBAction func btnActionBack(_ sender: Any) {
        _ = navigationController?.popToRootViewController(animated: true)
    }
    

}
