//
//  Events.swift
//  MVVMBindingsBus
//
//  Created by Nazar Kopeyka on 20.04.2023.
//

import Foundation

class Event<T> { /* 9 using T to allow this Event to be generic */
    let identifier: String /* 10 */
    let result: Result<T, Error>? /* 11 */
    
    init(
        identifier: String,
        result: Result<T, Error>?
    ) { /* 12 */
        self.identifier = identifier /* 13 */
        self.result = result /* 13 */
    }
}

//Subclass if Events

class UserFetchEvent: Event<[User]> { /* 14 this class is of type Event */
    let created = Date() /* 79 */
}

//Models

struct User: Codable { /* 14 */
    let name: String /* 15 */
}
