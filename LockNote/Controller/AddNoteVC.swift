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
    noteText.isScrollEnabled = true
    
    //Placeholder for textView implemented programmatically
    noteText.text = "Write note..."
    noteText.textColor = UIColor.lightGray
    
    configureKeyboardNotifications()
  }
  
  override func viewWillDisappear(_ animated: Bool) {
    removeKeyboardNotifications()
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
  
  // MARK: noteText behaviour for keyboard.
  func configureKeyboardNotifications() {
    NotificationCenter.default.addObserver(self, selector: #selector(keyboardWasShown(aNotification:)), name: NSNotification.Name.UIKeyboardDidShow, object: nil)
    NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillBeHidden(aNotification:)), name: NSNotification.Name.UIKeyboardWillHide, object: nil)
  }
  
  fileprivate func removeKeyboardNotifications() {
    NotificationCenter.default.removeObserver(self, name: NSNotification.Name.UIKeyboardDidShow, object: nil)
    NotificationCenter.default.removeObserver(self, name: NSNotification.Name.UIKeyboardWillHide, object: nil)
  }
  
  
  @objc func keyboardWasShown(aNotification:NSNotification) {
    let info = aNotification.userInfo
    let infoNSValue = info![UIKeyboardFrameBeginUserInfoKey] as! NSValue
    let kbSize = infoNSValue.cgRectValue.size
    let contentInsets = UIEdgeInsetsMake(0.0, 0.0, kbSize.height, 0.0)
    noteText.contentInset = contentInsets
    noteText.scrollIndicatorInsets = contentInsets
  }
  
  @objc func keyboardWillBeHidden(aNotification:NSNotification) {
    let contentInsets = UIEdgeInsets.zero
    noteText.contentInset = contentInsets
    noteText.scrollIndicatorInsets = contentInsets
  }

}

extension AddNoteVC: UITextViewDelegate {
  func textViewDidBeginEditing(_ textView: UITextView) {
    noteText.text = ""
    noteText.textColor = UIColor.black
  }
}



