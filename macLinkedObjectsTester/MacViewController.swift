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

    @IBAction func openRealm(_ sender: Any) {

        if let realmURL = RealmInteractor.realm.configuration.fileURL {
            NSWorkspace.shared.open(realmURL)
        }
    }

    var sessions = [Session]()

    var token: NotificationToken?

    @IBAction func populateRealm(_ sender: Any) {

        RealmInteractor.populateRealm()
    }

    @IBAction func loadObjects(_ sender: Any) {
        // The delay is to help separate event handling CPU usage from actual work
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.2) {

            // Loading the sessions and sorting them causes 2 of the `LinkingObjects` underlying queries
            // to be cached via `Session`. This means there are 1600 CollectionNotifiers at this point
            self.sessions = RealmInteractor.allSessionsSorted()

            // Adding an object observer before a write happens is critical to causing
            // the issue to occur
            self.token = self.sessions[0].observe { _ in
                print("Changed")
            }
        }
    }

    @IBAction func modifyObject(_ sender: Any) {

        DispatchQueue.main.asyncAfter(deadline: .now() + 0.2) {

            // When a write is performed, all the notifiers will be triggered.
            // The DeepChangeChecker seems to be using the majority of the CPU time
            try! RealmInteractor.realm.write {
                self.sessions[0].isDownloaded = true
            }
        }
    }
}

