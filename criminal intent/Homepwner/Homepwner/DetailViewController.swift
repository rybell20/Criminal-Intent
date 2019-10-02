//
//  DetailViewController.swift
//  CriminalIntent
//
//  Created by Bell, Ryan J. on 2/6/18.
//  Copyright © 2018 Bell, Ryan J. All rights reserved.
//

import Foundation
import UIKit

class DetailViewController: UIViewController, UITextFieldDelegate, UINavigationControllerDelegate, UIImagePickerControllerDelegate {
    
    
    @IBAction func backgroundTapped(_ sender: UITapGestureRecognizer) {
        view.endEditing(true)
    }
    
    @IBOutlet var nameField: UITextField!
    @IBOutlet var serialNumberField: UITextField!
    @IBOutlet var valueField: UITextField!
    @IBOutlet var dateLabel: UILabel!
    
    @IBOutlet weak var datePicker: UIButton!
    
    @IBAction func takePicture(_ sender: UIBarButtonItem) {
        let imagePicker = UIImagePickerController()
        
        //If the device has a camera, take a picture; otherwise,
        //just pick from photo library
        if UIImagePickerController.isSourceTypeAvailable(.camera) {
            imagePicker.sourceType = .camera
        } else {
            imagePicker.sourceType = .photoLibrary
        }
        
        imagePicker.delegate = self
        
        //Place image picker on the screen
        present(imagePicker, animated: true, completion: nil)
    }
    
    @IBOutlet var imageView: UIImageView!
    
    var item: Item! {
        didSet {
            navigationItem.title = "Details"
        }
    }
    var imageStore: ImageStore!
    
    let numberFormatter: NumberFormatter = {
        let formatter = NumberFormatter()
        formatter.numberStyle = .decimal
        formatter.minimumFractionDigits = 2
        formatter.maximumFractionDigits = 2
        return formatter
    }()
    
    let dateFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateStyle = .medium
        formatter.timeStyle = .none
        return formatter
    }()
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        nameField.text = item.name
        serialNumberField.text = item.serialNumber
        
        //        valueField.text = "\(item.valueInDollars)"
        //        dateLabel.text = "\(item.dateCreated)"
        
//        valueField.text = numberFormatter.string(from: NSNumber(value: item.solved))
        valueField.text = item.solved
        dateLabel.text = dateFormatter.string(from: item.dateCreated)
        
        // Get the item key
        let key = item.itemKey
        
        // If there is an associated image with the item
        // display it on the image view
        let imageToDisplay = imageStore.image(forKey: key)
        imageView.image = imageToDisplay
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        // "Save changes to item
        item.name = nameField.text ?? ""
        item.serialNumber = serialNumberField.text!
        item.solved = valueField.text ?? ""
        
//        if let valueText = valueField.text,
//            let value = numberFormatter.number(from: valueText) {
//            item.valueInDollars = value.intValue
//        } else {
//            item.valueInDollars = 0
//        }
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        //If triggered segue is the "showItem" segue
        switch segue.identifier {
        case "showDate"?:
                //Get the item associated with this row and pass it along
                let item = self.item
                let detailDateController = segue.destination as! DetailDateController
                detailDateController.item = item
            
        default: preconditionFailure("Unexpected segue identifier.")
        
        }
    
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        
        //Get picked image from the dictionary
        let image = info[UIImagePickerControllerOriginalImage] as! UIImage
        
        //Store theimage in the ImageStore for the item's key
        imageStore.setImage(image, forKey: item.itemKey)
        
        //Put that image on the screen in the image view
        imageView.image = image
        
        // take image picker off the screen 
        // you must call this dismiss method
        dismiss(animated: true, completion: nil)
    }
    
    

    
}
