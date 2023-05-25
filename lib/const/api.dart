const String apiKey = '4f098a761153500ca2a6a2d39980f694';
const String baseUrl = 'https://api.themoviedb.org/3';
const String options = '&language=tr-TR&page=1';

const String nowPlayingApi =
    '$baseUrl/movie/now_playing?api_key=$apiKey$options';
const String popularApi = '$baseUrl/movie/popular?api_key=$apiKey$options';
const String topRatedApi = '$baseUrl/movie/top_rated?api_key=$apiKey$options';
const String upComingApi = '$baseUrl/movie/upcoming?api_key=$apiKey$options';
const String searchApi = '$baseUrl/search/movie?api_key=$apiKey$options';
