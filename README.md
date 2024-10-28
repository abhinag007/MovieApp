# MovieApp

This iOS app displays a list of popular movies and allows users to view details and play trailers. It uses TMDb API for data retrieval.

## Setup Instructions
1. Obtain a TMDb API Key [here](https://www.themoviedb.org/).
2. Replace `{API_KEY}` in `APIService.swift` with your actual API key.

## Assumptions
- Only popular movies are fetched.
- Trailers are only played if available on YouTube.

## Features
- Displays popular movies with title, rating, duration, and poster.
- Movie detail page with title, plot, genres, and trailer playback.

### Known Limitations
- Trailers may only be available for some movies.
- YouTube player requires an internet connection.

## Notes and Required Corrections

1. Duration Not Available in Popular Movies API Response
The https://api.themoviedb.org/3/movie/popular endpoint does not include a duration (runtime) field for each movie. To display the duration, we need to make an additional request to the Movie Details API (https://api.themoviedb.org/3/movie/{movie_id}?api_key={API_KEY}) for each movie, as this is the only endpoint that provides the runtime information.
2. Additional API Required for Cast Information
To retrieve cast details, an extra API endpoint, https://api.themoviedb.org/3/movie/{movie_id}/credits?api_key={API_KEY}, is necessary. This endpoint provides the full cast and crew details for each movie, which are not available in the Popular Movies or Movie Details endpoints. Thus, fetching cast information requires a third API call.
3. VPN Requirement for API Access
Accessing the TMDb API (api.themoviedb.org) may require a VPN due to regional restrictions. In certain locations, the API is not accessible without a VPN, so a VPN is necessary to successfully make requests and retrieve data from the API.
