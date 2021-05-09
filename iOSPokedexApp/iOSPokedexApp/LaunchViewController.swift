//
//  LaunchViewController.swift
//  iOSPokedexApp
//
//  Created by Lenin on 1/13/21.
//

import UIKit

class LaunchViewController: UIViewController {

    @IBOutlet var viewBack: UIView!
    override func viewDidLoad() {
        super.viewDidLoad()
        self.designViewBack()
        // Do any additional setup after loading the view.
    }
    
    func designViewBack() {
        let gradient: CAGradientLayer = CAGradientLayer()
        gradient.frame = self.viewBack.frame
        gradient.colors = [UIColor.init(red: (222.0/255.0), green: (239.0/255.0), blue: (249.0/255.0), alpha: 1.0).cgColor, UIColor.init(red: (227.0/255.0), green: (245.0/255.0), blue: (221.0/255.0), alpha: 1.0).cgColor, UIColor.init(red: (218.0/255.0), green: (246.0/255.0), blue: (221.0/255.0), alpha: 0.1).cgColor]
        //gradient.locations = [0, 0.58888]
        gradient.startPoint = CGPoint(x: 0, y: 0)
        gradient.endPoint = CGPoint(x: 1, y: 1)
        self.viewBack.layer.insertSublayer(gradient, at: 0)
        let layer: CALayer = CALayer(layer: self.viewBack.layer)
        self.view.layer.insertSublayer(layer, at: 0)
         
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
