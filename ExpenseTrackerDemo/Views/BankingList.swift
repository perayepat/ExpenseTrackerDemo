    //
    //  BankingList.swift
    //  ExpenseTrackerDemo
    //
    //  Created by IACD-013 on 2022/04/12.
    //

import SwiftUI

struct BankingList: View {
    @State private var willMoveToNextScreen = false
    var body: some View {
        NavigationView{
            VStack{
                BankingRow(bankName: "Absa", bank: "A", rate: 13)
                BankingRow(bankName: "FNB", bank: "F", rate: 9)
                BankingRow(bankName: "NedBank", bank: "N", rate: 4)
            }
          
            .padding()
            .background(Color.systemBackground)
            .clipShape(RoundedRectangle(cornerRadius: 20,style: .continuous))
            .shadow(color: Color.black.opacity(0.2), radius: 10, x: 0, y: 5)
           
        }

        .onTapGesture {
                  // change state closing any dropdown here
            willMoveToNextScreen = true
           
               }
        .navigate(to: InvestingView(backgroundColor: Color.red), when: $willMoveToNextScreen)
        .navigationTitle("Bank Investments")
        
    }
}

struct BankingList_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView{
        BankingList()
        }
    }
}
