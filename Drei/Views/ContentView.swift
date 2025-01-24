//
//  ContentView.swift
//  Drei
//
//  Created by Tomas Bobko on 23.01.25.
//

import SwiftUI
import SwiftData

struct ContentView: View {

    @ObservedObject var viewModel: ViewModel

    var body: some View {
        NavigationStack {
            VStack {
                TextField("City name", text: $viewModel.searchName)
                    .padding()
                    .background(.black.opacity(0.05))
                    .clipShape(RoundedRectangle(cornerRadius: 10))
                    .padding()
                    .onSubmit {
                        Task {
                            await viewModel.getCity()
                        }
                    }
                    .submitLabel(.search)

                Spacer()
            }
            .navigationTitle("Drei Weather")
        }
    }
}

#Preview {
    ContentView(viewModel: ContentView.ViewModel())
        .modelContainer(for: Item.self, inMemory: true)
}

@MainActor
class AppViewModel: ObservableObject {
    @Published var isLoading = false
}
