//
// Copyright Amazon.com Inc. or its affiliates.
// All Rights Reserved.
//
// SPDX-License-Identifier: Apache-2.0
//

import AWSPinpoint
import AWSPluginsCore
import Foundation

extension PinpointEvent {
    var clientTypeSession: PinpointClientTypes.Session? {
    #if os(watchOS)
        // If the session duration cannot be represented by Int, return a nil session instead.
        // This is extremely unlikely to happen since a session's stopTime is set when the app is closed
        if let duration = session.duration, duration > Int.max {
            return nil
        }
    #endif
        return PinpointClientTypes.Session(duration: Int(session.duration),
                                           id: session.sessionId,
                                           startTimestamp: session.startTime.asISO8601String,
                                           stopTimestamp: session.stopTime?.asISO8601String)
    }

    var clientTypeEvent: PinpointClientTypes.Event {
        return PinpointClientTypes.Event(appPackageName: Bundle.main.appPackageName,
                                         appTitle: Bundle.main.appName,
                                         appVersionCode: Bundle.main.appVersion,
                                         attributes: attributes,
                                         clientSdkVersion: AmplifyAWSServiceConfiguration.amplifyVersion,
                                         eventType: eventType,
                                         metrics: metrics,
                                         sdkName: AmplifyAWSServiceConfiguration.platformName,
                                         session: clientTypeSession,
                                         timestamp: eventDate.asISO8601String)
    }
}

extension Bundle {
    var appPackageName: String {
        object(forInfoDictionaryKey: "CFBundleIdentifier") as? String ?? ""
    }

    var appName: String {
        object(forInfoDictionaryKey: "CFBundleDisplayName") as? String ?? ""
    }

    var appBuild: String {
        object(forInfoDictionaryKey: "CFBundleVersion") as? String ?? ""
    }

    var appVersion: String {
        object(forInfoDictionaryKey: "CFBundleShortVersionString") as? String ?? ""
    }
}

private extension Int {
    init?(_ value: Int64?) {
        guard let value = value else {
            return nil
        }
        self.init(value)
    }
}
