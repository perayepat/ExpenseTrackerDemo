//
//  SideMenu.swift
//  ExpenseTrackerDemo
//
//  Created by IACD-013 on 2022/04/20.
//

import SwiftUI

struct MenuItem: Identifiable{
    var id = UUID()
    let text: String
    let imageName: String
    let handler: () -> Void = {
        //switch statement with models for the future
        print("Tapped item")
    }
}

struct MenuContent:View{
    let items:  [MenuItem] = [
        MenuItem(text: "Home", imageName: "house"),
        MenuItem(text: "Profile",imageName: "person.circle"),
        MenuItem(text: "Activity",imageName: "bell"),
        MenuItem(text: "Flights",imageName: "airplane"),
        MenuItem(text: "Share",imageName: "square.and.arrow.up"),
        MenuItem(text: "Setting", imageName: "gear")
    ]
    
    var body: some View{
        ZStack{
            Color(UIColor(red: 33/255, green: 33/255, blue: 33/255, alpha: 1))
            
            VStack(alignment: .leading, spacing: 0){
                ForEach(items){ item in
                    HStack{
                        Image(systemName: item.imageName)
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .foregroundColor(.white)
                            .frame(width: 32, height: 32, alignment: .center)
                            .padding()
                            
                        
                    Text(item.text)
                        .foregroundColor(.white)
                        .bold()
                        .font(.system(size: 22))
                        .multilineTextAlignment(.leading)
                        
                        Spacer()
                    }.onTapGesture {
                        
                    }
                   
                    .padding()
                    
                    Divider()
                }
                Spacer()
            }
            .padding(.top,95)
        }
    }
}

struct sideMenu: View{
    let width: CGFloat
    let menuOpened: Bool
    let toggleMenu: () -> Void
    
    var body: some View{
        ZStack{
            //Dimmed Background
            GeometryReader{_ in
                EmptyView()
            }
            .background(Color.gray.opacity(0.25))
            .opacity(self.menuOpened ? 1 : 0)
            .animation(Animation.easeIn.delay(0.25))
            .onTapGesture {
                self.toggleMenu()
            }
            
            //MenuContent
            HStack{
                MenuContent()
                    .frame(width: width)
                    .offset(x: menuOpened ? 0 : -width)
                    .animation(.default)
                Spacer()
            }
        }
    }
}

struct SideMenu: View {
    @State var menuOpened = false
    
    var body: some View {
        ZStack{
            if !menuOpened{
                Button(action: {
                        //Open Menu
                    self.menuOpened.toggle()
                }, label: {
                    Text("Open Menu")
                        .foregroundColor(.white)
                        .bold()
                        .frame(width: 200, height: 50, alignment: .center)
                        .background(Color(uiColor: .label))
                })
            }
            sideMenu(width: UIScreen.main.bounds.width/1.5,
                     menuOpened: menuOpened,
                     toggleMenu: toggleMenu)
        }
        .edgesIgnoringSafeArea(.all)
    }
    func toggleMenu(){
        menuOpened.toggle()
    }
}



struct Home: View{
    var body: some View {
        Text("Tell me how it's gonna be")
    }
}

struct Menu : View{
    var body: some View{
        VStack{
            HStack{
                Button(action: {
                    
                }){
                    Image("back")
                        .resizable()
                        .frame(width: 12, height: 20)
                }
                Spacer()
                Button(action: {
                    
                }){
                    Image(systemName: "square.and.pencil")
                        .font(.title)
                }
                
            }
            padding(.top)
                .padding(.top)
                .padding(.bottom,25)
            
            Image("user")
                .resizable()
                .frame(width: 80, height: 80)
                .clipShape(Circle())
            
            VStack(spacing: 12){
                Text("Dave")
                Text("Developer")
                    .font(.caption)
                
            }
            .padding(.top,25)
            
            Spacer()
        }
        .frame(width: UIScreen.main.bounds.width / 1.5)
        .padding(.horizontal,20)
    }
    
}

struct SideMenu_Previews: PreviewProvider {
    static var previews: some View {
        SideMenu()
    }
}
