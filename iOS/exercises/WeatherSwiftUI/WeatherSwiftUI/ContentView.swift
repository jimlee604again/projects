//
//  ContentView.swift
//  WeatherSwiftUI
//
//  Created by Jimmy Lee on 12/4/25.
//

import SwiftUI

struct WeatherData: Codable {
  let current: CurrentWeather
}

struct CurrentWeather: Codable {
  let temperature_2m: Double
  let wind_speed_10m: Double
}

struct ContentView: View {

  @State private var temperature: Double?
  @State private var windSpeed: Double?

  var body: some View {
    VStack {
      Text("Current Weather")
      if let temperature = temperature {
        Text(String(format:"Temperature: %.1f C", trunc(temperature * 10) / 10))
      }
      if let windSpeed = windSpeed {
        Text(String(format:"Wind Speed: %.1f C", trunc(windSpeed * 10) / 10))
      }
    }
    .padding()
    .task {
      await fetchWeather()
    }
  }
  
  func fetchWeather() async {
    let urlString =
      "https://api.open-meteo.com/v1/forecast?latitude=52.52&longitude=13.41&current=temperature_2m,wind_speed_10m&hourly=temperature_2m,relative_humidity_2m,wind_speed_10m"

    guard let url = URL(string: urlString) else { return }

    do {
      let (data, _) = try await URLSession.shared.data(from: url)
      let decodedData = try JSONDecoder().decode(WeatherData.self, from: data)
      DispatchQueue.main.async {
        self.temperature = decodedData.current.temperature_2m
        self.windSpeed = decodedData.current.wind_speed_10m
      }
    } catch {
      print("error fetching weather data: \(error)")
    }
  }
}

#Preview {
  ContentView()
}
