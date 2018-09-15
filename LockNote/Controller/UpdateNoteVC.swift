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
  @IBOutlet weak var titleText: UITextField!
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
    noteText.isScrollEnabled = true
    configureKeyboardNotifications()
    
    if let note = note {
      noteText.text = note.noteText
      titleText.text = note.noteTitle
      lockedControl.selectedSegmentIndex = note.isProtected ? 1 : 0
    }
  }
  
  override func viewWillDisappear(_ animated: Bool) {
    removeKeyboardNotifications()
  }
  
  
  @IBAction func updateNote(_ sender: Any) {
    let realm = try! Realm()
    try! realm.write {
      if let note = note {
        note.isProtected = lockedControl.selectedSegmentIndex == 0 ? false : true
        note.noteText = noteText.text!
        note.creationDate = Date()
      }
    }
    self.navigationController?.popViewController(animated: true)
  }
  
  @IBAction func cancelUpdate(_ sender: Any) {
    self.navigationController?.popViewController(animated: true)
  }
  
  // MARK: noteText behaviour for keyboard.
  fileprivate func configureKeyboardNotifications() {
    NotificationCenter.default.addObserver(self, selector: #selector(keyboardWasShown(aNotification:)), name: NSNotification.Name.UIKeyboardDidShow, object: nil)
    NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillBeHidden(aNotification:)), name: NSNotification.Name.UIKeyboardWillHide, object: nil)
  }
  
  fileprivate func removeKeyboardNotifications() {
    NotificationCenter.default.removeObserver(self, name: NSNotification.Name.UIKeyboardDidShow, object: nil)
    NotificationCenter.default.removeObserver(self, name: NSNotification.Name.UIKeyboardWillHide, object: nil)
  }
  
  @objc fileprivate func keyboardWasShown(aNotification:NSNotification) {
    let info = aNotification.userInfo
    let infoNSValue = info![UIKeyboardFrameBeginUserInfoKey] as! NSValue
    let kbSize = infoNSValue.cgRectValue.size
    let contentInsets = UIEdgeInsetsMake(0.0, 0.0, kbSize.height, 0.0)
    noteText.contentInset = contentInsets
    noteText.scrollIndicatorInsets = contentInsets
  }
  
  @objc fileprivate func keyboardWillBeHidden(aNotification:NSNotification) {
    let contentInsets = UIEdgeInsets.zero
    noteText.contentInset = contentInsets
    noteText.scrollIndicatorInsets = contentInsets
  }
  
}
