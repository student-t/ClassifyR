\name{KullbackLeiblerSelection}
\alias{KullbackLeiblerSelection}
\alias{KullbackLeiblerSelection,matrix-method}
\alias{KullbackLeiblerSelection,ExpressionSet-method}
\title{Selection of Differential Distributions with Kullback Leibler Distance}
\description{Ranks features by largest Kullback-Leibler distance and chooses
the features which have best resubstitution performance.
       }
\usage{
  \S4method{KullbackLeiblerSelection}{matrix}(expression, classes, ...)
  \S4method{KullbackLeiblerSelection}{ExpressionSet}(expression, datasetName,
                                      trainParams, predictParams, resubstituteParams, ...,
                                      selectionName, verbose = 3)
}
\arguments{
  \item{expression}{Either a \code{\link{matrix}} or \code{\link{ExpressionSet}} containing
                    the training data. For a matrix, the rows are features, and the columns
                    are samples.}
  \item{classes}{A vector of class labels.}                    
  \item{datasetName}{A name for the dataset used. Stored in the result.}
  \item{trainParams}{A container of class \code{\link{TrainParams}} describing the
                     classifier to use for training.}
  \item{predictParams}{A container of class \code{\link{PredictParams}} describing how
                       prediction is to be done.}
  \item{resubstituteParams}{An object of class \code{\link{ResubstituteParams}}
                            describing the performance measure to consider and the numbers of
                            top features to try for resubstitution classification.}                         
  \item{...}{Variables passed to \code{\link{getLocationsAndScales}}.}                       
  \item{selectionName}{A name to identify this selection method by. Stored in the result.}
  \item{verbose}{A number between 0 and 3 for the amount of progress messages to give.
                 This function only prints progress messages if the value is 3.}
}
\details{
  The distance is defined as \eqn{1/2 * (location_1 - location_2)^2}{0.5 * (location1 - location2)^2 / scale1^2 + (location1 - location2)^2 / scale2^2 + scale1^2 / scale2^2 + scale2^2 / scale1^2 }
  
  The subscripts denote the group which the parameter is calculated for.
}
\value{
  An object of class \code{\link{SelectResult}} or a list of such objects, if the classifier which was used
  for determining resubstitution error rate made a number of prediction varieties.
}
\author{Dario Strbenac}

\examples{
  if(require(sparsediscrim))
  {
    # First 20 features have bimodal distribution for Poor class. Other 80 features have normal distribution for
    # both classes.
    genesMatrix <- sapply(1:25, function(sample) c(rnorm(20, sample(c(8, 12), 20, replace = TRUE), 1), rnorm(80, 10, 1)))
    genesMatrix <- cbind(genesMatrix, sapply(1:25, function(sample) rnorm(100, 10, 1)))
    classes <- factor(rep(c("Poor", "Good"), each = 25))
    KullbackLeiblerSelection(genesMatrix, classes, "Example",
                             trainParams = TrainParams(naiveBayesKernel, FALSE, doesTests = TRUE),
                             predictParams = PredictParams(function(){}, FALSE, getClasses = function(result) result),
                             resubstituteParams = ResubstituteParams(nFeatures = seq(10, 100, 10), performanceType = "balanced", better = "lower")
                             )
  }
}
