//
//  Focus.swift
//  LinkedObjectsTester
//
//  Created by Allen Humphreys on 6/13/18.
//  Copyright © 2018 Allen. All rights reserved.
//

import RealmSwift

public class Focus: Object {

    /// The name of the focus area
    @objc public dynamic var name = ""

    /// Sessions containing this focus
    let sessions = LinkingObjects(fromType: Session.self, property: "focuses")

    public override class func primaryKey() -> String? {
        return "name"
    }
}
