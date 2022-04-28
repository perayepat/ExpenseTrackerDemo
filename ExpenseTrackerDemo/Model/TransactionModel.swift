//
//  TransactionModel.swift
//  ExpenseTrackerDemo
//
//  Created by IACD-013 on 2022/03/30.
//

import Foundation
import SwiftUIFontIcon
import DeveloperToolsSupport

//Identifiable allows each new transaction to be unique in the list, giving each transaction an
struct Transaction: Identifiable, Decodable,Hashable{
    let id:Int
    let date: String
    let institution: String
    let account: String
    var merchant : String
    let amount: Double
    let type: TransactionType.RawValue
    var categoryId: Int
    var category: String
    let isPending: Bool
    var isTransfer: Bool
    var isExpense: Bool
    var isEdited: Bool
    
    //view model wasnt neccessary 
    var icon:FontAwesomeCode{
        if let catergory = Category.all.first(where: { $0.id == categoryId }){
            return catergory.icon
        }
        return .question
    }
    
    //using the extension we created to parse the date into a readable format 
    var dateParsed: Date {
        date.dateParsed()
    }
    
    var signedAmount : Double {
        return type == TransactionType.credit.rawValue ? amount : -amount
    }
    
    var month:String{
        dateParsed.formatted(.dateTime.year().month(.wide))
    }
    
}

enum TransactionType: String{
    case debit = "debit"
    case credit = "credit"
}

//new struct for category
struct Category{
    let id: Int
    let name:  String
    let icon: FontAwesomeCode
    //main cat is optional var instead of let
    var mainCategoryId: Int?
}

extension Category{
    //main categories
    static let autoAndTransport = Category(id: 1, name: "Auto & Transport", icon: .car_alt)
    static let billsAndUtilities = Category(id: 2, name: "Bills & Utilities", icon: .file_invoice_dollar)
    static let entertainment = Category(id: 3, name: "Entertainment", icon: .film)
    static let feesAndChargers = Category(id: 4, name: "Fees & Charges", icon: .hand_holding_usd)
    static let foodAndDining = Category(id: 5, name: "Food & Dinning", icon: .hamburger)
    static let home = Category(id: 6, name: "Home", icon: .home)
    static let income = Category(id: 7, name: "Income", icon: .yen_sign)
    static let shopping = Category(id: 8, name: "Shopping", icon: .shopping_cart)
    static let transfer = Category(id: 9, name: "Transfer", icon: .exchange_alt)
    
    //sub categories
    //Id follows the main category number
    static let publicTransportation = Category(id: 101, name: "Public Transportation", icon: .bus, mainCategoryId: 1)
    static let taxi = Category(id: 102, name: "Taxi", icon: .taxi, mainCategoryId: 1)
    static let mobilePhone = Category(id: 201, name: "Mobile Phone", icon: .phone, mainCategoryId: 2)
    static let moviesAndDVDs = Category(id: 301, name: "Movies & DVDs", icon: .film, mainCategoryId: 3)
    static let bankFee = Category(id: 401, name: "Bank Fee", icon: .hand_holding, mainCategoryId: 4)
    static let financeCharge = Category(id: 402, name: "Finance Charge", icon: .hand_holding, mainCategoryId: 4)
    static let groceries = Category(id: 501, name: "Groceries", icon: .shopping_bag, mainCategoryId: 5)
    static let resturants = Category(id: 502, name: "Resturants", icon: .utensils, mainCategoryId: 5)
    static let rent = Category(id: 601, name: "Rent", icon: .house_user, mainCategoryId: 6)
    static let homeSupplies = Category(id: 602, name: "Home Supplies", icon: .lightbulb, mainCategoryId: 6)
    static let paycheque = Category(id: 701, name: "Paycheque", icon: .dollar_sign, mainCategoryId: 7)
    static let software = Category(id: 801, name: "Software", icon: .icons, mainCategoryId: 8)
    static let creditCardPayment = Category(id: 901, name: "Credit Card Payment", icon: .exchange_alt, mainCategoryId: 9)
    
}

extension Category{
    
    //retrevieal is made easier
    static let categories: [Category] = [
        .autoAndTransport,
        .billsAndUtilities,
        .entertainment,
        .feesAndChargers,
        .foodAndDining,
        .home,
        .income,
        .shopping,
        .transfer
    ]
    
    static let subCategories: [Category] = [
        .publicTransportation,
        .taxi,
        .mobilePhone,
        .moviesAndDVDs,
        .bankFee,
        .financeCharge,
        .groceries,
        .resturants,
        .rent,
        .homeSupplies,
        .paycheque,
        .software,
        .creditCardPayment
    ]
    
    static let all: [Category] = categories + subCategories
    
}
