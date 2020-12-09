countsData <- getSNPCounts(snpPositions)

test_that("example subset works", {


    subset <- queryCounts(countsData, 10000, 150)

    expect_equal(dim(subset), c(15, 3))

})

test_that("sorting works", {

    byCounts <- queryCounts(countsData, 10000, 150, "counts")
    expect_equal(all(diff(byCounts$counts) <= 0), TRUE)

    byLength <- queryCounts(countsData, 10000, 150, "length")
    expect_equal(all(diff(byLength$length) <= 0), TRUE)

    expect_warning(queryCounts(countsData, 10000, 150, "asdf"))
})
