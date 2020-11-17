plotPopulation <- function(posData, removeRepeats=TRUE) {

    library(ggplot2)

    countsData <- getSNPCounts(posData, removeRepeats)

    asdf <- data.frame(posData$transcript_id, geneLength=posData$gene_length,counts=countsData$counts)

    ggplot(data=asdf) + geom_point(mapping = aes(x = geneLength, y = counts))
}

if (FALSE) {
    plotPopulation(snpPositions)
}
