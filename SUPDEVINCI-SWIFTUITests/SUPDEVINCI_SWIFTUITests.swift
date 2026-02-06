import Testing
import Foundation
import CryptoKit
@testable import SUPDEVINCI_SWIFTUI

struct SUPDEVINCI_SWIFTUITests {

    // Test du modèle User : Hashage et Favoris
    @Test func testUserLogic() async throws {
        var user = User(username: "blanche", name: "Blanche Peltier", email: "b.peltier@supdevinci.fr", password: "password123")
        
        // Vérifie que le mot de passe est bien haché (pas en clair)
        #expect(user.password != "password123")
        #expect(user.verifyPassword("password123") == true)
        
        // Test de l'ajout aux favoris
        user.addFavoriteMovie(movieId: 500)
        #expect(user.isFavorite(movieId: 500) == true)
        #expect(user.favoriteMoviesIds.count == 1)
        
        // Test de la suppression
        user.removeFavoriteMovie(movieId: 500)
        #expect(user.isFavorite(movieId: 500) == false)
    }

    // Test du modèle Movie : URLs et Formatage
    @Test func testMovieFormatting() async throws {
        let movie = Movie(
            id: 101,
            title: "Interstellar",
            overview: "Voyage spatial",
            poster_path: "/image.jpg",
            backdrop_path: nil,
            vote_average: 8.65,
            vote_count: 5000,
            release_date: "2014-11-07",
            original_language: "en",
            popularity: 150.0,
            adult: false,
            genre_ids: [18, 12]
        )
        
        // Vérifie que la note est arrondie correctement
        #expect(movie.formattedRating == "8.7")
        
        // Vérifie la construction de l'URL TMDB [cite: 20]
        #expect(movie.posterURL?.absoluteString == "https://image.tmdb.org/t/p/w500/image.jpg")
    }

    // Test du modèle Favorite
    @Test func testFavoriteModel() async throws {
        let movie = Movie(id: 1, title: "Test", overview: "...", poster_path: nil, backdrop_path: nil, vote_average: 5.0, vote_count: 1, release_date: nil, original_language: nil, popularity: nil, adult: nil, genre_ids: [])
        
        let favorite = Favorite(userId: "user123", movieId: 1, movie: movie)
        
        // Vérifie que les données sont bien liées
        #expect(favorite.userId == "user123")
        #expect(favorite.movie.title == "Test")
        #expect(favorite.formattedDateAdded != "")
    }
}
