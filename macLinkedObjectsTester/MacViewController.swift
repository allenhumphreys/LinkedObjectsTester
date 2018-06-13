//
//  ViewController.swift
//  macLinkedObjectsTester
//
//  Created by Allen Humphreys on 6/13/18.
//  Copyright © 2018 Allen. All rights reserved.
//

import Cocoa
import RealmSwift

class MacViewController: NSViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        print(RealmInteractor.realm.configuration.fileURL)
    }

    override var representedObject: Any? {
        didSet {
        // Update the view, if already loaded.
        }
    }

    var sessions = [Session]()

    var token: NotificationToken?

    @IBAction func populateRealm(_ sender: Any) {

        RealmInteractor.populateRealm()
    }

    @IBAction func loadObjects(_ sender: Any) {
        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
            self.sessions = RealmInteractor.allSessionsSorted()
            try! RealmInteractor.realm.write {
                self.sessions[0].isDownloaded = true
            }

            self.token = self.sessions[0].observe { _ in
                print("Changed")
            }
        }
    }

    @IBAction func modifyObject(_ sender: Any) {

        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
            try! RealmInteractor.realm.write {
                self.sessions[0].isDownloaded = true
            }
        }
    }
}

