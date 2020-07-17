//
//  ViewController.swift
//  iReadBooks
//
//  Created by vignesh on 7/15/20.
//  Copyright © 2020 AmVi. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {

    @IBOutlet weak var tableView: UITableView!
    
    var readBooks : [ReadBooks] = []
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.dataSource = self
        tableView.delegate = self

    }

    override func viewWillAppear(_ animated: Bool) {
        
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
       
        do{
       readBooks =  try context.fetch(ReadBooks.fetchRequest())
            tableView.reloadData()
            
        }
        catch{
            
        }
        
        
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return readBooks.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell()
        let read = readBooks[indexPath.row]
        cell.textLabel?.text = read.title
        cell.imageView?.image = UIImage(data: read.image as! Data)
        return cell
    }


}

