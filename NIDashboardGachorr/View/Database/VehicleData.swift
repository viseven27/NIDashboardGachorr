//
//  VehicleData.swift
//  NIDashboardGachorr
//
//  Created by Khresna Sariyanto on 24/07/25.
//

import Foundation
import SwiftData

@Model
class VehicleData:Identifiable {
    @Attribute(.unique) var id: UUID
    var iotData: String
    var dataReceivedAt: Date
    var isTransactionDone: Bool
    var jumlahGandar: Int
    var jumlahBanBelakang: Int

    init(
        id: UUID = UUID(),
        iotData: String,
        dataReceivedAt: Date = .now,
        isTransactionDone: Bool = false,
        jumlahGandar: Int,
        jumlahBanBelakang: Int
    ) {
        self.id = id
        self.iotData = iotData
        self.dataReceivedAt = dataReceivedAt
        self.isTransactionDone = isTransactionDone
        self.jumlahGandar = jumlahGandar
        self.jumlahBanBelakang = jumlahBanBelakang
    }
}
