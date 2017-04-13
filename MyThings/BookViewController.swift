//
//  BookViewController.swift
//  MyThings
//
//  Created by Roger Villarreal on 4/11/17.
//  Copyright © 2017 Big Nerd Ranch. All rights reserved.
//

import UIKit

class BookViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {

    // MARK: Outlets
    @IBOutlet var deleteButton: UIButton!
    
    @IBOutlet var addUpdateButton: UIButton!
    
    @IBOutlet var bookImageView: UIImageView!

    @IBOutlet var titleTextField: UITextField!
    
    var imagePicker = UIImagePickerController()

    var book : Book? = nil

    // MARK: ViewDidLoad
    override func viewDidLoad() {
        super.viewDidLoad()
        
        imagePicker.delegate = self
        
        if book != nil {
            bookImageView.image = UIImage(data: book!.image! as Data)
            titleTextField.text = book?.title
            addUpdateButton.setTitle("Update", for: .normal)
        } else {
            deleteButton.isHidden = true
        }
        
    }

    // MARK: Actions
    @IBAction func cameraTapped(_ sender: Any) {
        imagePicker.sourceType = .photoLibrary
        present(imagePicker, animated: true, completion: nil)
    }
    
    @IBAction func photosTapped(_ sender: Any) {
        imagePicker.sourceType = .photoLibrary
        present(imagePicker, animated: true, completion: nil)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        
        let image = info[UIImagePickerControllerOriginalImage] as! UIImage
        
        bookImageView.image = image
        
        imagePicker.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func addTapped(_ sender: Any) {
        
        if book != nil {
            book?.title = titleTextField.text
            book?.image = UIImagePNGRepresentation(bookImageView.image!)! as NSData
        } else {
            let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
            let book = Book(context: context)
            book.title = titleTextField.text
            book.image = UIImagePNGRepresentation(bookImageView.image!)! as NSData
        }
        (UIApplication.shared.delegate as! AppDelegate).saveContext()
        navigationController?.popViewController(animated: true)
    }
    @IBAction func deleteTapped(_ sender: Any) {
        let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
        context.delete(book!)
        
        (UIApplication.shared.delegate as! AppDelegate).saveContext()
        navigationController?.popViewController(animated: true)
    }
}
