//
//  TransactionListViewModel.swift
//  ExpenseTrackerDemo
//
//  Created by IACD-013 on 2022/03/30.
//

import Foundation
import Combine
import Collections

typealias TransactionGroup = OrderedDictionary<String, [Transaction]>
typealias TransactionPrefixSum = [(String,Double)] // record of accumaltive sum
// Turns any object into a publisher and will notify subs for state changes and change thier views
final class TransactionListViewModel :  ObservableObject{
    @Published var transactions: [Transaction] = [] // empty array
    // published notifies its subs when the value has changed
    
    private var cancellables = Set<AnyCancellable>()
    init(){
        getTransactions()
    }
    
    //fetching transactions from the network
    func getTransactions(){
        //reading from a json
        //validate with a guard statement
        
        guard let url = URL(string: "https://designcode.io/data/transactions.json") else {
            print("Invalid URL")
            return
        }
        //fetching data needs a url session
        // allows us to combine events together and handle response each step of the way
        URLSession.shared.dataTaskPublisher(for: url)
            .tryMap{ (data, response) -> Data in
                guard let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode == 200 else{
                //complex API take from 200 to 3000
                        dump(response)
                        throw URLError(.badServerResponse)
                }
                return data
            }
            .decode(type: [Transaction].self, decoder: JSONDecoder())
            .receive(on: DispatchQueue.main)
            .sink { completion in
                switch completion{
                case .failure(let error):
                    print("Error fetching transaction:" ,error.localizedDescription)
                case .finished:
                    print("Finishes fetching transaction")
                }
                //using weak self to prevent memory leaks
            } receiveValue: {[weak self] result  in
                self?.transactions = result
                
                //testing we dump the transaction
                //dump(self?.transactions)
            }
            //sink allows you to return cancellables and free up resources similar to canelling a subscription
            //sink does everything up to the deinitialization phase
            .store(in: &cancellables)
    }
    //returns our type allias group
    //Guard to make sure the group isnt empty
    // We group the transaction by a custom variable
    func groupTransactionByMonth() -> TransactionGroup{
        guard !transactions.isEmpty else {return [:] }
        
      let groupedTransactions = TransactionGroup(grouping: transactions) {$0.month}
        
        return groupedTransactions
    }
    
    //Accumulate Transactions
    func acculmulateTransactions() -> TransactionPrefixSum{
        print("accumulateTransactions")
        guard !transactions.isEmpty else {return []}
        
        let today = "02/17/2022".dateParsed() // date
        let dateInterval = Calendar.current.dateInterval(of: .month, for: today)! // force unwrapped because the date exsists
        print("dateInterval ", dateInterval)
        
        var sum: Double = .zero
        var cumulativeSum = TransactionPrefixSum()
        
        for date in stride(from: dateInterval.start, to: today, by: 60 * 60 * 24){
            let dailyExpenses = transactions.filter{$0.dateParsed == date && $0.isExpense}
            let dailyTotal = dailyExpenses.reduce(0) {$0 - $1.signedAmount}
            
            sum += dailyTotal
            sum = sum.roundedTo2Digits()
            cumulativeSum.append((date.formatted(),sum))
            print(date.formatted(),"DailyTotal: ", dailyTotal, "sum: ", sum)
            
        }
        return cumulativeSum
    }
    
}

