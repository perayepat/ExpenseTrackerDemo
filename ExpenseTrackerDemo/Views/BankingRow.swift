    //
    //  BankingRow.swift
    //  ExpenseTrackerDemo
    //
    //  Created by IACD-013 on 2022/04/12.
    //

import SwiftUI

struct BankingRow: View {
//    Vpassed values
    var bankName : String
    var bank: String
    var rate: Int
   
    var body: some View {
     
        HStack(spacing: 20){
                //MARK: Category Icon
//            RoundedRectangle(cornerRadius: 20, style: .continuous)
//                .fill(Color.iconBackground.opacity(0.3))
//                .frame(width: 44, height: 44)
            Text(bank)
                .bold()
                .font(.title)
                //add Custom Image
            VStack(alignment: .leading, spacing: 6){
                    //MARK: Bank Name
                Text(bankName)
                    .font(.subheadline)
                    .bold()
                    .lineLimit(1)
              
                    
                    //MARK: Transaction Category
                Text("Invest with: \(bankName)")
                    .font(.callout)
                    .opacity(0.7)
                    .lineLimit(1)
                   
                
            }
            .padding([.top,.bottom], 8)
            Spacer()
            
            VStack{
                //MARK: Investment rate
            Text("\(rate)%")
                .bold()
                
            Text("Investment Rate")
                    .font(.caption)
            }
            .padding([.top,.bottom], 8)
            
                //MARK: Header link
//                NavigationLink{
//                    //where its going
//                InvestingView(backgroundColor: <#T##Color#>)
//
//                }label: {
//                    HStack(spacing: 4){
//                        Image(systemName: "chevron.right")
//                    }
//                    .foregroundColor(Color.red)
//                }
            
        }
//        .background(Color.red)

        .cornerRadius(10)
        .padding([.top,.bottom], 8)
    }
    
    struct BankingRow_Previews: PreviewProvider {
        static var previews: some View {
            BankingRow(bankName: "Absa",bank: "Absa",rate: 13)
        }
    }
}
