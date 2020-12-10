#' Initialize a Gene object from the dataset.
#'
#' Allows the user to identify any gene by its string ID from within a properly formatted
#' dataset (see \code{?snpPositions}) and initialize an object with the proper attributes
#' for visualization (see \code{?visualizeGene}).
#'
#' The method returns a list (with a class defined as "Gene") with 4 fields. The \code{posTable} field
#' is in turn a data frame of 2 columns: the first being the SNP positions and the second being the
#' number of times that SNP is repeated in the population. This is used for heatmap visualization in
#' the final graphic.
#'
#' @param id A string denoting the id of the gene name.
#' @param posData A dataset that contains 3 columns. See \code{?snpPositions} for what this dataset must
#'     be formatted as. Each row represents a gene, and gene has 3 attributes: its id, its length,
#'     and the positions of all SNPs observed on it in the population.
#'
#' @return An S3 object of class "Gene" that summarizes a gene's degree of variation within
#'     the population. It contains the following fields:
#' \itemize{
#'     \item id - The name of the gene (unchanged from input)
#'     \item length - The length of the gene
#'     \item posTable - A data frame that contains a list of counts for each SNP position
#'     \item meanSpacing - The average number of bases between adjacent SNPs on this gene
#' }
#'
#' @examples
#' example <- "Potri.001G000800.1.v3.0"
#' initializeGene(example, snpPositions)
#'
#' @export
initializeGene <- function(id, posData) {

    # Check if id is in posData
    if (id %in% posData$transcript_id == FALSE) {
        stop('Given id not found in dataset')
    }

    # Build Gene object attributes

    geneInfo <- posData[posData$transcript_id == id, , ]

    positions <- as.integer(unlist(strsplit(geneInfo$snp_position_list, "\\|")))

    posTable <- as.data.frame(table(positions),stringsAsFactors=FALSE)

    meanSpacing <- calculateMeanSpacing(geneInfo)$meanSpacing

    gene <- list(id=id, length=geneInfo$gene_length, posTable=posTable, meanSpacing=meanSpacing)

    class(gene) <- "Gene"

    return(gene)
}
