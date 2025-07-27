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
