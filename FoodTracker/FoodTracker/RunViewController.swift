//
//  RunViewController.swift
//  FoodTracker
//
//  Created by Reid Sherman MAT on 8/1/17.
//  Copyright © 2017 Reid Sherman. All rights reserved.
//

import UIKit

class RunViewController: UIViewController, UITextFieldDelegate, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    //MARK: Properties
    @IBOutlet weak var locationTextField: UITextField!
    @IBOutlet weak var timeTextField: UITextField!
    @IBOutlet weak var dayTextField: UITextField!
    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var saveButton: UIBarButtonItem!
    var run: Run?
    override func viewDidLoad() {
        super.viewDidLoad()
        nameTextField.delegate = self
        if let run = run {
            navigationItem.title = run.name
            nameTextField.text = run.name
            dayTextField.text = run.day
            timeTextField.text = run.time
            locationTextField.text = run.location
        }
        // Enable save button if valid properties
        updateSaveButtonState()
    }
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    //MARK: UITextFieldDelegate
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        // Hide the keyboard.
        textField.resignFirstResponder()
        return true
    }
    func textFieldDidBeginEditing(_ textField: UITextField) {
        // Disable the Save button while editing.
        saveButton.isEnabled = false
    }
    func textFieldDidEndEditing(_ textField: UITextField) {
        updateSaveButtonState()
        navigationItem.title = textField.text
    }
    // MARK: - Navigation
    @IBAction func cancel(_ sender: UIBarButtonItem) {
        let isPresentingInAddRunMode = presentingViewController is UINavigationController
        if isPresentingInAddRunMode {
            dismiss(animated: true, completion: nil)
        }
        else if let owningNavigationController = navigationController{
            owningNavigationController.popViewController(animated: true)
        }
        else {
            fatalError("RunViewController is not inside a nav controller")
        }
    }
    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        super.prepare(for: segue, sender: sender)
        // Configure the destination view controller only when the save button is pressed.
        guard let button = sender as? UIBarButtonItem, button === saveButton else {
            //os_log("The save button was not pressed, cancelling", log: OSLog.default, type: .debug)
            return
        }
        let name = nameTextField.text ?? ""
        let day = dayTextField.text ?? ""
        let time = timeTextField.text ?? ""
        let location = locationTextField.text ?? ""
        
        run = Run(name: name, day: day, time: time, location: location)
    }
    //MARK: Private Methods
    private func updateSaveButtonState() {
        // Disable the Save button if the text field is empty.
        let text = nameTextField.text ?? ""
        saveButton.isEnabled = !text.isEmpty
    }
    
    
    

}
