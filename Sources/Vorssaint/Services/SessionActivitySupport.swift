// SPDX-License-Identifier: GPL-3.0-or-later
// Copyright (C) 2026 Vorssaint

import CoreGraphics
import Foundation

/// Reading whether a login session is the one on screen.
enum SessionActivitySupport {
    /// The console flag out of a session dictionary.
    ///
    /// Starting from the notifications alone is not enough: a process launched
    /// into a session that is already switched away is told so between
    /// `willFinishLaunching` and `didFinishLaunching`, which is before the
    /// services that own a tap exist to hear it. The flag is therefore read
    /// once at startup, and anything unreadable counts as not on screen —
    /// the cost of being wrong that way is a tap that waits for the switch
    /// back, against a tap that stalls scrolling for the account in use.
    static func isOnConsole(_ session: [String: Any]?) -> Bool {
        guard let value = session?[kCGSessionOnConsoleKey as String] else { return false }
        if let flag = value as? Bool { return flag }
        if let number = value as? NSNumber { return number.boolValue }
        return false
    }
}
