#' Provide the number of SNPs on each gene across the population.
#'
#' Given a properly formatted dataset (see \code{?snpPositions}), count the number of SNPs
#' found on each gene to determine the amount of population-wide variation. This function
#' either provides the number of unique positions on which variation occurs, or counts the
#' total number of observations of variation across the population.
#'
#' @param posData A dataset that contains 3 columns. See \code{?snpPositions} for what this dataset must
#'     be formatted as. Each row represents a gene, and gene has 3 attributes: its id, its length,
#'     and the positions of all SNPs observed on it in the population.
#' @param removeRepeats A boolean specifying whether observed SNPs that share the same position on the
#'     gene are to be counted more than once. Default is \code{TRUE}.
#'
#' @return A dataframe, with each row representing a gene with the following columns:
#' \itemize{
#'     \item id - The id of the gene/transcript (unchanged from input).
#'     \item length - The length of the gene/transcript (unchanged from input).
#'     \item counts - The number of (non-)unique SNPs observed.
#' }
#'
#' @examples
#' getSNPCounts(snpPositions)
#' getSNPCounts(snpPositions, removeRepeats=FALSE)
#'
getSNPCounts <- function(posData, removeRepeats=TRUE) {

    # build up a vector for counting SNPs in each row
    n <- nrow(posData)
    counts <- vector(mode="integer",length=n)
    for (i in 1:n) {

        # split the position list by the '|' character.
        pos_list <- strsplit(posData$snp_position_list[i], '\\|')

        # usage of the unique() function determined by the value of removeRepeats
        if (removeRepeats) {
            counts[i] <- length(unique(unlist(pos_list)))
        } else {
            counts[i] <- length(unlist(pos_list))
        }
    }

    # create and return dataframe
    result <- data.frame(transcriptID=posData$transcript_id, length=posData$gene_length, counts)
    return(result)
}
