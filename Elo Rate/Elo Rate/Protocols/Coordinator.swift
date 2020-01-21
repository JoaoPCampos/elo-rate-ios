//
//  Coordinator.swift
//  Elo Rate
//
//  Created by João Campos on 14/05/2019.
//  Copyright © 2019 João Campos. All rights reserved.
//

import Foundation

protocol Coordinator: class {

    //MARK:- PROPERTIES
    var description: String { get }
    var coordinators: [Coordinator] { get set }
    var releaseCoordinator: ((Coordinator) -> Void)? { get set }


    //MARK:- FUNCTIONS
    func start()
    func didStartExecution(onCoordinator: Coordinator)
    func didFinishExecution(onCoordinator: Coordinator)
}


extension Coordinator {

    var description: String {

        return String(describing: type(of: self))
    }

    func didStartExecution(onCoordinator: Coordinator) {

        self.coordinators.append(onCoordinator)

        onCoordinator.releaseCoordinator = { [weak self] coordinator in

            guard let `self` = self else {

                print("\n" + coordinator.description + " NOT deallocated\n")

                return
            }

            self.didFinishExecution(onCoordinator: coordinator)

            print("\n" + coordinator.description + " deallocated\n")
        }
    }

    func didFinishExecution(onCoordinator: Coordinator) {

        self.coordinators = self.coordinators.filter { $0 !== onCoordinator }
    }
}
