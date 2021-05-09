//
//  ExtensionMovesViewController.swift
//  iOSPokedexApp
//
//  Created by Lenin on 1/16/21.
//
import UIKit
extension MovesViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if self.moves?.count != 0 {
            return self.moves!.count
        } else {return 0}
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! MovesTableViewCell
        
        cell.setCellWithValuesOf(moves![indexPath.row])

        return cell
    }
    
    
}
