//
//  dataResponse.swift
//  Created on May 19, 2019, mohd shahid

import Foundation


class dataResponse : NSObject, NSCoding{

    var addedDateTime : String!
    var currentNumberOfPeers : Int!
    var currentNumberOfSeeds : Int!
    var downloadSpeed : String!
    var downloadedSize : NSNumber!
    var movieTitle : String!
    var movieYear : String!
    var status : Int!
    var totalNumberPeers : Int!
    var totalNumberSeeds : Int!
    var uploadSpeed : String!
    var uploadStatus : String!
    var uploadedSize : String!


    /**
     * Instantiate the instance using the passed dictionary values to set the properties values
     */
    init(fromDictionary dictionary: [String:Any]){
        addedDateTime = dictionary["added_date_time"] as? String
        currentNumberOfPeers = dictionary["current_number_of_peers"] as? Int
        currentNumberOfSeeds = dictionary["current_number_of_seeds"] as? Int
        downloadSpeed = dictionary["download_speed"] as? String
        downloadedSize = dictionary["downloaded_size"] as? NSNumber
        movieTitle = dictionary["movie_title"] as? String
        movieYear = dictionary["movie_year"] as? String
        status = dictionary["status"] as? Int
        totalNumberPeers = dictionary["total_number_peers"] as? Int
        totalNumberSeeds = dictionary["total_number_seeds"] as? Int
        uploadSpeed = dictionary["upload_speed"] as? String
        uploadStatus = dictionary["upload_status"] as? String
        uploadedSize = dictionary["uploaded_size"] as? String
    }

    /**
     * Returns all the available property values in the form of [String:Any] object where the key is the approperiate json key and the value is the value of the corresponding property
     */
    func toDictionary() -> [String:Any]
    {
        var dictionary = [String:Any]()
        if addedDateTime != nil{
            dictionary["added_date_time"] = addedDateTime
        }
        if currentNumberOfPeers != nil{
            dictionary["current_number_of_peers"] = currentNumberOfPeers
        }
        if currentNumberOfSeeds != nil{
            dictionary["current_number_of_seeds"] = currentNumberOfSeeds
        }
        if downloadSpeed != nil{
            dictionary["download_speed"] = downloadSpeed
        }
        if downloadedSize != nil{
            dictionary["downloaded_size"] = downloadedSize
        }
        if movieTitle != nil{
            dictionary["movie_title"] = movieTitle
        }
        if movieYear != nil{
            dictionary["movie_year"] = movieYear
        }
        if status != nil{
            dictionary["status"] = status
        }
        if totalNumberPeers != nil{
            dictionary["total_number_peers"] = totalNumberPeers
        }
        if totalNumberSeeds != nil{
            dictionary["total_number_seeds"] = totalNumberSeeds
        }
        if uploadSpeed != nil{
            dictionary["upload_speed"] = uploadSpeed
        }
        if uploadStatus != nil{
            dictionary["upload_status"] = uploadStatus
        }
        if uploadedSize != nil{
            dictionary["uploaded_size"] = uploadedSize
        }
        return dictionary
    }

    /**
     * NSCoding required initializer.
     * Fills the data from the passed decoder
     */
    @objc required init(coder aDecoder: NSCoder)
    {
        addedDateTime = aDecoder.decodeObject(forKey: "added_date_time") as? String
        currentNumberOfPeers = aDecoder.decodeObject(forKey: "current_number_of_peers") as? Int
        currentNumberOfSeeds = aDecoder.decodeObject(forKey: "current_number_of_seeds") as? Int
        downloadSpeed = aDecoder.decodeObject(forKey: "download_speed") as? String
        downloadedSize = aDecoder.decodeObject(forKey: "downloaded_size") as? NSNumber
        movieTitle = aDecoder.decodeObject(forKey: "movie_title") as? String
        movieYear = aDecoder.decodeObject(forKey: "movie_year") as? String
        status = aDecoder.decodeObject(forKey: "status") as? Int
        totalNumberPeers = aDecoder.decodeObject(forKey: "total_number_peers") as? Int
        totalNumberSeeds = aDecoder.decodeObject(forKey: "total_number_seeds") as? Int
        uploadSpeed = aDecoder.decodeObject(forKey: "upload_speed") as? String
        uploadStatus = aDecoder.decodeObject(forKey: "upload_status") as? String
        uploadedSize = aDecoder.decodeObject(forKey: "uploaded_size") as? String
    }

    /**
     * NSCoding required method.
     * Encodes mode properties into the decoder
     */
    @objc func encode(with aCoder: NSCoder)
    {
        if addedDateTime != nil{
            aCoder.encode(addedDateTime, forKey: "added_date_time")
        }
        if currentNumberOfPeers != nil{
            aCoder.encode(currentNumberOfPeers, forKey: "current_number_of_peers")
        }
        if currentNumberOfSeeds != nil{
            aCoder.encode(currentNumberOfSeeds, forKey: "current_number_of_seeds")
        }
        if downloadSpeed != nil{
            aCoder.encode(downloadSpeed, forKey: "download_speed")
        }
        if downloadedSize != nil{
            aCoder.encode(downloadedSize, forKey: "downloaded_size")
        }
        if movieTitle != nil{
            aCoder.encode(movieTitle, forKey: "movie_title")
        }
        if movieYear != nil{
            aCoder.encode(movieYear, forKey: "movie_year")
        }
        if status != nil{
            aCoder.encode(status, forKey: "status")
        }
        if totalNumberPeers != nil{
            aCoder.encode(totalNumberPeers, forKey: "total_number_peers")
        }
        if totalNumberSeeds != nil{
            aCoder.encode(totalNumberSeeds, forKey: "total_number_seeds")
        }
        if uploadSpeed != nil{
            aCoder.encode(uploadSpeed, forKey: "upload_speed")
        }
        if uploadStatus != nil{
            aCoder.encode(uploadStatus, forKey: "upload_status")
        }
        if uploadedSize != nil{
            aCoder.encode(uploadedSize, forKey: "uploaded_size")
        }
    }
}
