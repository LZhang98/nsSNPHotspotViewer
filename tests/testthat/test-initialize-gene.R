test_that("gene intialization works", {
    example <- "Potri.001G000800.1.v3.0"
    gene <- initializeGene(example, snpPositions)

    expect_equal(class(gene), "Gene")
    expect_equal(gene$id, example)
    expect_equal(gene$length, 3415)
    expect_equal(dim(gene$posTable), c(5, 2))
})

test_that("missing data", {
    example <- "asdf"

    expect_error(initializeGene(example, snpPositions),
                 'Given id not found in dataset')
})
