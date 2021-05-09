//
//  DetailPokemonViewController.swift
//  iOSPokedexApp
//
//  Created by Lenin on 1/7/21.
//

import UIKit

class DetailPokemonViewController: UIViewController {
    
    var pokemon: PokemonData?

    @IBOutlet weak var imgPokemon: UIImageView!
    @IBOutlet weak var viewType: UIView!
    @IBOutlet weak var lbTypePokemon: UILabel!
    @IBOutlet weak var viewType2: UIView!
    @IBOutlet weak var lbTypePokemon2: UILabel!
    
    @IBOutlet weak var lbNamePokemon: UILabel!
    @IBOutlet weak var viewInformation: UIView!
    
    @IBOutlet weak var lbHP: UILabel!
    @IBOutlet weak var lbATK: UILabel!
    @IBOutlet weak var lbDEF: UILabel!
    @IBOutlet weak var lbSATK: UILabel!
    @IBOutlet weak var lbSDEF: UILabel!
    @IBOutlet weak var lbSPD: UILabel!
    
    
    @IBOutlet weak var progressViewHP: UIProgressView!
    @IBOutlet weak var progressViewATK: UIProgressView!
    @IBOutlet weak var progressViewDEF: UIProgressView!
    @IBOutlet weak var progressViewSATK: UIProgressView!
    @IBOutlet weak var progressViewSDEF: UIProgressView!
    @IBOutlet weak var progressViewSPD: UIProgressView!
    
    
    @IBOutlet weak var btnStats: UIButton!
    @IBOutlet weak var btnEvolutions: UIButton!
    @IBOutlet weak var btnMoves: UIButton!
    @IBOutlet var viewBack: UIView!
    @IBOutlet weak var lbDescription: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
                
        self.designViewBack()
        
        self.designViewType(viewT: viewType)
        self.designViewType(viewT: viewType2)
        self.designBtnDetail(btn: btnStats)
        self.btnEvolutions.setTitleColor(pokemon?.color, for: .normal)
        self.btnMoves.setTitleColor(pokemon?.color, for: .normal)
        //self.designBtnDetail(btn: btnEvolutions)
        //self.designBtnDetail(btn: btnMoves)
        
        self.designViewInfo()
        
        
        lbDescription.text = pokemon?.description?.capitalized
        lbNamePokemon.text = pokemon?.name
        imgPokemon.image = pokemon?.image
        showTypes()
        
    
        
        self.designLabelsSTATS(lb: lbHP, pv: progressViewHP)
        self.designLabelsSTATS(lb: lbATK, pv: progressViewATK)
        self.designLabelsSTATS(lb: lbDEF, pv: progressViewDEF)
        self.designLabelsSTATS(lb: lbSATK, pv: progressViewSATK)
        self.designLabelsSTATS(lb: lbSDEF, pv: progressViewSDEF)
        self.designLabelsSTATS(lb: lbSPD, pv: progressViewSPD)
        self.setBarr()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "segueEvolutions" {
            if let destino = segue.destination as? EvolutionsViewController {
                destino.pokemon = self.pokemon
                
            }
        }
        else if segue.identifier == "segueMoves" {
            if let destino = segue.destination as? MovesViewController {
                destino.pokemon = self.pokemon
                
            }
        }
    }
    
    func designLabelsSTATS(lb: UILabel, pv: UIProgressView) {
        lb.textColor = self.pokemon?.color
        pv.progressTintColor = self.pokemon?.color
    }
    
    
    func showTypes() {
        if self.pokemon?.types?.count == 2 {
            self.viewType.backgroundColor = self.pokemon?.setColor(stringColor: (self.pokemon?.types?.first)!)
            self.lbTypePokemon.text = self.pokemon?.types?.first
            self.viewType2.backgroundColor = self.pokemon?.setColor(stringColor: (self.pokemon?.types?.last)!)
            self.lbTypePokemon2.text = self.pokemon?.types?.last
        }
        else {
            self.lbTypePokemon.text = self.pokemon?.types?.first
            self.viewType2.isHidden = true
        }
        
    }
    
    func setBarr()  {
        self.progressViewHP.setProgress(Float((self.pokemon?.hp ?? 0) / 100), animated: true)
        self.progressViewATK.setProgress(Float(self.pokemon?.atk ?? 0), animated: true)
        self.progressViewDEF.setProgress(Float(self.pokemon?.def ?? 0), animated: true)
        self.progressViewSATK.setProgress(Float(self.pokemon?.satk ?? 0), animated: true)
        self.progressViewSDEF.setProgress(Float(self.pokemon?.sdef ?? 0), animated: true)
        self.progressViewSPD.setProgress(Float(self.pokemon?.spd ?? 0), animated: true)
    }
    
    
    @IBAction func btnActionBack(_ sender: Any) {
        _ = navigationController?.popToRootViewController(animated: true)
    }
    
    @IBAction func btnStatsAction(_ sender: Any) {
    }
    @IBAction func btnEvolutionsAction(_ sender: Any) {
        performSegue(withIdentifier: "segueEvolutions", sender: self)
    }
    @IBAction func btnMovesAction(_ sender: Any) {
        performSegue(withIdentifier: "segueMoves", sender: self)
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
    
    func designViewType(viewT: UIView) {
        viewT.layer.backgroundColor = self.pokemon?.color?.cgColor
        viewT.layer.shadowOffset = CGSize(width: 10, height: 10)
        viewT.layer.shadowRadius = 5
        viewT.layer.shadowOpacity = 0.3
        viewT.layer.cornerRadius = CGFloat(10)
        
    }
    
    func designBtnDetail(btn: UIButton) {
        btn.round()
        btn.bounce()
        btn.backgroundColor = self.pokemon?.color
        btn.shadow(colorShadow: (self.pokemon?.color) ?? .darkGray)
    }
    

}
