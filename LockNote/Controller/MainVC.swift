//
//  ViewController.swift
//  LockNote
//
//  Created by Andrea Garau on 14/09/2018.
//  Copyright © 2018 Andrea Garau. All rights reserved.
//

import UIKit
import LocalAuthentication
import RealmSwift

class MainVC: UIViewController {
  
  //Outlets
  @IBOutlet weak var tableView: UITableView!
  
  //Variables
  fileprivate var notes = [Note]()
  let context = LAContext()

  override func viewDidLoad() {
    super.viewDidLoad()
    tableView.delegate = self
    tableView.dataSource = self
    if let notes = fetchNotes(forProperty: "creationDate") {
      self.notes = notes
    }
    self.tableView.reloadData()
  }
  
  override func viewWillAppear(_ animated: Bool) {
    if let notes = fetchNotes(forProperty: "creationDate") {
      self.notes = notes
    }
    self.tableView.reloadData()
  }
  
  
  // MARK: Operations with Realm database
  private func fetchNotes(forProperty property: String, ascending: Bool = false) -> [Note]? {
    let realm = try! Realm()
    let notesResult = realm.objects(Note.self).sorted(byKeyPath: property, ascending: ascending)
    var notes = [Note]()
    for note in notesResult { notes.append(note) }
    
    return notes
  }
  
  private func removeNote(_ note: Note) {
    let realm = try! Realm()
    try! realm.write {
      realm.delete(note)
    }
  }

  // MARK: Segue manipolation
  override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
    if segue.identifier == TO_EDIT_SEGUE {
      if let updateVC = segue.destination as? UpdateNoteVC {
        if let note = sender as? Note {
          updateVC.note = note
        }
      }
    }
  }
}


// MARK: TableView implementation
extension MainVC: UITableViewDelegate, UITableViewDataSource {
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return notes.count
  }
  
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    guard let cell = tableView.dequeueReusableCell(withIdentifier: "NoteCell", for: indexPath) as? NoteCell else { return UITableViewCell() }
    
    cell.configureCell(withNote: notes[indexPath.row])
    return cell
  }
  
  func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    let sender = notes[indexPath.row]

    if sender.isProtected {
      let policy = LAPolicy.deviceOwnerAuthenticationWithBiometrics
      if context.canEvaluatePolicy(policy, error: nil) {
        context.evaluatePolicy(policy, localizedReason: "Edit note requires authentication") { (success, error) in
          if success {
            /*
             policy is evaluated on a private queue internal to the framework
             Code for perform segue has to be executed on the main queue
             */
            DispatchQueue.main.async {
              self.performSegue(withIdentifier: TO_EDIT_SEGUE, sender: sender)
            }
          }
        }
      }
    } else {
      performSegue(withIdentifier: TO_EDIT_SEGUE, sender: sender)
    }
  }
  
  func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
    return 90.0
  }
  
  func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
    if editingStyle == UITableViewCellEditingStyle.delete {
      let deleteNote = notes[indexPath.row]
      self.notes.remove(at: indexPath.row)
      removeNote(deleteNote)
      tableView.reloadData()
    }
  }
}

