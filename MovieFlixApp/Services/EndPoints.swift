//
//  EndPoints.swift
//  MVVM-Movies
//


import Foundation

enum MoviesEndPoint: String {
    case getPopular  = "/movie/now_playing?"
    case getTopRates = "/movie/top_rated?"
    case getUpcomings  = "/movie/upcoming?"
    case getGenres = "/genre/movie/list?"
}


enum TvShowsEndPoint: String {
    case getPopularTv  = "/tv/popular?"
    case getTopRatesTv = "/tv/top_rated?"
    case getUpcomingsTv = "/tv/airing_today?"
}
