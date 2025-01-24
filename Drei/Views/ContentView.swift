//
//  ContentView.swift
//  Drei
//
//  Created by Tomas Bobko on 23.01.25.
//

import SwiftUI
import SwiftData
import SDWebImageSwiftUI

struct ContentView: View {

    @ObservedObject var viewModel: ViewModel

    var body: some View {
        NavigationStack {
            content
            .navigationTitle("Drei Weather")
            .overlay {
                if viewModel.isLoading {
                    ProgressView()
                }
            }
            .alert(isPresented: $viewModel.showsError, error: viewModel.localizedError, actions: { })
        }
    }

    @ViewBuilder
    var content: some View {
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
                        .padding()
                }

                Spacer()
            }
        }
    }

    @ViewBuilder
    private var weatherView: some View {
        VStack(spacing: 8) {

            if let iconURL = viewModel.iconURL {
                WebImage(url: iconURL)
                    .resizable()
                    .frame(width: 100, height: 100)
            }

            if let cityName = viewModel.cityName {
                Text(cityName)
                    .font(.largeTitle)
                    .fontWeight(.bold)
            }
            if let temperature = viewModel.temperature {
                Text(temperature)
                    .font(.title)
            }

            if let weatherDesc = viewModel.weatherDescription {
                Text(weatherDesc)
            }

            Spacer(minLength: 20)

            VStack {
                HStack(spacing: 20) {
                    if let windSpeed = viewModel.windSpeed {
                        HStack(spacing: 4) {
                            Image(systemName: "wind")
                            Text(windSpeed)
                        }
                    }

                    if let precipation = viewModel.rainPrecipation {
                        HStack(spacing: 4) {
                            Image(systemName: "drop")
                            Text(precipation)
                        }
                    } else if let precipitation = viewModel.snowPrecipation {
                        HStack(spacing: 4) {
                            Image(systemName: "snowflake")
                            Text(precipitation)
                        }
                    }
                }
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
