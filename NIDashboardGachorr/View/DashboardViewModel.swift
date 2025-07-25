//
//  DashboardViewModel.swift
//  NIDashboardGachorr
//
//  Created by Azalia Amanda on 25/07/25.
//

import Foundation


enum TransactionState {
    case noVehicle
    case chooseClass
    case processing
    case transactionSuccess
    case transactionFailed
    case reverseVehicle
    case gateClosing
    case watingForCard
    case vehiclePassing
}

class DashboardViewModel: ObservableObject {
    @Published private(set) var state: TransactionState = .noVehicle
    
//    func loadVehicleClass(totalAxle: Int, totalTire: Int) {
//        if (totalAxle == 2 && totalTire == 2) {
//            updateState(.chooseClass(1))
//        } else if (totalAxle == 2 && totalTire > 2) {
//            updateState(.chooseClass(2))
//        } else if (totalAxle >= 5) {
//            updateState(.chooseClass(5))
//        } else {
//            updateState(.chooseClass(totalAxle))
//        }
//        continueTransaction()
//    }
//    
//    func continueTransaction() {
//        
//    }
    
    func simulateCTA(currentState: TransactionState) {
        switch state {
        case .noVehicle:
            updateState(.processing)
        case .chooseClass:
            updateState(.watingForCard)
        case .processing:
            updateState(.chooseClass)
        case .transactionSuccess:
            updateState(.vehiclePassing)
        case .transactionFailed:
            updateState(.noVehicle)
        case .reverseVehicle:
            updateState(.noVehicle)
        case .gateClosing:
            updateState(.noVehicle)
        case .watingForCard:
            updateState(.transactionSuccess)
        case .vehiclePassing:
            updateState(.noVehicle)
        }
    }
    
    func updateState(_ state: TransactionState) {
        DispatchQueue.main.async {
            self.state = state
        }
    }
}
