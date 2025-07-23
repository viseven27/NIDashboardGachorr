

import SwiftUI

struct DashboardGachorrView: View {
    var body: some View {
        ZStack {
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
                    .padding([.top, .trailing], 20)
                    .padding([.bottom, .leading], 12)
//                    .padding()
                    .background(Color(red: 0.13, green: 0.4, blue: 0.7).opacity(0.3))
                    .cornerRadius(12)
                }
                
                // MARK: - Middle Data Row
                HStack(spacing: 16) {
                    // "Gandar" and "Ban" Boxes
                    DataBoxView(title: "Gandar", value: "5")
                    DataBoxView(title: "Ban Belakang", value: "16")
                    
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
                Text("PILIH GOLONGAN 5")
                    .font(.system(size: 28, weight: .bold))
                    .foregroundColor(.black)
                    .frame(maxWidth: .infinity)
                    .padding(.vertical, 16)
                    .background(Color.white)
                    .cornerRadius(8)
                    .overlay(
                        RoundedRectangle(cornerRadius: 8)
                            .stroke(Color.red, lineWidth: 5)
                    )
                    .shadow(color: .black.opacity(0.2), radius: 5, y: 3)
                    .padding(.trailing, 20)
            }
            .padding([.leading, .bottom], 20)
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
