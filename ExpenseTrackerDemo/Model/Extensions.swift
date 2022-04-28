//
//  Extensions.swift
//  ExpenseTrackerDemo
//
//  Created by IACD-013 on 2022/03/30.
//

import Foundation
import SwiftUI
extension Color{
    static let background = Color("Background")
    static let icon = Color("Icon")
    static let text = Color("Text")
    static let iconBackground = Color("IconBackground")
    static let systemBackground = Color(uiColor: .systemBackground)
    static let absaBackground = Color("ABSA")
}
//custom corners
extension View {
    func cornerRadius(_ radius: CGFloat, corners: UIRectCorner) -> some View {
        clipShape( RoundedCorner(radius: radius, corners: corners) )
    }
}
struct RoundedCorner: Shape {

    var radius: CGFloat = .infinity
    var corners: UIRectCorner = .allCorners

    func path(in rect: CGRect) -> Path {
        let path = UIBezierPath(roundedRect: rect, byRoundingCorners: corners, cornerRadii: CGSize(width: radius, height: radius))
        return Path(path.cgPath)
    }
}
extension Image{
    static let image = Image("red-cardinal")
}

//MARK: parsing a string date to a swift date
extension DateFormatter{
    static let allNumericUSA: DateFormatter = {
        print("Initializing DateFormatter")
        let formatter = DateFormatter()
        formatter.dateFormat = "MM/dd/yyyy"
        
        return formatter
    }() // lazily calling the formatter , date formatters are expensive operations
}

//parsing the date
//using a guard incase it fails and returning today if that happens

extension String {
    func dateParsed() -> Date{
        guard let parsedDate = DateFormatter.allNumericUSA.date(from: self) else { return Date()}
        
        return parsedDate
    }
}

//make the date conform to the stride scheme of things
extension Date: Strideable{
    func formatted() -> String {
        return self.formatted(.dateTime.year().month().day())
    }
}

extension Double{
    func roundedTo2Digits() -> Double{
        return(self * 100).rounded() / 100
    }
}

// view
extension View {
    /// Navigate to a new view.
    /// - Parameters:
    ///   - view: View to navigate to.
    ///   - binding: Only navigates when this condition is `true`.
    func navigate<NewView: View>(to view: NewView, when binding: Binding<Bool>) -> some View {
        NavigationView {
            ZStack {
                self
                    .navigationBarTitle("")
                    .navigationBarHidden(true)

                NavigationLink(
                    destination: view
                        .navigationBarTitle("")
                        .navigationBarHidden(true),
                    isActive: binding
                ) {
                    EmptyView()
                }
            }
        }
        .navigationViewStyle(.stack)
    }
}
