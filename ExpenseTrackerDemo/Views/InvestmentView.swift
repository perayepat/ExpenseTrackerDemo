    //
    //  InvestmentView.swift
    //  ExpenseTrackerDemo
    //
    //  Created by IACD-013 on 2022/04/12.
    //

import SwiftUI

struct InvestmentView: View {
    var body: some View {
        ZStack {
//            Rectangle()
//                .fill(Color.init(red: 14/255, green: 10/255, blue: 17/255))
//                .edgesIgnoringSafeArea(.all)
//
            InvestingView(backgroundColor: Color.green)
            
            
            
        }
    }
}

struct InvestmentView_Previews: PreviewProvider {
    static var previews: some View {
        InvestmentView()
    }
}

struct InvestingView : View {
    
    @State public var investmentValue: CGFloat = 0.0
    @State var angleValue: CGFloat = 0.0
    let config = Config(minimumValue: 0.0,
                        maximumValue: 50.0,
                        totalValue: 50.0,
                        knobRadius: 15.0,
                        radius: 125.0)
    
    @State var txtValue : String = ""
    @State var amtValue : String = ""
    @State var rateValue : String = ""
    
    var backgroundColor : Color
    
    var body: some View {
        
        ZStack {
            VStack{
                Text("¥ \(txtValue)")
                    .foregroundColor(Color.white)
                    .bold()
                    .font(.largeTitle)
                    .padding()
                HStack{
                    VStack
                    {
                        Text("Amount")
                            .foregroundColor(Color.white)
                        TextField("Present Value", text: $amtValue)
                            .textFieldStyle(.roundedBorder)
                            .cornerRadius(20)
                            .foregroundColor(Color.black)
                        
                        
                    }
                    VStack
                    {
                        Text("Rate %")
                            .foregroundColor(Color.white)
                        TextField("Investment rate", text: $rateValue)
                            .textFieldStyle(.roundedBorder)
                            .cornerRadius(20)
                            .foregroundColor(Color.black)
                        
                    }
                }
                Button("Calculate") {
                        //                Method here
                    txtValue = FutureValueConverter()
                    
                }
                
                .foregroundColor(Color.white)
                .overlay(
                    RoundedRectangle(cornerRadius: 20)
                        .stroke(Color.white, lineWidth: 2)
                        .frame(width: 350, height: 50)
                    
                )
                .frame(width: 350, height: 50)
                .padding(.top)
                
                Spacer()
                    .frame(height: 50)
                
                    .padding()
            }
            .padding()
            .background(Rectangle()
                .fill(backgroundColor)
                .cornerRadius(70, corners: [.topLeft, .topRight]))
            .position(x: 200, y: 780)
            
            Circle()
                .frame(width: config.radius * 2, height: config.radius * 2)
                .scaleEffect(1.2)
            
            Circle()
                .stroke(Color.gray,
                        style: StrokeStyle(lineWidth: 3, lineCap: .butt, dash: [3, 23.18]))
                .frame(width: config.radius * 2, height: config.radius * 2)
            
            Circle()
                .trim(from: 0.0, to: investmentValue/config.totalValue)
                .stroke(investmentValue < config.maximumValue/2 ? Color.blue : Color.red, lineWidth: 4)
                .frame(width: config.radius * 2, height: config.radius * 2)
                .rotationEffect(.degrees(-90))
            
            Circle()
                .fill(investmentValue < config.maximumValue/2 ? Color.blue : Color.red)
                .frame(width: config.knobRadius * 2, height: config.knobRadius * 2)
                .padding(10)
                .offset(y: -config.radius)
                .rotationEffect(Angle.degrees(Double(angleValue)))
                .gesture(DragGesture(minimumDistance: 0.0)
                    .onChanged({ value in
                        change(location: value.location)
                    }))
            VStack{
                Text("\(String.init(format: "%.0f", investmentValue))")
                    .font(.system(size: 60))
                    .foregroundColor(.white)
                Text("Years")
                    .foregroundColor(Color.white)
                    .bold()
            }
            
        }.position(x: 190, y: 300)
            .background(Rectangle()
                .fill(Color.init(red: 14/255, green: 10/255, blue: 17/255))
                .edgesIgnoringSafeArea(.all))
        
        
    }
    
    
    
        //FV Formula
    
    func FutureValueConverter() -> String{
        let amount : Double = Double(amtValue.description)!
        let rate : Double = Double(rateValue.description)!
        let newRate = rate/100
        var years : Double = Double(investmentValue.description)!
        
        let interest = (1+newRate)
        let interestRate = pow(interest,years)
        let FV = amount*interestRate * 100/100.0
        
        let result = ("\(String.init(format: "%.2f", FV))")
        return result
    }
    
        //    Circular ring FINALLY WORKS THANK YOU SOME INDIAN GUY
    
    private func change(location: CGPoint) {
            // creating vector from location point
        let vector = CGVector(dx: location.x, dy: location.y)
        
            // geting angle in radian need to subtract the knob radius and padding
        let angle = atan2(vector.dy - (config.knobRadius + 10), vector.dx - (config.knobRadius + 10)) + .pi/2.0
        
            // convert angle range from (-pi to pi) to (0 to 2pi)
        let fixedAngle = angle < 0.0 ? angle + 2.0 * .pi : angle
            // convert angle value to value
        let value = fixedAngle / (2.0 * .pi) * config.totalValue
        
        if value >= config.minimumValue && value <= config.maximumValue {
            investmentValue = value
            angleValue = fixedAngle * 180 / .pi // converting to degree
        }
    }
    
}

struct Config {
    let minimumValue: CGFloat
    let maximumValue: CGFloat
    let totalValue: CGFloat
    let knobRadius: CGFloat
    let radius: CGFloat
}
