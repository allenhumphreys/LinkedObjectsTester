//
//  Schema.swift
//  LinkedObjectsTester
//
//  Created by Allen Humphreys on 6/13/18.
//  Copyright © 2018 Allen. All rights reserved.
//

import RealmSwift

public class Session: Object {

    /// Unique identifier
    @objc public dynamic var identifier = ""

    /// Session number
    @objc public dynamic var number = ""

    /// Title
    @objc public dynamic var title = ""

    @objc public dynamic var staticContentId = ""

    /// Description
    @objc public dynamic var summary = ""

    /// The event identifier for the event this session belongs to
    @objc public dynamic var eventIdentifier = ""

    /// Track name
    @objc public dynamic var trackName = ""

    /// Track identifier
    @objc public dynamic var trackIdentifier = ""

    /// The session's focuses
    public let focuses = List<Focus>()

    /// The session's assets (videos, slides, links)
    public let assets = List<SessionAsset>()

    // The session's "related" resources -- other sessions, documentation, guides and sample code
    public var related = List<RelatedResource>()

    /// Whether this session is downloaded
    @objc public dynamic var isDownloaded = false

    /// Session favorite
    public let favorites = List<Favorite>()

    /// Session progress
    public let progresses = List<SessionProgress>()

    /// Session bookmarks
    public let bookmarks = List<Bookmark>()

    /// Transcript identifier for the session
    @objc public dynamic var transcriptIdentifier: String = ""

    /// Shortcut to get the full transcript text (used during search)
    @objc public dynamic var transcriptText: String = ""

    /// Media duration (in seconds)
    @objc public dynamic var mediaDuration: Double = 0

    /// The session's track
    public let track = LinkingObjects(fromType: Track.self, property: "sessions")

    /// The event this session belongs to
    public let event = LinkingObjects(fromType: Event.self, property: "sessions")

    /// Instances of this session
    public let instances = LinkingObjects(fromType: SessionInstance.self, property: "session")

    public override static func primaryKey() -> String? {
        return "identifier"
    }

    convenience init(id: Int) {
        self.init()

        self.identifier = String(id)
    }

    public static func standardSort(sessionA: Session, sessionB: Session) -> Bool {
        guard let eventA = sessionA.event.first, let eventB = sessionB.event.first else { return false }
        guard let trackA = sessionA.track.first, let trackB = sessionB.track.first else { return false }

        if trackA.name == trackB.name {
            if eventA.name == eventB.name {
                return sessionA.identifier < sessionB.identifier
            } else {
                return eventA.name > eventB.name
            }
        } else {
            return trackA.name < trackB.name
        }
    }
}

public class SessionInstance: Object {

    /// Unique identifier
    @objc public dynamic var identifier = ""

    /// The session
    @objc public dynamic var session: Session?

    public override static func primaryKey() -> String? {
        return "identifier"
    }

    convenience init(id: Int) {
        self.init()

        self.identifier = String(id)
    }
}

public class Track: Object {

    /// The name of the track
    @objc public dynamic var name = ""

    /// Sessions related to this track
    public let sessions = List<Session>()

    public override class func primaryKey() -> String? {
        return "name"
    }

    convenience init(name: String) {
        self.init()

        self.name = name
    }
}

public class Event: Object {

    @objc public dynamic var name = ""

    public override class func primaryKey() -> String? {
        return "name"
    }

    /// Sessions held at this event
    public let sessions = List<Session>()

    convenience init(name: String) {
        self.init()

        self.name = name
    }
}
