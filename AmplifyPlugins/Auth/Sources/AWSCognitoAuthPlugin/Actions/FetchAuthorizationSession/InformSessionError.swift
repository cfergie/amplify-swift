//
// Copyright Amazon.com Inc. or its affiliates.
// All Rights Reserved.
//
// SPDX-License-Identifier: Apache-2.0
//

import Amplify
import Foundation
import AWSCognitoIdentityProvider
import AWSCognitoIdentity

struct InformSessionError: Action {

    let identifier = "InformSessionError"

    let error: FetchSessionError

    func execute(withDispatcher dispatcher: EventDispatcher, environment: Environment) async {

        logVerbose("\(#fileID) Starting execution", environment: environment)
        var event: AuthorizationEvent
        switch error {
        case .service(let serviceError):
            if isNotAuthorizedError(serviceError) {
                event = .init(eventType: .throwError(
                    .sessionExpired(error: serviceError)))
            } else {
                event = .init(eventType: .receivedSessionError(error))
            }
        default:
            event = .init(eventType: .receivedSessionError(error))

        }

        logVerbose("\(#fileID) Sending event \(event.type)", environment: environment)
        await dispatcher.send(event)
    }

    func isNotAuthorizedError(_ error: Error) -> Bool {
        error is AWSCognitoIdentity.NotAuthorizedException
        || error is AWSCognitoIdentityProvider.NotAuthorizedException
    }
}

extension InformSessionError: DefaultLogger {
    public static var log: Logger {
        Amplify.Logging.logger(forCategory: CategoryType.auth.displayName, forNamespace: String(describing: self))
    }
    
    public var log: Logger {
        Self.log
    }
}

extension InformSessionError: CustomDebugDictionaryConvertible {
    var debugDictionary: [String: Any] {
        [
            "identifier": identifier,
            "error": error
        ]
    }
}

extension InformSessionError: CustomDebugStringConvertible {
    var debugDescription: String {
        debugDictionary.debugDescription
    }
}
