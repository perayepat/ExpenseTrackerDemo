    //
    //  ContentView.swift
    //  ExpenseTrackerDemo
    //
    //  Created by IACD-013 on 2022/03/30.
    //

import SwiftUI
import SwiftUICharts

struct ContentView: View {
    @EnvironmentObject var transactionListVM: TransactionListViewModel
        //    var demoData: [Double] = [8, 2, 4, 6, 12, 9, 2]
    
    var body: some View {
        NavigationView{
            ScrollView{
                HStack{
                    Button(action: {
                            //Open Menu
                        SideMenu()
                        
                    }, label: {
                        Image(systemName: "rectangle.leadinghalf.filled")
                            .resizable()
                            .foregroundColor(.black)
                            .frame(width: 20, height: 20, alignment: .center)
                            .padding(10)
                          
                    })
                    Spacer()
                    
                    Image(systemName: "bell.badge")
                        .resizable()
                        .symbolRenderingMode(.palette)
                        .foregroundStyle(Color.icon,.primary)
                        .frame(width: 20, height: 20, alignment: .center)
                        .padding(10)
                }
                VStack(alignment: .leading, spacing: 24){
                        //MARK: Title section
                    Text("Overview")
                        .bold()
                        .font(.title2)
                        //MARK: Chart
                    let data = transactionListVM.acculmulateTransactions()
                        //check if the data is not empty before loading the chart
                    if !data.isEmpty{
                        let totalExpenses = data.last?.1 ?? 0
                        CardView{
                            VStack(alignment: .leading){
                                ChartLabel(totalExpenses.formatted(.currency(code: "JPY")), type: .title, format: "¥%.02f")
                                
                                
                                LineChart()
                            }
                            .background(Color.systemBackground)
                        }
                        .data(data)
                        .chartStyle(ChartStyle(backgroundColor: Color.systemBackground, foregroundColor: ColorGradient(Color.iconBackground.opacity(0.4),Color.icon)))
                        .frame(height: 300)
                    }
                        //MARK: Transaction List
                        //we need to pass the enviroment object in order not to crash to preview
                    RecentTransactionList()
                }
                .padding()
                .frame(maxWidth: .infinity)
            }
            .background(Color.background)
            .navigationBarTitleDisplayMode(.inline)
            .toolbar{
                    //MARK: Notification Icon
                ToolbarItem{
                    //moved to top hstack
                   
                }
            }
        }
        .navigationViewStyle(.stack)
            //change the back button Color
        .accentColor(.primary)
    }
}


struct ContentView_Previews: PreviewProvider {
    static let transactionListVM: TransactionListViewModel = {
        let transactionListVM = TransactionListViewModel()
        transactionListVM.transactions = transactionListPreviewData
        return transactionListVM
    }()
    
    static var previews: some View {
        Group{
            ContentView()
                .preferredColorScheme(.light)
            ContentView()
                .preferredColorScheme(.dark)
        }
        .environmentObject(transactionListVM)
    }
}
