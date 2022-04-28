//
//  TransactionList.swift
//  ExpenseTrackerDemo
//
//  Created by IACD-013 on 2022/04/05.
//

import SwiftUI

struct TransactionList: View {
    @EnvironmentObject var transactionListVM: TransactionListViewModel
    
    var body: some View {
        VStack{
            List{
             //MARK: Transaction Groups
                //wrapped in array to avoid Dictionary error
                ForEach(Array(transactionListVM.groupTransactionByMonth()),id:\.key) { month,
                    tranactions in
                    Section{
                        //MARK: Transaction List
                        ForEach(tranactions) {tranactions in
                            TransactionRow(transaction: tranactions)
                        }
                    }header: {
                        //MARK: Transaction Month
                        Text(month)
                    }
                    .listSectionSeparator(.hidden)
                }
            }
            .listStyle(.plain)
        }
        .navigationTitle("Transactions")
        .navigationBarTitleDisplayMode(.inline)
    }
}

struct TransactionList_Previews: PreviewProvider {
    static let transactionListVM: TransactionListViewModel = {
        let transactionListVM = TransactionListViewModel()
        transactionListVM.transactions = transactionListPreviewData
        return transactionListVM
    }()
    static var previews: some View {
        Group {
            //Imbeded in navigation view in order to see the title 
            NavigationView{
                TransactionList()
            }
            
            NavigationView{
                TransactionList()
                    .preferredColorScheme(.dark)
            }
        }
        .environmentObject(transactionListVM)
    }
}
