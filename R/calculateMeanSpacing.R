#' Calculate the average number of bases between adjacent SNPs.
#'
#' Given a correctly formatted dataset (see \code{?snpPositions}), parse the SNP
#' positions for each gene and compute the average number of bases between adjacent
#' observed positions. Calculations are padded by inserting fictitious SNPs at the
#' beginning and end of a gene (indices 0 and at length + 1). This is to demonstrate the
#' sparsity of SNPs on genes with few observed loci. The user can specify whether
#' zero-differences (i.e. the amount of space between two repeated observations of
#' the same SNP) should be ignored.
#'
#' @param posData A dataset that contains 3 columns. See \code{?snpPositions} for what this dataset must
#'     be formatted as. Each row represents a gene, and gene has 3 attributes: its id, its length,
#'     and the positions of all SNPs observed on it in the population.
#' @param removeRepeats A boolean that controls whether the function disregards repeated observations
#'     (and in turn ignores zero-differences) while parsing. Default is TRUE.
#'
#' @return A dataframe of 2 columns:
#' \itemize{
#'     \item transcriptID - the id of the gene
#'     \item meanSpacing - the average number of bases between each adjacent SNP on this gene
#' }
#' @examples
#' ms <- calculateMeanSpacing(snpPositions)
#'
#' @export
calculateMeanSpacing <- function(posData, removeRepeats=TRUE) {

    # Build a vector for storing mean spacing stats for each gene
    n <- nrow(posData)
    meanSpacing <- vector(mode="integer",length=n)

    for (i in 1:n) {

        # Parse the position list by separating by '|'
        pos_list <- strsplit(posData$snp_position_list[i], '\\|')

        # Get position after final index
        end <- posData$gene_length[i] + 1

        # usage of unique() function determined by removeRepeats parameter
        if (removeRepeats) {
            positions <- unique(as.integer(unlist(pos_list)))
        } else {
            positions <- as.integer(unlist(pos_list))
        }

        # Padding to calculate distances for SNP loci adjacent to termini of gene
        positions <- c(0, positions, end)

        # calculate the mean difference between adjacent SNPs. If one SNP, default to 0.
        if (length(positions) == 1) {
            meanSpacing[i] <- 0
        } else {
            meanSpacing[i] <- mean(diff(positions))
        }
    }

    # build final dataframe
    result <- data.frame(transcriptID=posData$transcript_id, meanSpacing)

    return(result)
}

# [END]
