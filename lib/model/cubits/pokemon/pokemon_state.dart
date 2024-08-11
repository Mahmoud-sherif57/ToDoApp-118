sealed class PokemonState {}

final class PokemonInitialState extends PokemonState {}

final class GetAllPokemonLoadingState extends PokemonState {}

final class GetAllPokemonSuccessfulState extends PokemonState {}

final class GetAllPokemonFailedState extends PokemonState {}
