//
//  ViewController.swift
//  MyThings
//
//  Created by Roger Villarreal on 4/8/17.
//  Copyright © 2017 Big Nerd Ranch. All rights reserved.
// test

import UIKit

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet var tableView: UITableView!
    var books : [Book] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.delegate = self
        tableView.dataSource = self
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        
        let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
        
        do {
            books = try context.fetch(Book.fetchRequest())
            tableView.reloadData()
        } catch {
            
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return books.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell()
        let book = books[indexPath.row]
        cell.textLabel?.text = book.title
        cell.imageView?.image = UIImage(data: book.image! as Data)
        return cell
    }
}

