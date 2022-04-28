    //
    //  ExpenseTrackerDemoApp.swift
    //  ExpenseTrackerDemo
    //
    //  Created by IACD-013 on 2022/03/30.
    //

import SwiftUI

@main
struct ExpenseTrackerDemoApp: App {
    @StateObject var transactionListVM = TransactionListViewModel()
    
    var body: some Scene {
        WindowGroup {
       SplashScreenView()
//            BankingList()
        }
    }
}
