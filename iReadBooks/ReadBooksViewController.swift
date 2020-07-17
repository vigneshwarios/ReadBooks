//
//  ReadBooksViewController.swift
//  iReadBooks
//
//  Created by vignesh on 7/15/20.
//  Copyright © 2020 AmVi. All rights reserved.
//

import UIKit

class ReadBooksViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate{

    @IBOutlet weak var readBookTitle: UITextField!
    @IBOutlet weak var readBookImageView: UIImageView!
    
    var imagePicker = UIImagePickerController()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        imagePicker.delegate = self

    }


    @IBAction func cameraTapped(_ sender: AnyObject) {
    }

    @IBAction func photosTapped(_ sender: AnyObject) {
        imagePicker.sourceType = .photoLibrary
        
        present(imagePicker, animated: true, completion: nil)
    }

    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        let image = info[UIImagePickerControllerOriginalImage] as! UIImage
        
    
        readBookImageView.image = image
        imagePicker.dismiss(animated: true, completion: nil)
        
    }
    
    @IBAction func readBooksAddButton(_ sender: AnyObject) {
        let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
        
        let readBooks = ReadBooks(context: context)
        
        readBooks.title = readBookTitle.text
        readBooks.image = UIImagePNGRepresentation(readBookImageView.image!) as NSData?
        (UIApplication.shared.delegate as! AppDelegate).saveContext()
        navigationController!.popViewController(animated: true)
        
    }
}
