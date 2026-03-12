import SwiftUI
import Apollo

class Network {
    static let shared  = Network()
    var apollo = ApolloClient(url: URL(string: "https://countries.trevorblades.com")!)
}


struct ContentView: View {
    
    @State private var countries: [GetAllCountriesQuery.Data.Country?] = []
    
    var body: some View {
        
        NavigationStack {
            VStack {
                List(countries, id: \.?.code) { country in
                    HStack {
                        Text(country?.emoji ?? "")
                        Text(country?.name ?? "")
                    }
                }
            }
            .onAppear(perform: {
                Network.shared.apollo.fetch(query: GetAllCountriesQuery()) { result in
                    switch result {
                        case .success(let graphQLResult):
                            if let countries = graphQLResult.data?.countries {
                                DispatchQueue.main.async {
                                    self.countries = countries
                                }
                            }
                        case .failure(let error):
                            print(error)
                        }
                }
            })
        .navigationTitle("Countries")
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
