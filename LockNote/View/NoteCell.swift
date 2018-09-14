//
//  NoteCell.swift
//  LockNote
//
//  Created by Andrea Garau on 14/09/2018.
//  Copyright © 2018 Andrea Garau. All rights reserved.
//

import UIKit

class NoteCell: UITableViewCell {
  
  //Outlets
  @IBOutlet private weak var lockedImage: UIImageView!
  @IBOutlet private weak var noteText: UILabel!
  @IBOutlet private weak var dateText: UILabel!
  
  override func awakeFromNib() {
    super.awakeFromNib()
  }
  
  func configureCell(withNote note: Note) {
    self.lockedImage.isHidden = !note.isProtected
    self.noteText.text = note.noteText
    
    let dateFormatter = DateFormatter()
    dateFormatter.dateFormat = "EEEE, MMM d, yyyy"
    self.dateText.text = dateFormatter.string(from: note.creationDate)
  }
  
}
