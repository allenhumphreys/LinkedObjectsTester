//
//  SessionAsset.swift
//  LinkedObjectsTester
//
//  Created by Allen Humphreys on 6/13/18.
//  Copyright © 2018 Allen. All rights reserved.
//

import RealmSwift

public enum SessionAssetType: String {
    case none
    case hdVideo = "WWDCSessionAssetTypeHDVideo"
    case sdVideo = "WWDCSessionAssetTypeSDVideo"
    case image = "WWDCSessionAssetTypeShelfImage"
    case slides = "WWDCSessionAssetTypeSlidesPDF"
    case streamingVideo = "WWDCSessionAssetTypeStreamingVideo"
    case liveStreamVideo = "WWDCSessionAssetTypeLiveStreamVideo"
    case webpage = "WWDCSessionAssetTypeWebpageURL"
}

/// Session assets are resources associated with sessions, like videos, PDFs and useful links
public class SessionAsset: Object {

    /// The type of asset:
    ///
    /// - WWDCSessionAssetTypeHDVideo
    /// - WWDCSessionAssetTypeSDVideo
    /// - WWDCSessionAssetTypeShelfImage
    /// - WWDCSessionAssetTypeSlidesPDF
    /// - WWDCSessionAssetTypeStreamingVideo
    /// - WWDCSessionAssetTypeWebpageURL
    @objc internal dynamic var rawAssetType = "" {
        didSet {
            identifier = generateIdentifier()
        }
    }

    @objc public dynamic var identifier = ""

    public var assetType: SessionAssetType {
        get {
            return SessionAssetType(rawValue: rawAssetType) ?? .none
        }
        set {
            rawAssetType = newValue.rawValue
        }
    }

    /// The year of the session this asset belongs to
    @objc public dynamic var year = 0 {
        didSet {
            identifier = generateIdentifier()
        }
    }

    /// The id of the session this asset belongs to
    @objc public dynamic var sessionId = "" {
        didSet {
            identifier = generateIdentifier()
        }
    }

    /// URL for this asset
    @objc public dynamic var remoteURL = ""

    /// Relative local URL to save the asset to when downloading
    @objc public dynamic var relativeLocalURL = ""

    @objc public dynamic var actualEndDate: Date?

    /// The session this asset belongs to
    let session = LinkingObjects(fromType: Session.self, property: "assets")

    public override class func primaryKey() -> String? {
        return "identifier"
    }

    public func generateIdentifier() -> String {
        return String(year) + "@" + sessionId + "~" + rawAssetType.replacingOccurrences(of: "WWDCSessionAssetType", with: "")
    }
}

