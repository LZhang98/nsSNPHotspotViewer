calculateMeanSpacing <- function(posData, removeRepeats=TRUE, removeZeroes=FALSE) {

    n <- nrow(posData)

    meanSpacing <- vector(mode="integer",length=n)

    for (i in 1:n) {

        pos_list <- strsplit(posData$snp_position_list[i], '\\|')
        if (removeRepeats) {
            positions <- unique(as.integer(unlist(pos_list)))
        } else {
            positions <- as.integer(unlist(pos_list))
        }
        if (length(positions) == 1) {
            meanSpacing[i] <- 0
        } else {
            meanSpacing[i] <- mean(diff(positions))
        }
    }

    result <- data.frame(transcriptID=posData$transcript_id, meanSpacing)

    if (removeZeroes) {
        return(result[result$meanSpacing != 0, ])
    } else {
        return(result)
    }
}

if (FALSE) {
    msZeroes <- calculateMeanSpacing(snpPositions, removeZeroes=FALSE)
    ms <- calculateMeanSpacing(snpPositions)
}
