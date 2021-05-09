//
//  ViewController.swift
//  iOSPokedexApp
//
//  Created by Lenin on 1/6/21.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var viewLineButtom: UIView!
    @IBOutlet weak var viewLineTop: UIView!
    @IBOutlet var viewBack: UIView!
    @IBOutlet weak var searchPokemon: UISearchBar!
    
    
    var pokemon: PokemonData?
    
    @IBOutlet weak var tableViews: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        self.designViewBack()
        self.designViewLine(viewLine: viewLineTop)
        self.designViewLine(viewLine: viewLineButtom)
        
        self.searchPokemon.delegate = self
        
        fecthAllPokemon()
        
        
        
    }
    
    
    
    
    
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "segueInfoPokemon" {
            if let destino = segue.destination as? DetailPokemonViewController{
                Service.shared.setEvolutions(pokeInfo: self.pokemon!)
                destino.pokemon = self.pokemon
                
            }
        }
    }
    
    func designViewLine(viewLine: UIView) {
        let gradient: CAGradientLayer = CAGradientLayer()
        gradient.frame = viewLine.bounds
        gradient.colors = [UIColor.systemBlue.cgColor, UIColor.cyan.cgColor, UIColor.green.cgColor,  UIColor.systemGreen.cgColor]
        gradient.startPoint = CGPoint(x: 0.0, y: 1.0)
        gradient.endPoint = CGPoint(x: 1.0, y: 1.0)
        viewLine.layer.insertSublayer(gradient, at: 0)
        //let layer: CALayer = CALayer(layer: viewLine.layer)
        //viewLine.layer.addSublayer(layer)
    }
    
    func designViewBack() {
        let gradient: CAGradientLayer = CAGradientLayer()
        gradient.frame = self.viewBack.frame
        gradient.colors = [UIColor.init(red: (222.0/255.0), green: (239.0/255.0), blue: (249.0/255.0), alpha: 1.0).cgColor, UIColor.init(red: (227.0/255.0), green: (245.0/255.0), blue: (221.0/255.0), alpha: 1.0).cgColor, UIColor.init(red: (218.0/255.0), green: (246.0/255.0), blue: (221.0/255.0), alpha: 1.0).cgColor]
        //gradient.locations = [0, 0.58888]
        gradient.startPoint = CGPoint(x: 0.0, y: 1.0)
        gradient.endPoint = CGPoint(x: 1.0, y: 1.0)
        self.viewBack.layer.insertSublayer(gradient, at: 0)
        let layer: CALayer = CALayer(layer: self.viewBack.layer)
        self.view.layer.insertSublayer(layer, at: 0)
         
    }
   
    
    // MARK: - API
    
    func fecthAllPokemon() {
        Service.shared.getAllDataPokemon { (pokeAll) in
            DispatchQueue.main.async {
                Service.shared.pokemons.sort {
                    $0.order! < $1.order!
                }
                self.tableViews.dataSource = self
                self.tableViews.delegate = self
                self.tableViews.reloadData()
            }
        }
        

    }


}




