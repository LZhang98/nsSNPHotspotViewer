test_that("strsplit works", {
    my_string <- "123|456|789"
    split <- unlist(strsplit(my_string, "\\|"))
    expect_equal(split, c("123","456","789"))
})

test_that("unique works", {
    my_set <- c(1,1,2,3,4,5)
    expect_equal(unique(my_set), c(1,2,3,4,5))
    expect_equal(length(my_set), 1 + length(unique(my_set)))
})

test_that("diff works", {
    my_set <- c(1, 4, 6, 9)
    expect_equal(diff(my_set), c(3,2,3))
})

test_that("padding works", {
    example <- "Potri.002G203800.1.v3.0"
    gene <- initializeGene(example, snpPositions)
    expect_equal(gene$meanSpacing, (gene$length + 1)/2)
})
