//
//  Font+Ext.swift
//  UnaPieza
//
//  Created by Fede Garcia on 23/04/2026.
//

import SwiftUI

extension Font {
    static func scalableCustom(_ name: String, baseSize: CGFloat, textStyle: UIFont.TextStyle) -> Font {
        let metrics = UIFontMetrics(forTextStyle: textStyle)
        let scaledSize = metrics.scaledValue(for: baseSize)
        return .custom(name, size: scaledSize)
    }
}
