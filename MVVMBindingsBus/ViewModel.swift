//
//  ViewModel.swift
//  MVVMBindingsBus
//
//  Created by Nazar Kopeyka on 20.04.2023.
//

import Foundation

struct UserListViewModel { /* 52 */
    public var users: [User] = [] /* 72 */
    
    public func fetchUserList() { /* 1 */
        guard let url = URL(string: "https://jsonplaceholder.typicode.com/users") else { /* 2 */
            return /* 3 */
        }
        
        let task = URLSession.shared.dataTask(with: url) { data, _, _ in /* 36 */
            guard let data = data else { /* 37 */
                return /* 38 */
            }
            let event: UserFetchEvent /* 45 */
            do { /* 39 */
                let users = try JSONDecoder().decode([User].self, from: data) /* 40 */
                
                event = UserFetchEvent(identifier: UUID().uuidString,
                                           result: .success(users)) /* 41 */
            }
            catch { /* 42 */
                print(error) /* 43 */
                event = UserFetchEvent(identifier: UUID().uuidString,
                                           result: .failure(error)) /* 44 */
            }
            Bus.shared.publish(
                type: .userFetch,
                event: event
            ) /* 47 */
        }
        task.resume() /* 46 */
    }
}
