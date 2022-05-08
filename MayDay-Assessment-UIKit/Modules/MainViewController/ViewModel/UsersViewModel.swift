//
//  UsersViewModel.swift
//  MayDay-Assesment-UIKit
//
//  Created by Yousef Abourady on 2022-05-05.
//

import Foundation
import Combine

enum UsersViewState {
    case `default`
    case loading
    case error(_ error: Error)
}

class UsersViewModel: NSObject {
    
    @Published private(set) var users: [User] = []
    
    @Published private(set) var viewState: UsersViewState = .default
    
    private let service: UserLoader
    
    init(_ service: UserLoader = UserService()) {
        self.service = service
        super.init()
    }
    
    func loadUsers() {
//        guard self.viewState != .loading else {
//            return
//        }
//        
        self.viewState = .loading
        service.loadUsers(limit: 20) { [weak self] result in
            self?.users = result.results
            self?.viewState = .default
        } errorCompletion: { [weak self] error in
            self?.viewState = .error(error)
        }
    }
    
    func getUser(at index: Int) -> User {
        return users[index]
    }
    
    func userTapped(at index: Int) {
        //let user = getUser(at: index)
        // TODO: HANDLE Action
    }
    
}
