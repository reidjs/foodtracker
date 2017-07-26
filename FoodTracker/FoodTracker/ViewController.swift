//
//  ViewController.swift
//  FoodTracker
//
//  Created by Reid Sherman MAT on 7/21/17.
//  Copyright © 2017 Reid Sherman. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITextFieldDelegate, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    //MARK: Properties
    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var mealNameLabel: UILabel!
    @IBOutlet weak var photoImageView: UIImageView!
    @IBOutlet weak var ratingControl: RatingControl!
    override func viewDidLoad() {
        super.viewDidLoad()
        //Handle the text field's user input through delegate callbacks
        nameTextField.delegate = self
    }
    //MARK: UITextFieldDelegate
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        // Hide the keyboard.
        textField.resignFirstResponder()
        return true
    }
    func textFieldDidEndEditing(_ textField: UITextField) {
        mealNameLabel.text = textField.text
    }
    //MARK: UIImagePickerControllerDelegate
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        //dismiss picker if user cancelled
        dismiss(animated: true, completion: nil)
    }
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        //info dictionary may contain multiple representations of the image. You want original
        guard let selectedImage = info[UIImagePickerControllerOriginalImage] as? UIImage else {
            fatalError("Expected dictionary containing image, but was instead provided with: \(info)")
        }
        //set photoimageview to display the image
        photoImageView.image = selectedImage
        dismiss(animated: true, completion: nil)
    }
    //MARK: Actions
    @IBAction func selectImageFromPhotoLibrary(_ sender: UITapGestureRecognizer) {
        //Hide the keyboard
        nameTextField.resignFirstResponder()
        //UIImagePickerController is a view controller that lets user pick media from photo library
        let imagePickerController = UIImagePickerController()
        //only allow photos to be picked, not taken
        imagePickerController.sourceType = .photoLibrary 
        //make sure viewcontroller is notified when user picks image
        imagePickerController.delegate = self
        present(imagePickerController, animated: true, completion: nil)
        
    }
    @IBAction func setDefaultLabelText(_ sender: UIButton) {
        mealNameLabel.text = "Default Text"
    }
}

