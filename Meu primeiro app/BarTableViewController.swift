//
//  BarCollectionViewController.swift
//  Meu primeiro app
//
//  Created by Jonathan on 05/02/20.
//  Copyright © 2020 hbsis. All rights reserved.
//

import UIKit
import os.log

private let reuseIdentifier = "Cell"

class BarTableViewController: UITableViewController {
    
    //MARK: Properties
    var bars = [Bar]()
    
    //MARK: Actions
    @IBAction func unwindToMealList(sender: UIStoryboardSegue) {
        if let sourceViewController = sender.source as? ViewController, let bar = sourceViewController.bar {
            
            if let selectedIndexPath = tableView.indexPathForSelectedRow {
                // Update an existing meal.
                bars[selectedIndexPath.row] = bar
                tableView.reloadRows(at: [selectedIndexPath], with: .none)
            } else {
            
            // Add a new meal.
            let newIndexPath = IndexPath(row: bars.count, section: 0)
            
            bars.append(bar)
            tableView.insertRows(at: [newIndexPath], with: .automatic)
            }
        }
    }
    
    //MARK: Private Methods
    private func loadSampleMeals() {
        let photo1 = UIImage(named: "mochilas")
        let photo2 = UIImage(named: "cupimBar")
        let photo3 = UIImage(named: "retroBar")
        
        guard let bar1 = Bar(name: "Moitilas Bar", photo: photo1, rating: 4, cidade:"Qualquer", estado: "qw", bairro: "Qualquer", rua: "Qualquer", numero: 1)  else {
            fatalError("Unable to instantiate meal1")
        }
        
        guard let bar2 = Bar(name: "Cupim Bar", photo: photo2, rating: 1, cidade:"Qualquer", estado: "qw", bairro: "Qualquer", rua: "Qualquer", numero: 1) else {
            fatalError("Unable to instantiate meal2")
        }
        
        guard let bar3 = Bar(name: "Retro Bar", photo: photo3, rating: 3, cidade:"Qualquer", estado: "qw", bairro: "Qualquer", rua: "Qualquer", numero: 1) else {
            fatalError("Unable to instantiate meal2")
        }
        bars += [bar1, bar2, bar3]
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        //Adiciona um botao no lado esquerdo do item
        navigationItem.leftBarButtonItem = editButtonItem

        loadSampleMeals()
        
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return bars.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        // Table view cells are reused and should be dequeued using a cell identifier.
        let cellIdentifier = "BarTableViewCell"
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath) as? BarTableViewCell  else {
            fatalError("The dequeued cell is not an instance of MealTableViewCell.")
        }
        
        // Fetches the appropriate meal for the data source layout.
        let bar = bars[indexPath.row]
        
        cell.nameLabel.text = bar.name
        cell.photoImageView.image = bar.photo
        cell.ratingControl.rating = bar.rating
        
        return cell
    }
    
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            bars.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }
    }
    
    //editando bar
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        super.prepare(for: segue, sender: sender)
        
        switch(segue.identifier ?? "") {
            
        case "AddItem":
            os_log("Adding a new meal.", log: OSLog.default, type: .debug)
            
        case "ShowDetail":
            
            //os guards fazem a verificação se os valores sao diferentes de zero
            guard let mealDetailViewController = segue.destination as? ViewController else {
                fatalError("Unexpected destination: \(segue.destination)")
            }
            
            guard let selectedMealCell = sender as? BarTableViewCell else {
                fatalError("Unexpected sender: \(sender)")
            }
            
            guard let indexPath = tableView.indexPath(for: selectedMealCell) else {
                fatalError("The selected cell is not being displayed by the table")
            }
            
            let selectedMeal = bars[indexPath.row]
            mealDetailViewController.bar = selectedMeal
            
        default:
            fatalError("Unexpected Segue Identifier; \(segue.identifier)")
        }
    }
}
