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
  @objc dynamic var noteTitle: String = "New Note"
  @objc dynamic var noteText: String = ""
  @objc dynamic var isProtected: Bool = false
  @objc dynamic var creationDate: Date = Date()
  
  convenience init(title: String, text: String, creationDate: Date, isProtected: Bool = false) {
    self.init()
    self.noteTitle = title
    self.noteText = text
    self.creationDate = creationDate
    self.isProtected = isProtected
  }
}

