//
//  ContentView.swift
//  Shared
//
//  Created by Wataru Suzuki on 2021/07/28.
//

import SwiftUI
import Combine

struct ContentView: View {
    @State var isCompleted = false
    @State private var cancellables: Set<AnyCancellable> = []

    var body: some View {
        Button("Tap here") {
            URLSession.shared.dataTaskPublisher(for: URL(string: "https://www.apple.com")!)
                .someCustomOperation()
                .sink(receiveCompletion: { completion in
                    switch completion {
                    case .finished:
                        break
                    case .failure(let error):
                        fatalError(error.localizedDescription)
                    }
                },
                receiveValue: {
                    print("data = \($0.data)")
                    print("response = \($0.response)")
                    isCompleted = $0.isCompleted
                })
                .store(in: &cancellables)
        }
        .alert(isPresented: $isCompleted, content: {
            Alert(title: Text("(・∀・)b"), message: nil, dismissButton: .default(Text("OK"), action: {
                UIApplication.shared.open(URL(string: "https://github.com/WataruSuzuki/Hello-Swift-Combine")!, options: [:], completionHandler: nil)
            }))
        })
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
