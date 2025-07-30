//
//  TestView.swift
//  NIDashboardGachorr
//
//  Created by Khresna Sariyanto on 26/07/25.
//

//Cuma buat tes kalau bisa display data yg uda ada di db
import SwiftUI
import SwiftData

struct TestView: View {
    @StateObject var mqttManager = MQTTManager()
    @Environment(\.modelContext) private var modelContext
    @Query var allData: [VehicleData]
    
    var body: some View {
        Text("Hello, World!")
            .onAppear {
                mqttManager.connect()
                
                mqttManager.onDataReceived = { axle, tire in
                    let manager = VehicleDataManager(modelContext: modelContext)
                    manager.saveVehicleData(
                        iotData: "empty",
                        isTransactionDone: false,
                        axle: axle,
                        tire: tire
                    )
                }
            }
        
        ScrollView {
            VStack(alignment: .leading, spacing: 8) {
                ForEach(allData.reversed()) { data in
                    VStack(alignment: .leading, spacing: 4) {
                        Text("🆔 \(data.id.uuidString.prefix(8))")
                        Text("Gandar: \(data.jumlahGandar), Ban: \(data.jumlahBanBelakang)")
                        Text("Waktu: \(data.dataReceivedAt.formatted(.dateTime.hour().minute().second()))")
                        Divider()
                    }
                }
            }
            .padding()
            .background(.white.opacity(0.1))
            .cornerRadius(12)
        }
        
    }
}

#Preview {
    TestView()
}
