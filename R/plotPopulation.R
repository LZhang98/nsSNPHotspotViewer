#' Provide a large-scale visualization of the variation in the population represented
#' by the dataset.
#'
#' Outputs a scatterplot using ggplot2 that plots the length of each gene against
#' the number of SNPs observed on that gene. By default, each locus
#' is counted once and only once -- repeats are ignored. However, this can be changed using
#' the removeRepeats parameter.
#'
#' @param posData A dataset that contains 3 columns. See \code{?snpPositions} for what this dataset must
#'     be formatted as. Each row represents a gene, and gene has 3 attributes: its id, its length,
#'     and the positions of all SNPs observed on it in the population.
#' @param removeRepeats A boolean specifying whether observed SNPs that share the same position on the
#'     gene are to be counted more than once. Default is \code{TRUE}.
#'
#' @return Produces a scatterplot, and returns it.
#'
#' @examples
#' plotPopulation(snpPositions)
#' plotPopulation(snpPositions, removeRepeats=FALSE)
#'
#' @import ggplot2
#' @export
plotPopulation <- function(posData, removeRepeats=TRUE) {

    # produce SNP count data. removeRepeats argument is used here.
    countsData <- getSNPCounts(posData, removeRepeats)

    # build dataframe for scatterplot, then output
    plotData <- data.frame(posData$transcript_id, geneLength=posData$gene_length,counts=countsData$counts)
    plot <- ggplot2::ggplot(data=plotData) + geom_point(mapping = aes(x = geneLength, y = counts))
    plot <- plot + ggplot2::ggtitle("SNP Counts Across the Population") +
        ggplot2::xlab("Gene Length") + ggplot2::ylab("Number of SNPs observed")
    plot <- plot + ggplot2::theme(plot.title = element_text(hjust = 0.5))
    plot
    return(plot)
}
