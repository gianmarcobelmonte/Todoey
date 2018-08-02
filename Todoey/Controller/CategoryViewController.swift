//
//  CategoryViewController.swift
//  Todoey
//
//  Created by Gianmarco Belmonte on 01/08/18.
//  Copyright © 2018 Gianmarco Belmonte. All rights reserved.
//

import UIKit
import RealmSwift
import ChameleonFramework

class CategoryViewController: SwipeTableViewController {
    
    let realm = try! Realm()
    
    var categories: Results<Category>?
    
    var navBarColour: UIColor?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        loadCategories()
        navBarColour = UIColor.randomFlat
        updateNavBar(with: navBarColour!)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    //MARK: - TableView Datasource Methods
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return categories?.count ?? 1
    }
    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = super.tableView(tableView, cellForRowAt: indexPath)
        
        if let category = categories?[indexPath.row] {
            cell.textLabel?.text = category.title
            guard let categoryColour = UIColor(hexString: category.hexValue) else { fatalError("Category colour doesn\'t exist") }
            cell.backgroundColor = categoryColour
            cell.textLabel?.textColor = ContrastColorOf(categoryColour, returnFlat: true)
        }

        return cell
    }
    
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: "goToItems", sender: self)
    }
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let destinationVC = segue.destination as! ItemViewController
        
        if let indexPath = tableView.indexPathForSelectedRow {
            destinationVC.selectedCategory = categories?[indexPath.row]
            destinationVC.mainNavBarColour = navBarColour
        }
    }

    
    
    @IBAction func addButtonPressed(_ sender: UIBarButtonItem) {
        var textField = UITextField()
        
        let alert = UIAlertController(title: "Add New Category", message: "", preferredStyle: .alert)
        
        let action = UIAlertAction(title: "Add", style: .default) { (action) in
            let newCategory = Category()
            newCategory.title = textField.text!
            self.save(category: newCategory)
        }
        
        alert.addTextField { (alertTextField) in
            textField = alertTextField
            textField.placeholder = "Add a new Category"
        }
        
        alert.addAction(action)
        present(alert, animated: true, completion: nil)
    }
    
    
    //MARK: - Data Manipulation Methods
    
    func save(category: Category) {
        do {
            try realm.write {
                realm.add(category)
            }
        } catch {
            print("Error while saving category, \(error)")
        }
        
        tableView.reloadData()
    }
    
    func loadCategories() {
        categories = realm.objects(Category.self)
        tableView.reloadData()
    }
    
    override func updateModel(at indexPath: IndexPath) {
        
        if let categoryToDelete = self.categories?[indexPath.row] {
            do {
                try self.realm.write {
                    self.realm.delete(categoryToDelete)
                }
            } catch {
                print("Error deleting category, \(error)")
            }
        }
    }
    
    override func editModel(at indexPath: IndexPath) {
        var textField = UITextField()
        
        let alert = UIAlertController(title: "Edit Category Name", message: "", preferredStyle: .alert)
        
        let action = UIAlertAction(title: "Modify", style: .default) { (action) in
            if let category = self.categories?[indexPath.row] {
                
                do {
                    try self.realm.write {
                        category.title = textField.text!
                    }
                } catch {
                    print("Error updating category text, \(error)")
                }
            }
            self.tableView.reloadData()
        }
        
        alert.addTextField { (alertTextField) in
            textField = alertTextField
            textField.placeholder = "New category name"
        }
        
        alert.addAction(action)
        present(alert, animated: true, completion: nil)
    }
    
    
    //MARK: - NavBar Setup Methods
    func updateNavBar(with navBarColour: UIColor) {
        guard let navBar = navigationController?.navigationBar else { fatalError("Navigation Controller doesn\'t exist") }
        //Background navbar colour
        navBar.barTintColor = navBarColour
        
        //Navigation Items and Button colour
        navBar.tintColor = ContrastColorOf(navBarColour, returnFlat: true)
        
        //Title (text) colour
        navBar.largeTitleTextAttributes = [NSAttributedStringKey.foregroundColor : ContrastColorOf(navBarColour, returnFlat: true)]
        
    }
    


}

