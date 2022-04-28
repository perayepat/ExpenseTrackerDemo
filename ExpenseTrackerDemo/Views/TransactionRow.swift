//
//  TransactionRow.swift
//  ExpenseTrackerDemo
//
//  Created by IACD-013 on 2022/03/30.
//

import SwiftUI
import SwiftUIFontIcon

struct TransactionRow: View {
    var transaction: Transaction
    
    var body: some View {
        HStack(spacing: 20){
            //MARK: Category Icon
            RoundedRectangle(cornerRadius: 20, style: .continuous)
                .fill(Color.iconBackground.opacity(0.3))
                .frame(width: 44, height: 44)
            //Third Party for icons
                .overlay(FontIcon.text(.awesome5Solid(code: transaction.icon),fontsize: 24, color: Color.icon))
            VStack(alignment: .leading, spacing: 6){
                //MARK: Transaction Merchant
                Text(transaction.merchant)
                    .font(.subheadline)
                    .bold()
                    .lineLimit(1)
                
                //MARK: Transaction Category
                Text(transaction.category)
                    .font(.footnote)
                    .opacity(0.7)
                    .lineLimit(1)
                
                //MARK: Tranaction Date
                Text(transaction.dateParsed, format: .dateTime.year().month().day())
                    .font(.footnote)
                    .foregroundColor(.secondary)
            }
            Spacer()
            
            //MARK: transaction Amount
            Text(transaction.signedAmount,format: .currency(code: "JPY"))
                .bold()
                .foregroundColor(transaction.type == TransactionType.credit.rawValue ? Color.text : .primary)
            
        }
        .padding([.top,.bottom], 8)
    }
}

struct TransactionRow_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            TransactionRow(transaction: transactionPreviewData)
            TransactionRow(transaction: transactionPreviewData)
                .preferredColorScheme(.dark)
        }
    }
}
