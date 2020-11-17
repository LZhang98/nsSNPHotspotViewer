visualizeGene <- function(gene) {

    id <- gene$id
    posTable <- gene$posTable
    length <- gene$length

    # Plot configurations were obtained from a StackOverflow response:
    # https://stackoverflow.com/questions/1154242/remove-plot-axis-values
    plot(c(0,length), c(0, 30),
         type="n",
         xlab="Position", ylab="",
         main=id,
         yaxt="n",
         frame.plot=FALSE)



}

if (FALSE) {
    gene <- initializeGene("Potri.001G345300.1.v3.0", snpPositions)

    visualizeGene(gene)
}
