#' Non-synonymous coding region SNP Position Data from Next Generation Sequencing
#'
#' Genetic variation data obtained by parsing genomic data (initially stored in Variant Call Format) from
#'     RNA-Seq experiments on Poplar individuals.
#'
#' @source Provart Lab, Department of Cells and Systems Biology, University of Toronto.
#'
#' @format A matrix with columns:
#' \describe{
#'  \item{transcript_id}{The name of the gene/transcript}
#'  \item{gene_length}{The length of the gene cDNA, in bases}
#'  \item{snp_position_list}{The positions of all SNPs found on this gene
#'  across the population, separated by bars '|'. They are sorted in increasing
#'  order, and repeated indices represent the same SNP position being observed in
#'  more than one individual/genotype.}
#' }
#' @examples
#' \dontrun{snpPositions}
#'
'snpPositions'
