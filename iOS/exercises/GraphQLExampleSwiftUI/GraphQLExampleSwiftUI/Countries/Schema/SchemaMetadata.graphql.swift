// @generated
// This file was automatically generated and should not be edited.

import ApolloAPI

protocol Countries_SelectionSet: ApolloAPI.SelectionSet & ApolloAPI.RootSelectionSet
where Schema == Countries.SchemaMetadata {}

protocol Countries_InlineFragment: ApolloAPI.SelectionSet & ApolloAPI.InlineFragment
where Schema == Countries.SchemaMetadata {}

protocol Countries_MutableSelectionSet: ApolloAPI.MutableRootSelectionSet
where Schema == Countries.SchemaMetadata {}

protocol Countries_MutableInlineFragment: ApolloAPI.MutableSelectionSet & ApolloAPI.InlineFragment
where Schema == Countries.SchemaMetadata {}

extension Countries {
  typealias SelectionSet = Countries_SelectionSet

  typealias InlineFragment = Countries_InlineFragment

  typealias MutableSelectionSet = Countries_MutableSelectionSet

  typealias MutableInlineFragment = Countries_MutableInlineFragment

  nonisolated enum SchemaMetadata: ApolloAPI.SchemaMetadata, Sendable {
    static let configuration: any ApolloAPI.SchemaConfiguration.Type = SchemaConfiguration.self

    static func objectType(forTypename typename: String) -> ApolloAPI.Object? {
      switch typename {
      case "Country": return Countries.Objects.Country
      case "Query": return Countries.Objects.Query
      default: return nil
      }
    }
  }

  enum Objects {}
  enum Interfaces {}
  enum Unions {}

}
