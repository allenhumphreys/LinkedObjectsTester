//
//  RealmInteractor.swift
//  LinkedObjectsTester
//
//  Created by Allen Humphreys on 6/13/18.
//  Copyright © 2018 Allen. All rights reserved.
//

import RealmSwift

extension Array {

    func choose() -> Element {
        assert(!isEmpty)

        let index = arc4random_uniform(UInt32(endIndex))

        return self[Int(index)]
    }
}

extension Bool {
    static let midPoint = UInt32.max / 2
    static func decide() -> Bool {
        return arc4random() > Bool.midPoint
    }
}

struct RealmInteractor {

    static let realm = try! Realm()

    static func populateRealm() {

        try! realm.write {
            realm.deleteAll()
        }

        let tracks = [Track(name: "Featured"),
                      Track(name: "Design"),
                      Track(name: "Frameworks"),
                      Track(name: "Graphics and Games"),
                      Track(name: "Media"),
                      Track(name: "Developer Tools"),
                      Track(name: "App Store and Distribution")]

        let events = [Event(name: "fall2017"),
                      Event(name: "wwdc2018"),
                      Event(name: "wwdc2017"),
                      Event(name: "wwdc2016"),
                      Event(name: "wwdc2015"),
                      Event(name: "wwdc2014"),
                      Event(name: "wwdc2013")]


        var sessions = [Session]()
        for i in 0..<800 {
            let session = Session(id: i)
            tracks.choose().sessions.append(session)
            events.choose().sessions.append(session)
            sessions.append(session)
        }

        try! realm.write {
            realm.add(tracks)
            realm.add(events)

            for i in 0..<300 {

                let instance = SessionInstance(id: i)
                realm.add(instance)

                if Bool.decide() {
                    instance.session = sessions[i]
                }
            }
        }
    }

    static func allSessionsSorted() -> [Session] {

        return realm.objects(Session.self).sorted(by: Session.standardSort)
    }
}
