//
//  ExtensionEvolutionsViewController.swift
//  iOSPokedexApp
//
//  Created by Lenin on 1/15/21.
//

import UIKit

extension EvolutionsViewController{
    
    
    func showEvolutions() {
        if evolutions?.count != 0 {
            self.evolutionsFirst()
            if evolutions!.count > 2 {
                self.evolutionsSecond()
                self.evolutionsUltimate()
            }
        }
    }
    
    
    func evolutionsFirst() {
        self.img1.image = evolutions![0].image
        self.lbName1.text = evolutions![0].name
        
        self.lbLevel1.text = "\(evolutions![1].levelEvolution ?? 0)"
        
        self.img2.image = evolutions![1].image
        self.lbName2.text = evolutions![1].name
    }
    
    func evolutionsSecond() {
        
        self.img3.image = evolutions![1].image
        self.lbName3.text = evolutions![1].name
        
        if evolutions!.count >= 3 {
            self.lbLevel3.text = "\(self.evolutions![2].levelEvolution ?? 0)"
            
            self.img4.image = self.evolutions![2].image
            self.lbName4.text = self.evolutions![2].name
        }
        
    }
    
    
    func evolutionsUltimate() {
        
        
        if evolutions!.count >= 3 {
            self.img5.image = evolutions![2].image
            self.lbName5.text = evolutions![2].name
        }
        
        
        self.lbName6.text = ""
        self.lbLevel5.text = ""
        self.lbEvolutionFinish.isHidden = true
    }
    
}
