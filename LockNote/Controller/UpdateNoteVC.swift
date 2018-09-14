//
//  UpdateNoteVC.swift
//  LockNote
//
//  Created by Andrea Garau on 14/09/2018.
//  Copyright © 2018 Andrea Garau. All rights reserved.
//

import UIKit
import RealmSwift

class UpdateNoteVC: UIViewController {
  
  //Outlets
  @IBOutlet weak var dateText: UILabel!
  @IBOutlet weak var lockedControl: UISegmentedControl!
  @IBOutlet weak var noteText: UITextView!
  @IBOutlet weak var updateButton: UIButton!
  @IBOutlet weak var cancelButton: UIButton!
  
  //Variables
  var note: Note? = nil
  
  override func viewDidLoad() {
    super.viewDidLoad()
    updateButton.layer.cornerRadius = 10
    cancelButton.layer.cornerRadius = 10
  }
  
  @IBAction func updateNote(_ sender: Any) {
    let realm = try! Realm()
    try! realm.write {
      if let note = note {
        note.isProtected = lockedControl.selectedSegmentIndex == 0 ? false : true
        note.noteText = noteText.text!
      }
    }
  }
  
  @IBAction func cancelUpdate(_ sender: Any) {
    dismiss(animated: true, completion: nil)
  }
  
}
