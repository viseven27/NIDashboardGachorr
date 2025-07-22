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

import SwiftUI

struct DashboardGachorrView: View {
    var body: some View {
        ZStack{
            //Blue Gradient background
            LinearGradient(
                gradient: Gradient(colors:[
                    Color(red: 0.05, green: 0.20, blue: 0.40),
                    Color(red: 0.15, green: 0.45, blue: 0.80)
                ]),
                startPoint: .topLeading,
                endPoint: .bottomTrailing
            )
            
            VStack(alignment: .center, spacing: 8) {
                //Baris ke 1
                HStack(){
                    ArrowBoxView()
                    
                    VStack(){
                        Text("iTol-Sistem Transaksi Tol")
                        Text("PONDOK AREN - GATE 8")
                        Text("Shift 1 * Periode 1")
                    }
                    .background(Color.orange)
                    
                    VStack(alignment: .center, spacing: 4){
                        Text("Kepala Shift")
                            .font(.subheadline)
                            .foregroundColor(.white)
                        
                        Image("Pentol1_Prabowo")
                            .resizable()
                            .clipShape(Circle())
//                            .clip(Circle())
                        Text("Prabowo")
                    }

                    
                    VStack(){
                        Text("Penjaga Tol")
                            .font(.subheadline)
                            .foregroundColor(.white)
                        
                        Image("Pentol2_Gibran")
                            .resizable()
                            .clipShape(Circle())
//                            .clip(Circle())
                        Text("Gibran")
                    }
                }
                
                //Baris ke 2
                HStack(){
                    VStack(){
                        Text("Gandar")
                            .font(.headline)
                        Text("Box Gandar")
                    }
                    .background(Color.yellow)
                    
                    VStack(){
                        Text("Ban")
                        Text("Box Ban")
                    }
                    .background(Color.green)
                    
                    VStack(){
                        Text("Harga: ")
                        Text("Sisa Saldo: ")
                        Text("Metode: ")
                        Text("Nomor Kartu: ")
                    }
                    .background(Color.yellow)
                }
                .background(Color.white)
                
                //Baris 3
                HStack(){
                    Text("Tombol CTA")
                        .background(Color.green)
                }
                .background(Color.white)
            }
            .padding(16)
        }
        
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .cornerRadius(8)
        .overlay(
            RoundedRectangle(cornerRadius: 8)
                .stroke(Color.white.opacity(0.3), lineWidth: 1)
        )
        .shadow(color: Color.black.opacity(0.2), radius: 4, x: 0, y:2)
    }
}

#Preview {
    DashboardGachorrView()
}


