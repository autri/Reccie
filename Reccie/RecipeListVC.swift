//
//  ViewController.swift
//  Reccie
//
//  Created by Autri Baghkhanian on 6/11/19.
//  Copyright © 2019 Autri Baghkhanian. All rights reserved.
//

import UIKit

class RecipeListVC: UITableViewController {

    let recipeList = ["Cake", "Pizza", "Rice"]
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
    }
    
    
    //MARK - Tableview Data Source
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return recipeList.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "RecipeItemCell", for: indexPath)
        cell.textLabel?.text = recipeList[indexPath.row]
        cell.accessoryType = .disclosureIndicator
        
        return cell
    }
    
    //MARK - Tableview Delegate Methods
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        tableView.deselectRow(at: indexPath, animated: true)
    }
    

}

