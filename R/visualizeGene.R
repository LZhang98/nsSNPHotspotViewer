#' Provide a graphical visualization of a given gene and its degree of variation.
#'
#' Draws a gray rectangle on an R plot environment to represent the full length of the gene.
#' x-axis labels are the position numbers of the gene's cDNA. On top of the rectangle,
#' vertical coloured line segments represent positions on which SNPs are found -- the degree of
#' redness is a heatmap colour mapping that depicts its relative frequency.
#'
#' @param gene An S3 object of class Gene. The gene to be visualized. See \code{?initializeGene} for
#'     information on this class' attributes.
#'
#' @return Produces an R graphic visualization of the given gene.
#'
#' @examples
#' gene <- initializeGene("Potri.001G345300.1.v3.0", snpPositions)
#' visualizeGene(gene)
#'
#' @importFrom grDevices heat.colors
#' @importFrom graphics lines rect text
#' @export
visualizeGene <- function(gene) {

    # Retrieve Gene attributes
    id <- gene$id
    posTable <- gene$posTable
    length <- gene$length
    spacing <- toString(gene$meanSpacing)

    # Plot configurations were obtained from a StackOverflow response:
    # https://stackoverflow.com/questions/1154242/remove-plot-axis-values
    plot(c(0,length), c(0, 30),
         type="n",
         xlab="Position", ylab="",
         main=id,
         yaxt="n",
         frame.plot=FALSE)

    # Draw rectangle: the gene.
    rect(xleft=0,xright=length,ybottom=10,ytop=20,col="gray")

    # Draw lines: the SNPs
    numLines <- nrow(posTable)
    sortedPosTable <- posTable[order(posTable$Freq, decreasing=TRUE), ]
    palette <- heat.colors(numLines)
    for (i in 1:numLines) {
        position <- sortedPosTable$positions[i]
        lines(x=c(position, position),y=c(10,20),col=palette[i])
    }

    # Annotate the graphic with a simple statistic
    annotation <- paste("Average spacing between nsSNPs on this gene = ",spacing, sep="")
    text(x=0, y=5, adj=0, labels=annotation)
}
