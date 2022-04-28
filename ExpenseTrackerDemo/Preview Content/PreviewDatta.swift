//
//  PreviewDatta.swift
//  ExpenseTrackerDemo
//
//  Created by IACD-013 on 2022/03/30.
//

import Foundation
import SwiftUI

var transactionPreviewData =
Transaction(id: 1, date: "01/24/2022", institution: "FNB", account: "Visa", merchant: "Apple", amount: 1499.99, type: "debit", categoryId: 901, category: "Software", isPending: false, isTransfer: false, isExpense: true, isEdited: false)


//repeat a data type and make an array out of it
var transactionListPreviewData = [Transaction](repeating: transactionPreviewData, count: 10)

