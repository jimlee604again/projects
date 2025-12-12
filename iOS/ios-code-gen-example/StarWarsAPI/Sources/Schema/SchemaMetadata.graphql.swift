// @generated
// This file was automatically generated and should not be edited.

import ApolloAPI

public protocol SelectionSet: ApolloAPI.SelectionSet & ApolloAPI.RootSelectionSet
where Schema == StarWarsAPI.SchemaMetadata {}

public protocol InlineFragment: ApolloAPI.SelectionSet & ApolloAPI.InlineFragment
where Schema == StarWarsAPI.SchemaMetadata {}

public protocol MutableSelectionSet: ApolloAPI.MutableRootSelectionSet
where Schema == StarWarsAPI.SchemaMetadata {}

public protocol MutableInlineFragment: ApolloAPI.MutableSelectionSet & ApolloAPI.InlineFragment
where Schema == StarWarsAPI.SchemaMetadata {}

public enum SchemaMetadata: ApolloAPI.SchemaMetadata {
  public static let configuration: any ApolloAPI.SchemaConfiguration.Type = SchemaConfiguration.self

  @_spi(Execution) public static func objectType(forTypename typename: String) -> ApolloAPI.Object? {
    switch typename {
    case "Film": return StarWarsAPI.Objects.Film
    case "FilmSpeciesConnection": return StarWarsAPI.Objects.FilmSpeciesConnection
    case "FilmsConnection": return StarWarsAPI.Objects.FilmsConnection
    case "Person": return StarWarsAPI.Objects.Person
    case "Planet": return StarWarsAPI.Objects.Planet
    case "Root": return StarWarsAPI.Objects.Root
    case "Species": return StarWarsAPI.Objects.Species
    case "Starship": return StarWarsAPI.Objects.Starship
    case "Vehicle": return StarWarsAPI.Objects.Vehicle
    default: return nil
    }
  }
}

public enum Objects {}
public enum Interfaces {}
public enum Unions {}
