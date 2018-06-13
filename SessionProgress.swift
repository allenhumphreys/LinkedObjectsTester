//
//  SessionProgress.swift
//  LinkedObjectsTester
//
//  Created by Allen Humphreys on 6/13/18.
//  Copyright © 2018 Allen. All rights reserved.
//

import RealmSwift

public final class SessionProgress: Object {

    /// CloudKit system data
    @objc public dynamic var ckFields = Data()

    /// Soft delete (for syncing)
    @objc public dynamic var isDeleted: Bool = false

    /// Unique identifier
    @objc public dynamic var identifier = UUID().uuidString

    /// When the progress was created
    @objc public dynamic var createdAt = Date()

    /// When the progress was last update
    @objc public dynamic var updatedAt = Date()

    /// The current position in the video (in seconds)
    @objc public dynamic var currentPosition: Double = 0

    /// The current position in the video, relative to the duration (from 0 to 1)
    @objc public dynamic var relativePosition: Double = 0

    /// The session this progress is associated with
    let session = LinkingObjects(fromType: Session.self, property: "progresses")

    public override class func primaryKey() -> String? {
        return "identifier"
    }
}
