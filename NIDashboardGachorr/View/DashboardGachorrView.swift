//
//  DashboardGachorrView.swift
//  NIDashboardGachorr
//
//  Created by Alvin Justine on 22/07/25.
//

//import Foundation
//import SwiftUI
//
//struct DashboardGachorrView: View{
//    var body: some View {
//        VStack(alignment: .leading, spacing: 8) {
//            Text("Ini dashboard baru kita")
//                .foregroundColor(.black)
//        }
//        .padding()
//        .background(Color.white)
//        .border(Color.black)
//    }
//}

//import SwiftUI
//
//struct DashboardGachorrView: View {
//    var body: some View {
//        ZStack{
//            //Blue Gradient background
//            LinearGradient(
//                gradient: Gradient(colors:[
//                    Color(red: 0.05, green: 0.20, blue: 0.40),
//                    Color(red: 0.15, green: 0.45, blue: 0.80)
//                ]),
//                startPoint: .topLeading,
//                endPoint: .bottomTrailing
//            )
//            
//            VStack(alignment: .center, spacing: 8) {
//                //Baris ke 1
//                HStack(){
//                    ArrowBoxView()
//                    
//                    VStack(){
//                        Text("iTol-Sistem Transaksi Tol")
//                        Text("PONDOK AREN - GATE 8")
//                        Text("Shift 1 * Periode 1")
//                    }
//                    .background(Color.orange)
//                    
//                    VStack(alignment: .center, spacing: 4){
//                        Text("Kepala Shift")
//                            .font(.subheadline)
//                            .foregroundColor(.white)
//                        
//                        Image("Pentol1_Prabowo")
//                            .resizable()
//                            .clipShape(Circle())
////                            .clip(Circle())
//                        Text("Prabowo")
//                    }
//
//                    
//                    VStack(){
//                        Text("Penjaga Tol")
//                            .font(.subheadline)
//                            .foregroundColor(.white)
//                        
//                        Image("Pentol2_Gibran")
//                            .resizable()
//                            .clipShape(Circle())
////                            .clip(Circle())
//                        Text("Gibran")
//                    }
//                }
//                
//                //Baris ke 2
//                HStack(){
//                    VStack(){
//                        Text("Gandar")
//                            .font(.headline)
//                        Text("Box Gandar")
//                    }
//                    .background(Color.yellow)
//                    
//                    VStack(){
//                        Text("Ban")
//                        Text("Box Ban")
//                    }
//                    .background(Color.green)
//                    
//                    VStack(){
//                        Text("Harga: ")
//                        Text("Sisa Saldo: ")
//                        Text("Metode: ")
//                        Text("Nomor Kartu: ")
//                    }
//                    .background(Color.yellow)
//                }
//                .background(Color.white)
//                
//                //Baris 3
//                HStack(){
//                    Text("Tombol CTA")
//                        .background(Color.green)
//                }
//                .background(Color.white)
//            }
//            .padding(16)
//        }
//        
//        .frame(maxWidth: .infinity, maxHeight: .infinity)
//        .cornerRadius(8)
//        .overlay(
//            RoundedRectangle(cornerRadius: 8)
//                .stroke(Color.white.opacity(0.3), lineWidth: 1)
//        )
//        .shadow(color: Color.black.opacity(0.2), radius: 4, x: 0, y:2)
//    }
//}
//
//#Preview {
//    DashboardGachorrView()
//}

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
                    .foregroundColor(.white)
                    
                    Spacer()
                    
                    // Shift Info
                    VStack(spacing: 8) {
                        Text("Shift 1 | Periode 1")
                            .font(.system(size: 14, weight: .semibold))
                            .foregroundColor(.white)
                        
                        HStack(spacing: 20) {
                            // Staff Profile: Kepala Shift
                            StaffProfileView(
                                role: "Kepala Shift",
                                name: "Kreshnavin",
                                imageName: "person.circle.fill" // Replace with your image asset
                            )
                            // Staff Profile: Penjaga Tol
                            StaffProfileView(
                                role: "Penjaga Tol",
                                name: "Bobon Santoso",
                                imageName: "person.circle.fill" // Replace with your image asset
                            )
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


// MARK: - Helper Subviews
// Using helper views makes the main code cleaner and easier to read.

/// A view for displaying a staff member's profile.
struct StaffProfileView: View {
    let role: String
    let name: String
    let imageName: String
    
    var body: some View {
        VStack(spacing: 4) {
            Text(role)
                .font(.system(size: 12))
            
            Image(systemName: imageName) // Using SFSymbols as a placeholder
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(width: 50, height: 50)
                .foregroundColor(.white.opacity(0.8)) // Make placeholder visible
                .clipShape(Circle())
            
            Text(name)
                .font(.system(size: 12, weight: .semibold))
        }
        .foregroundColor(.white)
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
