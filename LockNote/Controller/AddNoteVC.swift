//
//  AddNoteVC.swift
//  LockNote
//
//  Created by Andrea Garau on 14/09/2018.
//  Copyright © 2018 Andrea Garau. All rights reserved.
//

import UIKit

class AddNoteVC: UIViewController {
  
  //Outlets
  @IBOutlet weak var dateText: UILabel!
  @IBOutlet weak var lockedControl: UISegmentedControl!
  @IBOutlet weak var noteText: UITextView!
  @IBOutlet weak var saveNoteButton: UIButton!
  
  override func viewDidLoad() {
    super.viewDidLoad()
    saveNoteButton.layer.cornerRadius = 10
  }
  
  @IBAction func saveNote(_ sender: Any) {
    
  }
}
