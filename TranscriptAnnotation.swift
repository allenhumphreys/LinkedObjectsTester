//
//  TranscriptAnnotation.swift
//  LinkedObjectsTester
//
//  Created by Allen Humphreys on 6/13/18.
//  Copyright © 2018 Allen. All rights reserved.
//

import RealmSwift

/// TranscriptAnnotation is a line within an ASCIIWWDC transcript, with its associated timestamp within the session's video
public class TranscriptAnnotation: Object {

    /// The time this annotation occurs within the video
    @objc public dynamic var timecode = 0.0

    /// The annotation's text
    @objc public dynamic var body = ""

}
