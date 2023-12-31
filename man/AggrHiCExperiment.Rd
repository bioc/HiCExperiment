% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/AggrHiCExperiment-class.R,
%   R/AggrHiCExperiment-methods.R
\docType{class}
\name{AggrHiCExperiment}
\alias{AggrHiCExperiment}
\alias{AggrHiCExperiment-class}
\alias{slices,AggrHiCExperiment,missing-method}
\alias{slices,AggrHiCExperiment,character-method}
\alias{slices,AggrHiCExperiment,numeric-method}
\alias{show,AggrHiCExperiment-method}
\title{\code{AggrHiCExperiment} S4 class}
\usage{
AggrHiCExperiment(
  file,
  resolution = NULL,
  targets,
  flankingBins = 50,
  metadata = list(),
  topologicalFeatures = S4Vectors::SimpleList(),
  pairsFile = NULL,
  bed = NULL,
  maxDistance = NULL,
  BPPARAM = BiocParallel::bpparam()
)

\S4method{slices}{AggrHiCExperiment,missing}(x)

\S4method{slices}{AggrHiCExperiment,character}(x, name)

\S4method{slices}{AggrHiCExperiment,numeric}(x, name)

\S4method{show}{AggrHiCExperiment}(object)
}
\arguments{
\item{file}{CoolFile or plain path to a Hi-C contact file}

\item{resolution}{Resolution to use with the Hi-C contact file}

\item{targets}{Set of chromosome coordinates for which
interaction counts are extracted from the Hi-C contact file, provided
as a GRanges object (for diagnoal-centered loci) or as a GInteractions
object (for off-diagonal coordinates).}

\item{flankingBins}{Number of bins on each flank of the bins containing
input targets.}

\item{metadata}{list of metadata}

\item{topologicalFeatures}{topologicalFeatures provided as a named SimpleList}

\item{pairsFile}{Path to an associated .pairs file}

\item{bed}{Path to regions file generated by HiC-Pro}

\item{maxDistance}{Maximum distance to use when compiling distance decay}

\item{BPPARAM}{BiocParallel parameters}

\item{x, object}{A \code{AggrHiCExperiment} object.}

\item{name}{The name/index of slices to extract.}
}
\value{
An \code{AggrHiCExperiment} object.
}
\description{
The \code{AggrHiCExperiment} extends \code{HiCExperiment} class.
}
\section{Slots}{

\describe{
\item{\code{fileName}}{Path of Hi-C contact file}

\item{\code{resolutions}}{Resolutions available in the Hi-C contact file.}

\item{\code{resolution}}{Current resolution}

\item{\code{interactions}}{Genomic Interactions extracted from the Hi-C contact file}

\item{\code{scores}}{Available interaction scores.}

\item{\code{slices}}{Available interaction slices.}

\item{\code{topologicalFeatures}}{Topological features associated with the dataset
(e.g. loops (\<Pairs\>), borders (\<GRanges\>),
viewpoints (\<GRanges\>), etc...)}

\item{\code{pairsFile}}{Path to the .pairs file associated with the Hi-C contact file}

\item{\code{metadata}}{metadata associated with the Hi-C contact file.}
}}

\examples{
fpath <- HiContactsData::HiContactsData('yeast_wt', 'mcool')
data(centros_yeast)
x <- AggrHiCExperiment(
  file = fpath, 
  resolution = 8000,
  targets = centros_yeast[c(4, 7)]
)
x
slices(x, 'count')[1:10, 1:10, 1]
}
\seealso{
\code{\link[=HiCExperiment]{HiCExperiment()}}
}
