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
            ScrollView {
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

                    if viewModel.response != nil {
                        weatherView
                    }

                    Spacer()
                }
            }
            .navigationTitle("Drei Weather")
            .overlay {
                if viewModel.isLoading {
                    ProgressView()
                }
            }
        }
    }

    @ViewBuilder
    private var weatherView: some View {
        VStack(spacing: 8) {
            if let cityName = viewModel.cityName {
                Text(cityName)
                    .font(.largeTitle)
                    .fontWeight(.bold)
            }
            if let temperature = viewModel.temperature {
                Text(temperature)
                    .font(.title)
            }
        }
    }
}

#Preview {
    @StateObject @Previewable var viewModel = ContentView.ViewModel()

    return ContentView(viewModel: viewModel)
        .onAppear {
            viewModel.searchName = "London"
            Task {
                await viewModel.getCity()
            }
        }
//        .modelContainer(for: Item.self, inMemory: true) as! SearchCityResponse
}
