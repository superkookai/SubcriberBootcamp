//
//  ContentView.swift
//  SubcriberBootcamp
//
//  Created by Weerawut Chaiyasomboon on 14/03/2568.
//

import SwiftUI

struct ContentView: View {
    @StateObject private var vm = SubcriberViewModel()
    
    var body: some View {
        VStack {
            Text("\(vm.count)")
                .font(.largeTitle)
            
            TextField("Type here..", text: $vm.textFieldText)
                .font(.headline)
                .padding(.leading)
                .frame(height: 55)
                .background(.ultraThinMaterial)
                .clipShape(.rect(cornerRadius: 10))
                .padding(.horizontal)
                .overlay(alignment: .trailing) {
                    ZStack {
                        Image(systemName: "xmark.circle.fill")
                            .foregroundStyle(.red)
                            .opacity(vm.textFieldText.count < 1 ? 0 :
                                vm.textIsValid ? 0 : 1)
                        
                        Image(systemName: "checkmark.circle.fill")
                            .foregroundStyle(.green)
                            .opacity(vm.textIsValid ? 1 : 0)
                    }
                    .padding(.trailing,25)
                }
            
            Button {
                
            } label: {
                Text("Submit")
                    .font(.title3)
                    .fontWeight(.semibold)
                    .foregroundStyle(.white)
                    .padding(.vertical,10)
                    .frame(maxWidth: .infinity)
                    .background(.green)
                    .clipShape(.rect(cornerRadius: 10))
                    .padding(.horizontal)
                    .opacity(vm.showButton ? 1 : 0.5)
            }
            .disabled(!vm.showButton)

        }
    }
}

#Preview {
    ContentView()
}
