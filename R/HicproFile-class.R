#' @title `HicproFile` S4 class
#' 
#' @name HicproFile-class
#' @aliases HicproFile
#' 
#' @description
#' 
#' The `HicproFile` class describes a `BiocFile` object, pointing to the location 
#' of a HiC-Pro-generated matrix file and containing 4 additional slots:
#' 
#' 1. bed: path to the matching `.bed` file generated by HiC-Pro;
#' 2. resolution: at which resolution the associated mcool file should be parsed ;
#' 3. pairsFile: the path (in plain character) to an optional pairs file 
#'   (stored as a `PairsFile` object);
#' 4. metadata: a list metadata
#'
#' @slot bed Path to the matching `.bed` file generated by HiC-Pro
#' 
#' @param path String; path to the HiC-Pro output .matrix file (matrix file)
#' @param bed String; path to the HiC-Pro output .bed file (regions file)
#' @param pairsFile String; path to a pairs file
#' @param metadata list.
#' 
#' @importFrom S4Vectors metadata
#' @importFrom methods setClass
#' @importClassesFrom BiocIO BiocFile
#' @include HiCExperiment-class.R
#' @include PairsFile-class.R
#' @seealso [CoolFile()], [HicFile()]
#' 
#' @examples
#' hicproMatrixPath <- HiContactsData::HiContactsData('yeast_wt', 'hicpro_matrix')
#' hicproBedPath <- HiContactsData::HiContactsData('yeast_wt', 'hicpro_bed')
#' pairsPath <- HiContactsData::HiContactsData('yeast_wt', 'pairs.gz')
#' hicpro <- HicproFile(
#'   hicproMatrixPath, bed = hicproBedPath, pairs = pairsPath ,
#'   metadata = list(type = 'example')
#' )
#' hicpro
#' resolution(hicpro)
#' pairsFile(hicpro)
#' metadata(hicpro)
NULL

#' @export

setClass('HicproFile', contains = 'ContactsFile', slots = list(
    bed = 'characterOrNULL'
))

#' @export 

HicproFile <- function(path, bed = NULL, pairsFile = NULL, metadata = list()) {
    path <- gsub('~', Sys.getenv('HOME'), path)
    .check_hicpro_files(path, bed)
    if (!is.null(bed)) {
        bed1 <- vroom::vroom(
            file = bed, 
            col_names = FALSE, 
            n_max = 1, 
            show_col_types = FALSE, 
            progress = FALSE
        )
        resolution <- (bed1[,3] - bed1[,2])[[1]]
        new(
            'HicproFile', 
            resource = path, 
            bed = bed, 
            resolution = resolution,
            pairsFile = PairsFile(pairsFile),
            metadata = metadata
        )
    }
    else {
        new(
            'HicproFile', 
            resource = path, 
            bed = bed, 
            resolution = NULL,
            pairsFile = PairsFile(pairsFile),
            metadata = metadata
        )
    }
}
