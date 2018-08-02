//
//  SwipeTableViewController.swift
//  Todoey
//
//  Created by Gianmarco Belmonte on 01/08/18.
//  Copyright © 2018 Gianmarco Belmonte. All rights reserved.
//

import UIKit
import SwipeCellKit
import ChameleonFramework

class SwipeTableViewController: UITableViewController, SwipeTableViewCellDelegate {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.rowHeight = 90.0
        tableView.separatorStyle = .none
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as! SwipeTableViewCell
        cell.delegate = self
        return cell
    }
    
    //MARK: - Swipe Methods
    
    func tableView(_ tableView: UITableView, editActionsForRowAt indexPath: IndexPath, for orientation: SwipeActionsOrientation) -> [SwipeAction]? {
        guard orientation == .right else { return nil }
        
        let deleteAction = SwipeAction(style: .destructive, title: "Delete") { action, indexPath in
            // handle action by updating model with deletion
            self.updateModel(at: indexPath)
        }
        
        
        let editAction = SwipeAction(style: .destructive, title: "Edit") { (action, indexPath) in
            self.editModel(at: indexPath)
        }
        
        // customize the action appearance
        deleteAction.image = UIImage(named: "delete-icon")
        deleteAction.backgroundColor = UIColor(hexString: "ECEAEA")
        deleteAction.textColor = UIColor(hexString: "FF001F")
        
        editAction.image = UIImage(named: "edit-icon")
        editAction.backgroundColor = UIColor(hexString: "ECEAEA")
        editAction.textColor = UIColor(hexString: "F37401")
        
        return [deleteAction,editAction]
    }
    
    
    func tableView(_ tableView: UITableView, editActionsOptionsForRowAt indexPath: IndexPath, for orientation: SwipeActionsOrientation) -> SwipeOptions {
        var options = SwipeOptions()
        options.expansionStyle = .destructive
        options.transitionStyle = .border
        return options
    }
    
    func updateModel(at indexPath: IndexPath) {
        //Delete Data from Swipe
    }
    
    func editModel(at indexPath: IndexPath) {
        //Modify text form Category or Item
    }


}
