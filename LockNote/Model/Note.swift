//
//  Note.swift
//  LockNote
//
//  Created by Andrea Garau on 14/09/2018.
//  Copyright © 2018 Andrea Garau. All rights reserved.
//

import UIKit
import RealmSwift

class Note: Object {
  @objc dynamic var noteText: String = ""
  @objc dynamic var isProtected: Bool = false
  @objc dynamic var creationDate: Date = Date()
  
  public func fetchNotes(forProperty property: String, ascending: Bool = false) -> [Note]? {
    let realm = try! Realm()
    let notesResult = realm.objects(Note.self).sorted(byKeyPath: property, ascending: ascending)
    var notes = [Note]()
    for note in notesResult { notes.append(note) }
    
    return notes
  }
}

