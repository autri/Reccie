//
//  ViewController.swift
//  Reccie
//
//  Created by Autri Baghkhanian on 6/11/19.
//  Copyright © 2019 Autri Baghkhanian. All rights reserved.
//

import UIKit
import CoreData

class RecipeListVC: UITableViewController, UIPageViewControllerDelegate {
    
    //MARK: - Properties
    var recipeList = [Recipe]()
    var recipeIndex = 0
    @IBOutlet weak var starButton: UIButton!
    let starImage = UIImage(named: "Image-1")?.withRenderingMode(.alwaysTemplate)
    
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        self.navigationItem.setHidesBackButton(true, animated:true);
        
        loadRecipes()
        
    }
    
    
    //MARK: - Tableview Data Source
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return recipeList.count
        
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "RecipeItemCell", for: indexPath) as? RecipeCellTableViewCell else {
            fatalError("The dequeued cell is not an instance of RecipeItemCell.")
        }
    
        cell.recipeName.text = (recipeList[indexPath.row].name != "" ? recipeList[indexPath.row].name : "No Recipe Name")
        cell.recipeTime.text = (recipeList[indexPath.row].time != 0 ? String(recipeList[indexPath.row].time) + " minutes" : "No Time")
        cell.recipeServings.text = (recipeList[indexPath.row].serving != 0 ? String(recipeList[indexPath.row].serving) + " servings" : "No Servings")
        
        if let imageData = recipeList[indexPath.row].image {
            cell.recipeImage.image = UIImage(data: imageData)
        } else {
            cell.recipeImage.image = UIImage(named: "cameraicon")
        }
        
        if recipeList[indexPath.row].favorite {
            cell.recipeFavorite.setImage(starImage, for: UIControl.State.normal)
            cell.recipeFavorite.tintColor = UIColor(ciColor: .red)
        } else {
            cell.recipeFavorite.setImage(starImage, for: UIControl.State.normal)
            cell.recipeFavorite.tintColor = UIColor(ciColor: .blue)

        }
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 180
    }
    
    //MARK: - Tableview Delegate Methods
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        recipeIndex = indexPath.row
        performSegue(withIdentifier: "showRecipeDetail", sender: self)
    }

    override func shouldPerformSegue(withIdentifier identifier: String, sender: Any?) -> Bool {
        if identifier == "editRecipe" {
            let alert = UIAlertController(title: "Add New Recipe", message: "", preferredStyle: .alert)
            var tapped = false
            var textField = UITextField()
            var recipeObjList = Recipe(context: context)
            
            let actionAdd = UIAlertAction(title: "Add Recipe", style: .default) { (action) in
                
//                self.recipeObj = Recipe(context: self.context)
                recipeObjList.name = textField.text!
                self.saveRecipe()
                
                print("From recipe List action add \(recipeObjList.name!)")
                
                self.recipeList.append(recipeObjList)
                self.recipeIndex = self.recipeList.count - 1
                
                self.tableView.reloadData()
                
                self.performSegue(withIdentifier: "editRecipe", sender: self)
                tapped = true
            }
            let actionCancel = UIAlertAction(title: "Cancel", style: .default) { (action) in
                self.context.delete(recipeObjList)
                tapped = false
            }
            actionCancel.setValue(UIColor.red, forKey: "titleTextColor")
            
            alert.view.tintColor = UIColor.init(red: 0.0, green: 0.569, blue: 0.576, alpha: 1.0)
            alert.view.action
            alert.addTextField { (alertTextField) in
                alertTextField.placeholder = "Create new recipe"
                textField = alertTextField
            }
            
            alert.addAction(actionAdd)
            alert.addAction(actionCancel)
            present(alert, animated: true, completion: nil)
            
            return tapped
        }
        return true
    }
    
    //MARK: - Add New Recipes
    @IBAction func addNewRecipe(_ sender: UIBarButtonItem) {
    }

    @IBAction func favoriteButtonPressed(_ sender: UIButton) {
    }
    
    //MARK:  - Model Manipulation Methods
    func loadRecipes(with request: NSFetchRequest<Recipe> = Recipe.fetchRequest()) {
        do {
            recipeList = try context.fetch(request)
        } catch {
            print("Error fetching request. \(error)")
        }
        
        tableView.reloadData()
    }
    
    // consider removing this since saves and edits won't take place here
    func saveRecipe() {
        do {
            try context.save()
        } catch {
            print("Error saving context. \(error)")
        }
    }
    
    //MARK: - Navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let viewController = segue.destination as? RecipeDetailVC {
            viewController.recipeObj = recipeList[recipeIndex]
        }
        if let viewController = segue.destination as? RecipeEditVC {
            viewController.recipeObj = recipeList[recipeIndex]
        }
    }
    
    @IBAction func unwindAboutPage(unwindSegue: UIStoryboardSegue) {
        print("unwinding about page")
    }

}

//MARK: - Searchbar Methods
extension RecipeListVC: UISearchBarDelegate {

    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        let request: NSFetchRequest<Recipe> = Recipe.fetchRequest()
        request.predicate = NSPredicate(format: "name CONTAINS[cd] %@", searchBar.text!)
        request.sortDescriptors = [NSSortDescriptor(key: "name", ascending: true)]
        
        loadRecipes(with: request)
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        if searchBar.text?.count == 0 {
            loadRecipes()
            DispatchQueue.main.async {
                searchBar.resignFirstResponder()
            }
        }
    }

}

