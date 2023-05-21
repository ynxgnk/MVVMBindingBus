//
//  Bus.swift
//  MVVMBindingsBus
//
//  Created by Nazar Kopeyka on 20.04.2023.
//

import Foundation

final class Bus { /* 4 */ /* 35 add final */
    static let shared = Bus() /* 5 */
    
    private init() {} /* 6 */
    
    enum EventType { /* 16 */
        case userFetch /* 17 */
    }
    
    struct Subscription { /* 23 */
        let type: EventType /* 24 */
        let queue: DispatchQueue /* 24 */
        let block: ((Event<[User]>) -> Void) /* 24 */ /* 49 change Any to array of User */
    }
    
    private var subscriptions = [Subscription]() /* 25 */
    
    //Subscriptions
    func subscribe(
        _ event: EventType,
        block: @escaping((Event<[User]>) -> Void) /* 50 change Any to [User] */
    ) { /* 7 */ /* 18 add parameter event */ /* 21 add parameter block */
        let new = Subscription(
            type: event,
            queue: .global(),
            block: block
        ) /* 26 */
        subscriptions.append(new) /* 27 */
    }
    
    func subscribeOnMain(
        _ event: EventType,
        block: @escaping ((Event<[User]>) -> Void) /* 22 add parameter block */ /* 51 change Any to [User] */
    ) { /* 19 */
        let new = Subscription(
            type: event,
            queue: .main,
            block: block
        ) /* 28 */
        subscriptions.append(new) /* 29 */
    }
    
    //Publications
    func publish(type: EventType, event: UserFetchEvent) { /* 8 */ /* 20 add parameter event */ /* 30 add type */ /* 48 change Event to UserFetch.. */
        let subscribers = subscriptions.filter({ $0.type == type }) /* 31 filter out all subscribers where the actual type is gonna match */
        subscribers.forEach { subscriber in /* 32 */
            subscriber.queue.async { /* 33 */
                subscriber.block(event) /* 34 */
            }
        }
    }
}
