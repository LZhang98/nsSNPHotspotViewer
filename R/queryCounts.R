#' Query dataset for top genes
#'
#' Filter and sort the given dataset (must be of counts, output by \code{getSNPCounts}) based on user-
#' defined parameters.
#'
#' @param countsData A dataframe. Output of \code{getSNPCounts}.
#' @param minLength The minimum length of genes to filter by. Default is 0 (removes nothing).
#' @param minCounts The minimum number of observed SNPs to filter by. Default is 0 (removes nothing).
#' @param sortBy A string that decides the sorting setting of the output. Default is "counts", which
#'     will sort the output data frame by decreasing SNP counts. The other option is "length", which
#'     will sort the output data frame by decreasing gene length, instead. If some other string is put
#'     in, no sorting will be done.
#'
#' @return A subset of the countsData data frame that satisfies the user inputs.
#'
#' @examples
#' countsData <- getSNPCounts(snpPositions)
#' topHits1 <- queryCounts(countsData, 10000, 150)
#' topHits2 <- queryCounts(countsData, 10000, 150, sortBy="length")
#' topHits3 <- queryCounts(countsData, 10000, 150, sortBy="asdf")
#'
#' @export
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
