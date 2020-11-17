getSNPCounts <- function(posData, removeRepeats=TRUE) {

    n <- nrow(posData)

    counts <- vector(mode="integer",length=n)

    for (i in 1:n) {
        pos_list <- strsplit(posData$snp_position_list[i], '\\|')

        if (removeRepeats) {
            counts[i] <- length(unique(unlist(pos_list)))
        } else {
            counts[i] <- length(unlist(pos_list))
        }
    }

    result <- data.frame(transcriptID=posData$transcript_id, counts)

    return(result)
}

if (FALSE) {
    counts <- getSNPCounts(snpPositions)
    countsU <- getSNPCounts(snpPositions, removeRepeats=FALSE)
}
