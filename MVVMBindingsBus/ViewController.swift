//
//  ViewController.swift
//  MVVMBindingsBus
//
//  Created by Nazar Kopeyka on 20.04.2023.
//

import UIKit

class ViewController: UIViewController, UITableViewDataSource { /* 61 add protocol */

    private var viewModel = UserListViewModel() /* 53 */
    
    private let tableView: UITableView = { /* 54 */
        let table = UITableView() /* 55 */
        table.register(UITableViewCell.self, forCellReuseIdentifier: "cell") /* 56 */
        return table /* 57 */
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(tableView) /* 58 */
        tableView.frame = view.bounds /* 59 */
        tableView.dataSource = self /* 60 */
        
        Bus.shared.subscribeOnMain(.userFetch) { [weak self] event in /* 67 */ /* 73 add weak self */
            guard let result = event.result else { /* 76 */
                return /* 77 */
            }
            switch result { /* 68 */
            case .success(let users): /* 69 */
                self?.viewModel.users = users /* 70 */
                self?.tableView.reloadData() /* 71 */
            case .failure(let error): /* 69 */
                print(error) /* 71 */
            }
        }
        
        viewModel.fetchUserList() /* 78 */
    }

    //Table
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int { /* 62 */
        return viewModel.users.count /* 63 */ /* 74 change 0 */
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell { /* 64 */
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) /* 65 */
        cell.textLabel?.text = viewModel.users[indexPath.row].name /* 75 */
        return cell /* 66 */
    }
    
    
}

