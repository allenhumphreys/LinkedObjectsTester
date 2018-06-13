//
//  RelatedResource.swift
//  LinkedObjectsTester
//
//  Created by Allen Humphreys on 6/13/18.
//  Copyright © 2018 Allen. All rights reserved.
//

import RealmSwift

public enum RelatedResourceType: String {
    case unknown = "WWDCSessionResourceTypeUnknown"
    case guide = "WWDCSessionResourceTypeGuide"
    case documentation = "WWDCSessionResourceTypeDocumentation"
    case sampleCode = "WWDCSessionResourceTypeSampleCode"
    case session = "WWDCSessionResourceTypeSession"
    case download = "WWDCSessionResourceTypeDownload"

    init?(rawResourceType: String) {
        switch rawResourceType {
        case "guide":
            self = .guide
        case "documentation":
            self = .documentation
        case "samplecode":
            self = .sampleCode
        case "unknown":
            self = .unknown
        case "download":
            self = .download
        default:
            return nil
        }
    }
}

public class RelatedResource: Object {
    @objc public dynamic var identifier = ""
    @objc public dynamic var title = ""
    @objc public dynamic var url = ""
    @objc public dynamic var descriptor = ""
    @objc public dynamic var type = ""
    @objc public dynamic var session: Session?

    public override class func primaryKey() -> String? {
        return "identifier"
    }
}

