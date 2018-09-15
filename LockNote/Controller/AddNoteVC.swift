//
//  AddNoteVC.swift
//  LockNote
//
//  Created by Andrea Garau on 14/09/2018.
//  Copyright © 2018 Andrea Garau. All rights reserved.
//

import UIKit
import RealmSwift

class AddNoteVC: UIViewController {
  
  //Outlets
  @IBOutlet weak var titleText: UITextField!
  @IBOutlet weak var lockedControl: UISegmentedControl!
  @IBOutlet weak var noteText: UITextView!
  @IBOutlet weak var saveNoteButton: UIButton!
  
  override func viewDidLoad() {
    super.viewDidLoad()
    saveNoteButton.layer.cornerRadius = 10
    noteText.delegate = self
    
    //Placeholder for textView implemented programmatically
    noteText.text = "Write note..."
    noteText.textColor = UIColor.lightGray
  }
  
  @IBAction func saveNote(_ sender: Any) {
    let note = createNote()
    let realm = try! Realm()
    try! realm.write {
      realm.add(note)
    }
    self.navigationController?.popViewController(animated: true)
  }
  
  fileprivate func createNote() -> Note {
    let noteProtection = lockedControl.selectedSegmentIndex == 0 ? false : true
    let note = Note(title: titleText.text!, text: noteText.text!, creationDate: Date(), isProtected: noteProtection)
    return note
  }
}

extension AddNoteVC: UITextViewDelegate {
  func textViewDidBeginEditing(_ textView: UITextView) {
    noteText.text = ""
    noteText.textColor = UIColor.black
  }
}
