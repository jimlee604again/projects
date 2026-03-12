// @generated
// This file was automatically generated and should not be edited.

@_exported import ApolloAPI
@_spi(Execution) @_spi(Unsafe) import ApolloAPI

extension Countries {
  struct GetAllCountriesQuery: GraphQLQuery {
    static let operationName: String = "GetAllCountriesQuery"
    static let operationDocument: ApolloAPI.OperationDocument = .init(
      definition: .init(
        #"query GetAllCountriesQuery { countries { __typename code name emoji } }"#
      ))

    public init() {}

    nonisolated struct Data: Countries.SelectionSet, Sendable {
      let __data: DataDict
      init(_dataDict: DataDict) { __data = _dataDict }

      static var __parentType: any ApolloAPI.ParentType { Countries.Objects.Query }
      static var __selections: [ApolloAPI.Selection] { [
        .field("countries", [Country].self),
      ] }
      static var __fulfilledFragments: [any ApolloAPI.SelectionSet.Type] { [
        GetAllCountriesQuery.Data.self
      ] }

      var countries: [Country] { __data["countries"] }

      /// Country
      ///
      /// Parent Type: `Country`
      nonisolated struct Country: Countries.SelectionSet, Sendable {
        let __data: DataDict
        init(_dataDict: DataDict) { __data = _dataDict }

        static var __parentType: any ApolloAPI.ParentType { Countries.Objects.Country }
        static var __selections: [ApolloAPI.Selection] { [
          .field("__typename", String.self),
          .field("code", Countries.ID.self),
          .field("name", String.self),
          .field("emoji", String.self),
        ] }
        static var __fulfilledFragments: [any ApolloAPI.SelectionSet.Type] { [
          GetAllCountriesQuery.Data.Country.self
        ] }

        var code: Countries.ID { __data["code"] }
        var name: String { __data["name"] }
        var emoji: String { __data["emoji"] }
      }
    }
  }

}
