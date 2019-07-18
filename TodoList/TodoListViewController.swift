//
//  TodoListViewController.swift
//  TodoList
//
//  Created by Megat Syafiq on 13/07/2019.
//  Copyright © 2019 Megat Syafiq. All rights reserved.
//

import UIKit
import CoreData

class TodoListViewController: UIViewController {
    @IBOutlet weak var tableView: UITableView!
    
    var items = [Items]()
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    override func viewDidLoad() {
        super.viewDidLoad()
        loadData()

        print ("hi! second screen")
        // Do any additional setup after loading the view.
    }
    
    func loadData() {
        let request: NSFetchRequest<Items> = Items.fetchRequest()
        do {
            items = try context.fetch(request)
        } catch {
            print ("error: \(error)")
        }
        tableView.reloadData()
    }
    func saveItems () {
        do {
            try context.save()
        } catch {
            print ("error saving items with \(error)")
        }
        tableView.reloadData()
    }

    @IBAction func addItemDidTapped(_ sender: Any) {
        var textField = UITextField()
        
        let alert = UIAlertController(title: "Add New Item", message: "", preferredStyle: .alert)
        let action = UIAlertAction(title: "Add Item", style: .default) { (action) in
            let newItem = Items(context: self.context)
            newItem.name = textField.text!
            self.items.append(newItem)
            self.saveItems()
        }
        alert.addAction(action)
        alert.addTextField { (field) in
            textField = field
            textField.placeholder = "Add a New Item"
        }
        present(alert, animated: true, completion: nil)
    }
    

}

extension TodoListViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
         return items.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cellid = "itemcell"
        var cell = tableView.dequeueReusableCell(withIdentifier: cellid, for: indexPath) as UITableViewCell
        cell = UITableViewCell(style: .subtitle, reuseIdentifier: cellid)
        let item = items[indexPath.row]
        cell.textLabel?.text = item.name
        if item.completed {
            cell.detailTextLabel?.text = "Completed"
        } else {
            cell.detailTextLabel?.text = "In Progress"
        }
        cell.accessoryType = item.completed ? .checkmark : .none
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        items[indexPath.row].completed = !items[indexPath.row].completed
        saveItems()
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        
        if (editingStyle == .delete) {
            print ("items deleted")
            let item = items[indexPath.row]
            items.remove(at:indexPath.row)
            context.delete(item)
            
            do {
                try context.save()
            } catch {
                print ("error: \(error)")
            }
            tableView.deleteRows(at: [indexPath], with: .automatic)
        }
    }

    
    
}
