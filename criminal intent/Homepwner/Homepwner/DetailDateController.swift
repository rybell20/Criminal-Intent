//
//  DetailDateController.swift
//  CriminalIntent
//
//  Created by Bell, Ryan J. on 2/13/18.
//  Copyright © 2018 Bell, Ryan J. All rights reserved.
//

import Foundation
import UIKit

class DetailDateController: UIViewController, UITextFieldDelegate {

    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var datePicker: UIDatePicker!
    @IBAction func datePickerChanged(_ sender: UIDatePicker) {
        
        dateLabel.text = dateFormatter.string(from: datePicker.date)
        
    }
    
    var item: Item! {
        didSet {
            navigationItem.title = "Set Date"
        }
    }
    
    let dateFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateStyle = .medium
        formatter.timeStyle = .none
        return formatter
    }()
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        dateLabel.text = dateFormatter.string(from: item.dateCreated)
        datePicker.datePickerMode = .date
        datePicker.date = item.dateCreated
        
}
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        // "Save changes to item
        
        item.dateCreated = dateFormatter.date(from: dateLabel.text!)!
    }


}
