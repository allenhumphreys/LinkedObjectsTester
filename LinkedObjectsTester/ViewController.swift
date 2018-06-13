//
//  ViewController.swift
//  LinkedObjectsTester
//
//  Created by Allen Humphreys on 6/13/18.
//  Copyright © 2018 Allen. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    @IBAction func populateRealm(_ sender: Any) {

        RealmInteractor.populateRealm()
    }

    var sessions = [Session]()
    
    @IBAction func loadObjects(_ sender: Any) {
        sessions = RealmInteractor.allSessionsSorted()
    }

    @IBAction func modifyObject(_ sender: Any) {

        try! RealmInteractor.realm.write {
            sessions[0].isDownloaded = true
        }
    }
}
