//
//  SplashScreenView.swift
//  ExpenseTrackerDemo
//
//  Created by IACD-013 on 2022/04/10.
//

import SwiftUI

struct SplashScreenView: View {
    @StateObject var transactionListVM = TransactionListViewModel()
    @State private var isActive = false
    @State private var size = 0.8
    @State private var opacity = 0.5
    
    var body: some View {
        if isActive{
            ContentView()
                .environmentObject(transactionListVM)
        }
        else{
            VStack{
                VStack{
                    Image("red-cardinal")
                        .resizable()
                        .frame(width: 200, height: 200, alignment: .center)
                    Text("Cardinal")
                        .bold()
                        .font(Font.largeTitle)
                }
                .scaleEffect(size)
                .opacity(opacity)
                .onAppear{
                    withAnimation(.easeIn(duration: 1.2)){
                        self.size = 0.9
                        self.opacity = 1.0
                    }
                }
            }
            .onAppear{
                DispatchQueue.main.asyncAfter(deadline: .now() + 1.0){
                    withAnimation{
                        self.isActive = true
                    }
                }
            }
        }
    }
}

struct SplashScreenView_Previews: PreviewProvider {
    static var previews: some View {
        SplashScreenView()
    }
}
