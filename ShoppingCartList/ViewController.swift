//
//  ViewController.swift
//  ShoppingCartList
//
//  Created by user163948 on 4/8/20.
//  Copyright © 2020 lecosas. All rights reserved.
//

import UIKit

class ViewController: UITableViewController {

    var shoppingList = [String]()
    var shareButton = UIBarButtonItem()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(promptForItem))
        navigationItem.leftBarButtonItem = UIBarButtonItem(title: "Clear", style: .plain, target: self, action: #selector(clearItems))
        
        let spacer = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
        shareButton = UIBarButtonItem(barButtonSystemItem: .action, target: self, action: #selector(shareItems))
        let buttons = [spacer, shareButton]
        
        toolbarItems = buttons
        navigationController?.isToolbarHidden = false
    }

    @objc func shareItems() {
        let shoppingListText = shoppingList.joined(separator: "\n")
        let av = UIActivityViewController(activityItems: [shoppingListText], applicationActivities: nil)
        av.popoverPresentationController?.barButtonItem = shareButton
        present(av, animated: true)
    }
    
    @objc func promptForItem() {
        let ac = UIAlertController(title: "Insert item", message: nil, preferredStyle: .alert)
        ac.addTextField()
        
        let addAction = UIAlertAction(title: "Add", style: .default, handler: { [weak self, weak ac] (action) in
            guard let item = ac?.textFields?[0].text else { return }
            self?.addItem(item)
        })
        
        ac.addAction(addAction)
        ac.addAction(UIAlertAction(title: "Cancel", style: .cancel))
        present(ac, animated: true)
    }
        
    @objc func clearItems() {
        shoppingList.removeAll()
        tableView.reloadData()
    }
    
    func addItem(_ item: String) {
        shoppingList.insert(item, at: 0)
        let indexPath = IndexPath(row: 0, section: 0)
        tableView.insertRows(at: [indexPath], with: .automatic)
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return shoppingList.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Item", for: indexPath)
        cell.textLabel?.text = shoppingList[indexPath.row]
        return cell
    }
    
}

