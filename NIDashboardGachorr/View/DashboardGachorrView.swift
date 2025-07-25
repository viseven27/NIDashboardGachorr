

import SwiftUI



struct DashboardGachorrView: View {
    @StateObject var mqttManager = MQTTManager()
    @StateObject var viewModel = DashboardViewModel()
    
    var body: some View {
            ZStack {
                KeyEventHandlingView {
                    viewModel.simulateCTA(currentState: viewModel.state)
                }
                // Main background color, matching the dark blue from the screenshot
                Color(red: 0.06, green: 0.14, blue: 0.26).ignoresSafeArea()
                
                VStack(alignment: .center, spacing: 12) {
                    // MARK: - Top Header Row
                    HStack(alignment: .center, spacing: 16) {
                        // Green Arrow Box
                        ZStack {
                            RoundedRectangle(cornerRadius: 12)
                                .fill(Color.green)
                                .frame(width: 70, height: 70)
                            Image(systemName: "arrow.down")
                                .font(.system(size: 36, weight: .bold))
                                .foregroundColor(.white)
                        }
                        
                        // Toll Gate Info
                        VStack(alignment: .leading, spacing: 4) {
                            Text("iTol - Sistem Transaksi Tol")
                                .font(.system(size: 14))
                            Text("PONDOK AREN - GATE 8")
                                .font(.system(size: 22, weight: .bold))
                        }
                        
                        Spacer()
                        
                        HStack{
                            VStack(){
                                Text("Kepala Shift")
                                    .font(.subheadline)
                                    .foregroundColor(.white)
                                
                                Image("Pentol1_Prabowo")
                                    .resizable()
                                    .aspectRatio(contentMode: .fill)
                                    .frame(width: 60, height: 60) // Pastikan square
                                    .clipShape(Circle())
                                    .overlay(Circle().stroke(Color.white, lineWidth: 1))
                                
                                Text("Prabowo")
                            }

                            VStack(){
                                Text("Penjaga Tol")
                                    .font(.subheadline)
                                    .foregroundColor(.white)
                                
                                Image("Pentol2_Gibran")
                                    .resizable()
                                    .aspectRatio(contentMode: .fill)
                                    .frame(width: 60, height: 60)
                                    .clipShape(Circle())
                                    .overlay(Circle().stroke(Color.white, lineWidth: 1))
                                
                                Text("Gibran")
                            }
                        }
                        .padding([.top, .trailing], 20)
                        .padding([.bottom, .leading], 12)
    //                    .padding()
                        .background(Color(red: 0.13, green: 0.4, blue: 0.7).opacity(0.3))
                        .cornerRadius(12)
                    }
                    
                    // MARK: - Middle Data Row
                    HStack(spacing: 16) {
                        // "Gandar" and "Ban" Boxes
                        DataBoxView(title: "Gandar", value: "\(mqttManager.totalAxle) ")
                        DataBoxView(title: "Ban Belakang", value: "\(mqttManager.totalLastTire)")
                        
                        // Transaction Details Box
                        VStack(alignment: .leading, spacing: 12) {
                            Text("Harga : Rp.")
                            Text("Sisa Saldo : Rp.")
                            Text("Metode :")
                            Text("Nomor Kartu :")
                        }
                        .font(.system(size: 16, weight: .medium))
                        .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .leading)
                        .padding()
                        .background(Color.white)
                        .foregroundStyle(.black)
                        .cornerRadius(12)
                    }
                    .frame(maxHeight: 140) // Constrain height of the middle row
                    .padding(.trailing, 20)
                    
                    // MARK: - Bottom Action Button
                    switch viewModel.state {
                    case .noVehicle:
                        CTADashboard(text: "TIDAK ADA KENDARAAN", colorHex: "FF94A3B8")
                    case .chooseClass:
                        CTADashboard(text: "PILIH GOLONGAN", colorHex: "FFE71923", showAnimation: true)
                    case .processing:
                        CTADashboard(text: "SEDANG MEMPROSES", colorHex: "FF3499CC")
                    case .transactionSuccess:
                        CTADashboard(text: "TRANSAKSI BERHASIL", colorHex: "FF36D914")
                    case .transactionFailed:
                        CTADashboard(text: "TRANSAKSI GAGAL", colorHex: "FFB91C1C")
                    case .reverseVehicle:
                        CTADashboard(text: "KENDARAAN MUNDUR", colorHex: "FFB91C1C")
                    case .gateClosing:
                        CTADashboard(text: "GERBANG TUTUP", colorHex: "FFE71923")
                    case .watingForCard:
                        CTADashboard(text: "MENUNGGU KARTU", colorHex: "FF1D4777")
                    case .vehiclePassing:
                        CTADashboard(text: "KENDARAAN LEWAT", colorHex: "FF1D4777")
                    }
                }
                .padding([.leading, .bottom], 20)
        }
        .onAppear {
            mqttManager.connect()
        }
        .onChange(of: mqttManager.totalAxle) { newValue in
            print("New value: \(newValue)")
        }
    }
}

/// A view for the white data boxes ("Gandar", "Ban").
struct DataBoxView: View {
    let title: String
    let value: String
    
    var body: some View {
        VStack(spacing: 4) {
            Text(title)
                .font(.system(size: 20, weight: .medium))
//                .foregroundStyle(.black)
            Text(value)
                .font(.system(size: 80, weight: .bold))
                .foregroundStyle(.black)
                .padding(.vertical, 8)
                .padding(.horizontal, 16)
                .background(Color.white)
                .cornerRadius(12)
                
        }
//        .frame(width: 150, maxHeight: .infinity)
        
    }
}


// MARK: - Preview
#Preview {
    DashboardGachorrView()
}

import SwiftUI
import AppKit

//struct KeyEventHandlingView: NSViewRepresentable {
////    func makeCoordinator() -> Coordinator {
////        // nothing
////        return CI
////    }
//    
//    var onReturnPressed: () -> Void
//
//    class Coordinator: NSView {
//        var onReturnPressed: () -> Void
//
//        init(onReturnPressed: @escaping () -> Void) {
//            self.onReturnPressed = onReturnPressed
//            super.init(frame: .zero)
//        }
//
//        required init?(coder: NSCoder) {
//            fatalError("init(coder:) has not been implemented")
//        }
//
//        override var acceptsFirstResponder: Bool { true }
//
//        override func keyDown(with event: NSEvent) {
//            if event.keyCode == 36 { // 36 = Return key
//                onReturnPressed()
//            }
//        }
//
//        override func viewDidMoveToWindow() {
//            window?.makeFirstResponder(self)
//        }
//    }
//
//    func makeNSView(context: Context) -> NSView {
//        return Coordinator(onReturnPressed: onReturnPressed)
//    }
//
//    func updateNSView(_ nsView: NSView, context: Context) {}
//}

//import SwiftUI
import AppKit

struct KeyEventHandlingView: NSViewRepresentable {
    var onReturnPressed: () -> Void

    func makeNSView(context: Context) -> NSView {
        let view = KeyCatcherView()
        view.onReturnPressed = onReturnPressed
        DispatchQueue.main.async {
            view.window?.makeFirstResponder(view) // Make it focusable
        }
        return view
    }

    func updateNSView(_ nsView: NSView, context: Context) {}

    class KeyCatcherView: NSView {
        var onReturnPressed: (() -> Void)?

        override var acceptsFirstResponder: Bool { true }

        override func keyDown(with event: NSEvent) {
            if event.keyCode == 36 { // Return key
                onReturnPressed?()
            } else {
                super.keyDown(with: event)
            }
        }
    }
}

