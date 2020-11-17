initializeGene <- function(id, posData) {

    geneInfo <- posData[posData$transcript_id == id, , ]

    positions <- as.integer(unlist(strsplit(geneInfo$snp_position_list, "\\|")))

    posTable <- as.data.frame(table(positions),stringsAsFactors=FALSE)

    meanSpacing <- calculateMeanSpacing(geneInfo)$meanSpacing

    gene <- list(id=id, length=geneInfo$gene_length, posTable=posTable, meanSpacing=meanSpacing)

    class(gene) <- "Gene"

    return(gene)
}

if (FALSE) {
    example <- "Potri.001G000800.1.v3.0"

    test <- initializeGene(example, snpPositions)
    t <- test$posTable
    t$positions
}
