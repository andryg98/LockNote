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
  }

  

}

