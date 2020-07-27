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
    @IBOutlet weak var addUpdateButton: UIButton!
    
    @IBOutlet weak var deleteButton: UIButton!
    var imagePicker = UIImagePickerController()
    var iAlreadyReadBooks : ReadBooks? = nil
    
    override func viewDidLoad() {
        super.viewDidLoad()
        imagePicker.delegate = self
        
        if iAlreadyReadBooks != nil {
            readBookImageView.image = UIImage(data: iAlreadyReadBooks!.image as! Data)
            readBookTitle.text = iAlreadyReadBooks!.title
            addUpdateButton.setTitle("Update", for: .normal)
        }
        else{
           deleteButton.isHidden = true
        }

    }


    @IBAction func cameraTapped(_ sender: AnyObject) {
        imagePicker.sourceType = .camera
        present(imagePicker, animated: true, completion: nil)
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
        
        if iAlreadyReadBooks != nil{
            iAlreadyReadBooks!.title = readBookTitle.text
            iAlreadyReadBooks!.image = UIImagePNGRepresentation(readBookImageView.image!) as NSData?
        }
        else{
        let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
        
        let readBooks = ReadBooks(context: context)
        
        readBooks.title = readBookTitle.text
        readBooks.image = UIImagePNGRepresentation(readBookImageView.image!) as NSData?

        }
        (UIApplication.shared.delegate as! AppDelegate).saveContext()
        navigationController!.popViewController(animated: true)
        
    }
    
    @IBAction func deleteTapped(_ sender: AnyObject) {
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
        context.delete(iAlreadyReadBooks!)
        (UIApplication.shared.delegate as! AppDelegate).saveContext()
        navigationController!.popViewController(animated: true)
    }
    
}
