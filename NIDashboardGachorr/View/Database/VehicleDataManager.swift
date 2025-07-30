//
//  VehicleDataManager.swift
//  NIDashboardGachorr
//
//  Created by Khresna Sariyanto on 24/07/25.
//

import Foundation
import SwiftData

@MainActor
class VehicleDataManager {
    private let modelContext: ModelContext

    init(modelContext: ModelContext) {
        self.modelContext = modelContext
    }

    //Attributes
    func saveVehicleData(
        iotData: String,
        isTransactionDone: Bool,
        axle: Int,
        tire: Int
    ) {
        let newData = VehicleData(
            iotData: iotData,
            dataReceivedAt: Date.now,
            isTransactionDone: false,
            jumlahGandar: axle,
            jumlahBanBelakang: tire
        )

        modelContext.insert(newData)

        do {
            try modelContext.save()
            print("✅ Data kendaraan berhasil disimpan ke SwiftData.")
        } catch {
            print("❌ Gagal menyimpan data kendaraan: \(error.localizedDescription)")
        }
    }
}
