//
//  ViewController.swift
//  LockNote
//
//  Created by Andrea Garau on 14/09/2018.
//  Copyright © 2018 Andrea Garau. All rights reserved.
//

import UIKit
import RealmSwift

class MainVC: UIViewController {
  
  //Outlets
  @IBOutlet weak var tableView: UITableView!
  
  //Variables
  fileprivate var notes = [Note]()

  override func viewDidLoad() {
    super.viewDidLoad()
    if let notes = fetchNotes(forProperty: "creationDate") {
      self.notes = notes
    }
  }
  
  override func viewWillAppear(_ animated: Bool) {
    // TODO - Add listener to realm database for adding and updating operations
  }
  
  private func fetchNotes(forProperty property: String, ascending: Bool = false) -> [Note]? {
    let realm = try! Realm()
    let notesResult = realm.objects(Note.self).sorted(byKeyPath: property, ascending: ascending)
    var notes = [Note]()
    for note in notesResult { notes.append(note) }
    
    return notes
  }

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


extension MainVC: UITableViewDelegate, UITableViewDataSource {
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return notes.count
  }
  
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    guard let cell = tableView.dequeueReusableCell(withIdentifier: CELL_ID, for: indexPath) as? NoteCell else { return UITableViewCell() }
    
    cell.configureCell(withNote: notes[indexPath.row])
    return cell
  }
  
  func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    // TODO - Add biometric if note is protected
    performSegue(withIdentifier: TO_EDIT_SEGUE, sender: notes[indexPath.row])
  }
}

