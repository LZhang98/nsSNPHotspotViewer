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

    rect(xleft=0,xright=length,ybottom=10,ytop=20,col="gray")

    numLines <- nrow(posTable)
    sortedPosTable <- posTable[order(posTable$Freq, decreasing=TRUE), ]
    print(sortedPosTable)
    palette <- heat.colors(numLines)

    for (i in 1:numLines) {
        position <- sortedPosTable$positions[i]
        lines(x=c(position, position),y=c(10,20),col=palette[i])
    }
}

if (FALSE) {
    gene <- initializeGene("Potri.001G345300.1.v3.0", snpPositions)

    visualizeGene(gene)
}
