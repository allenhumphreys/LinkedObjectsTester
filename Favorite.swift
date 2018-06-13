//
//  Favorite.swift
//  LinkedObjectsTester
//
//  Created by Allen Humphreys on 6/13/18.
//  Copyright © 2018 Allen. All rights reserved.
//

import RealmSwift

/// Defines the user action of adding a session as favorite
public final class Favorite: Object {

    /// CloudKit system data
    @objc public dynamic var ckFields = Data()

    /// Unique identifier
    @objc public dynamic var identifier = UUID().uuidString

    /// When the favorite was created
    @objc public dynamic var createdAt = Date()

    /// Soft delete (for syncing)
    @objc public dynamic var isDeleted: Bool = false

    /// The session this favorite is associated with
    let session = LinkingObjects(fromType: Session.self, property: "favorites")

    public override class func primaryKey() -> String? {
        return "identifier"
    }

}
