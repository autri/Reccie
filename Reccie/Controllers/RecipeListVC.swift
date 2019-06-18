//
//  ViewController.swift
//  Reccie
//
//  Created by Autri Baghkhanian on 6/11/19.
//  Copyright © 2019 Autri Baghkhanian. All rights reserved.
//

import UIKit
import CoreData

class RecipeListVC: UITableViewController {

    var recipeList = [Recipe]()
    var recipeDetail = Recipe()
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        loadRecipe()
        
    }
    
    
    //MARK: - Tableview Data Source
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return recipeList.count
        
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "RecipeItemCell", for: indexPath)
        cell.textLabel?.text = recipeList[indexPath.row].name
        cell.accessoryType = .disclosureIndicator
        
        return cell
    }
    
    //MARK: - Tableview Delegate Methods
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        recipeDetail = recipeList[indexPath.row]
        performSegue(withIdentifier: "showRecipeDetail", sender: self)
    }
    
    //MARK: - Add New Recipes
   
    @IBAction func addNewRecipe(_ sender: UIBarButtonItem) {
        performSegue(withIdentifier: "addNewRecipe", sender: self)
    }
    
    //MARK: Model Manipulation Methods
    func loadRecipe(with request: NSFetchRequest<Recipe> = Recipe.fetchRequest()) {
        do {
            recipeList = try context.fetch(request)
        } catch {
            print("Error fetching request. \(error)")
        }
        
        tableView.reloadData()
    }
    
    //MARK: Navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let viewController = segue.destination as? RecipeDetailVC {
            viewController.recipeObj = recipeDetail
        }
    }

}

extension RecipeListVC: UISearchBarDelegate {
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        let request: NSFetchRequest<Recipe> = Recipe.fetchRequest()
        request.predicate = NSPredicate(format: "name CONTAINS[cd] %@", searchBar.text!)
        request.sortDescriptors = [NSSortDescriptor(key: "name", ascending: true)]
        
        loadRecipe(with: request)
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        if searchBar.text?.count == 0 {
            loadRecipe()
            DispatchQueue.main.async {
                searchBar.resignFirstResponder()
            }
        }
    }

}

