//
//  ItemsViewController.swift
//  Homepwner
//
//  Created by Bell, Ryan J. on 11/20/17.
//  Copyright © 2017 Bell, Ryan J. All rights reserved.
//

import Foundation
import UIKit

class ItemsViewController: UITableViewController {
    
    var itemStore: ItemStore!
    var imageStore: ImageStore!
    
    
    var item: Item!{
        didSet {
            navigationItem.title = "Criminal Intent"
            
        }
    }
    
    @IBAction func addNewItem(_ sender: UIBarButtonItem) {
        
//        //Make new index path for the 0th section, last row
//        let lastRow = tableView.numberOfRows(inSection: 0)
//        let indexPath = IndexPath(row: lastRow, section: 0)
//        
//        //insert this new row into the table
//        tableView.insertRows(at: [indexPath], with: .automatic)
        
        // Create a new item and add it to the store
        let newItem = itemStore.createItem()
        
        // Figure out where that item is in the array
        if let index = itemStore.allItems.index(of: newItem) {
            let indexPath = IndexPath(row: index, section: 0)
        // Insert this new row into the table
        tableView.insertRows(at: [indexPath], with: .automatic)
        }
    }
    
//    @IBAction func toggleEditingMode(_ sender: UIButton) {
//        // If you are currently in editing mode...
//        if isEditing {
//            // Change text of button to inform user of state
//            sender.setTitle("Edit", for: .normal)
//            
//            // Turn off editing mode
//            setEditing(false, animated: true)
//            
//        } else {
//            // Change text of button to inform user of state
//            sender.setTitle("Done", for: .normal)
//            
//            // Enter editing mode
//            setEditing(true, animated: true)    
//        }
//        
//    }
    
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return itemStore.allItems.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//        // Create an instance of UITableViewCell, with default appearance
//        let cell = UITableViewCell(style: .value1, reuseIdentifier: "UITableViewCell")
        
        // Get a new or recycled cell
//        let cell = tableView.dequeueReusableCell(withIdentifier: "UITableViewCell", for: indexPath)
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "ItemCell", for: indexPath) as! ItemCell
        
        // Set the text on the cell with the description of the item
        // that is at the nth index of items, where n = row this cell
        // will appear in on the tableview
        let item = itemStore.allItems[indexPath.row]
        
//        cell.textLabel?.text = item.name
//        cell.detailTextLabel?.text = "\(item.serialNumber)"
        
        // Configure the cell with the Item
        cell.nameLabel.text = item.name
        cell.serialNumberLabel.text = item.serialNumber
        cell.valueLabel.text = item.solved
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        // If the table view is asking to commit a delete command...
        if editingStyle == .delete {
            let item = itemStore.allItems[indexPath.row]
            
            let title = "Delete \(item.name)?"
            let message = "Are you sure you want to delete this item?"
            
            let ac = UIAlertController(title: title, message: message, preferredStyle: .actionSheet)
            
            let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
            ac.addAction(cancelAction)
            
            let deleteAction = UIAlertAction(title: "Delete", style: .destructive, handler: { (action) -> Void in
                
            // Remove the item from the store
            self.itemStore.removeItem(item)
                
            // Remove the item's image from the image store
                self.imageStore.deleteImage(forKey: item.itemKey)
            
            // Also remove that row from the table view with an animation
            self.tableView.deleteRows(at: [indexPath], with: .automatic)
        })
        
        ac.addAction(deleteAction)
            
        // Present the alert controller
            present(ac, animated: true, completion: nil)
            
        }
    }
    
    override func tableView(_ tableView: UITableView, moveRowAt sourceIndexPath: IndexPath, to destinationIndexPath: IndexPath) {
        // Update the model
        itemStore.moveItem(from: sourceIndexPath.row, to: destinationIndexPath.row)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
//        // Get the height of the status bar
//        let statusBarHeight = UIApplication.shared.statusBarFrame.height
//        
//        let insets = UIEdgeInsets(top: statusBarHeight, left: 0, bottom: 0, right: 0)
//        tableView.contentInset = insets
//        tableView.scrollIndicatorInsets = insets
        
//        tableView.rowHeight = 65
        tableView.rowHeight = UITableViewAutomaticDimension
        tableView.estimatedRowHeight = 65
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        //If triggered segue is the "showItem" segue
        switch segue.identifier {
        case "showItem"?:
            //Figure out which row was just tapped
            if let row = tableView.indexPathForSelectedRow?.row {
                
                //Get the item associated with this row and pass it along
                let item = itemStore.allItems[row]
                let detailViewController = segue.destination as! DetailViewController
                detailViewController.item = item
                detailViewController.imageStore = imageStore
            }
        default: preconditionFailure("Unexpected segue identifier.")
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        tableView.reloadData()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
        navigationItem.leftBarButtonItem = editButtonItem
    }

}
