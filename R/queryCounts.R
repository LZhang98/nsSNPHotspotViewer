#' Query dataset for top genes
#'
#' Filter and sort the given dataset (must be of counts, output by \code{getSNPCounts}) based on user-
#' defined parameters.
#'
#' @param countsData A dataframe. Output of \code{getSNPCounts}.
#' @param minLength The minimum length of genes to filter by. Default is 0 (removes nothing).
#' @param minCounts The minimum number of observed SNPs to filter by. Default is 0 (removes nothing).
#' @param sortBy A string that decides the sorting setting of the output. If none of the below arguments
#'     are used, use default sorting. Potentional arguments:
#' \itemize{
#'     \item \code{counts} - The default argument. Sort by decreasing SNP counts.
#'     \item \code{length} - Sort by decreasing gene length
#'     \item \code{none} - No sorting is performed, and the subset is returned as is.
#' }
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

    # Check user inputs. Non-fatal, so simply a warning is passed.
    if (!(sortBy %in% c("counts", "length", "none"))) {
        sortBy <- "counts"
        warning("Invalid sortBy argument. Default used.")
    }

    # Produce subset
    qData <- countsData[countsData$length>=minLength & countsData$counts>=minCounts, , ]

    # No sorting done
    if (sortBy == "none") {
        return(qData)
    }

    # Sort by counts
    if (sortBy=="counts") {
        qData <- qData[order(qData$counts, decreasing=TRUE), ,]
        return(qData)
    }

    # Sort by length
    if (sortBy=="length") {
        qData <- qData[order(qData$length, decreasing=TRUE), ,]
        return(qData)
    }
}

# [END]
