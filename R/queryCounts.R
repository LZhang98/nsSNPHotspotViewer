queryCounts <- function(countsData, minLength=0, minCounts=0, sortBy="counts") {

    qData <- countsData[countsData$length>=minLength & countsData$counts>=minCounts, , ]

    if (sortBy=="counts") {
        qData <- qData[order(qData$counts, decreasing=TRUE), ,]
    } else if (sortBy=="length") {
        qData <- qData[order(qData$length, decreasing=TRUE), ,]
    }

    return(qData)
}

if (FALSE) {
    countsData <- getSNPCounts(snpPositions)
    topHits1 <- queryCounts(countsData, 10000, 150)
    topHits2 <- queryCounts(countsData, 10000, 150, sortBy="length")
    topHits3 <- queryCounts(countsData, 10000, 150, sortBy="asdf")
}
