//
//  Snapshot.swift
//  InAppViewDebugger
//
//  Created by Indragie Karunaratne on 3/31/19.
//  Copyright © 2019 Indragie Karunaratne. All rights reserved.
//

import Foundation
import CoreGraphics

/// A snapshot of the UI element tree in its current state.
@objc(IAVDSnapshot) public final class Snapshot: NSObject {
    /// Unique identifier for the snapshot.
    @objc public let identifier = UUID().uuidString
    
    /// Identifying information for the element, like its name and classification.
    @objc public let label: ElementLabel
    
    /// The frame of the element in its parent's coordinate space.
    @objc public let frame: CGRect
    
    /// Whether the element is hidden from view or not.
    @objc public let isHidden: Bool
    
    /// A snapshot image of the element in its current state.
    @objc public let snapshotImage: CGImage?
    
    /// The child snapshots of the snapshot (one per child element).
    @objc public let children: [Snapshot]
    
    /// The element used to create the snapshot.
    @objc public let element: Element
    
    /// Constructs a new `Snapshot`
    ///
    /// - Parameter element: The element to construct the snapshot from. The
    /// data stored in the snapshot will be the data provided by the element
    /// at the time that this constructor is called.
    @objc public init(element: Element) {
        self.label = element.label
        self.frame = element.frame
        self.isHidden = element.isHidden
        self.snapshotImage = element.snapshotImage
        self.children = element.children.map { Snapshot(element: $0) }
        self.element = element
    }
}
