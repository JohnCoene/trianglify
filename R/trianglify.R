#' Trianglify
#'
#' Trianglify.
#'
#' @param width,height Widget dimensions.
#' @param elementId Widget id.
#' @param cell.size Specify the size of the mesh used to generate triangles.
#' Larger values will result in coarser patterns, smaller values will result
#' in finer patterns. Note that very small values may dramatically increase
#' the runtime of Trianglify.
#' @param variance Specify the amount of randomness used when generating triangles.
#' @param seed Seeds the random number generator to create repeatable patterns.
#' When set to null, the random number will be seeded with random values from the
#' environment. An example usage would be passing in blog post titles as the seed
#' to generate unique trianglify patterns for every post on a blog that won't change
#' when the page reloads.
#' @param x.colors,y.colors Vector of colors.
#' @param color.space Set the color space used for generating gradients.
#' Supported values are rgb, hsv, hsl, hsi, lab and hcl.
#' @param stroke.width Specify the width of the stroke on triangle shapes in the pattern.
#' The default value is the ideal value for eliminating antialiasing artifacts when
#' rendering patterns to a canvas.
#' @param points A data.frame of \code{x} and \code{y} points to triangulate.
#'
#' @import htmlwidgets
#'
#' @examples
#' trianglify()
#'
#' @export
trianglify <- function(width = "100%", height = NULL, elementId = NULL,
                       cell.size = NULL, variance = NULL, seed = NULL,
                       x.colors = NULL, y.colors = NULL, color.space = NULL,
                       stroke.width = NULL, points = NULL) {

  # forward options using x
  x = list(
    width = width,
    height = height,
    cell_size = cell.size,
    variance = variance,
    seed = seed,
    x_colors = x.colors,
    y_colors = y.colors,
    color_space = color.space,
    stroke_width = stroke.width
  )

  x <- x[lapply(x, length) > 0]

  if(!is.null(points))
    x$points <- apply(points, 1, as.list)

  # create widget
  htmlwidgets::createWidget(
    name = 'trianglify',
    x,
    width = width,
    height = height,
    package = 'trianglify',
    elementId = elementId,
    sizingPolicy = sizingPolicy(
      padding = 0,
      browser.fill = TRUE
    )
  )
}

#' Shiny bindings for trianglify
#'
#' Output and render functions for using trianglify within Shiny
#' applications and interactive Rmd documents.
#'
#' @param outputId output variable to read from
#' @param width,height Must be a valid CSS unit (like \code{'100\%'},
#'   \code{'400px'}, \code{'auto'}) or a number, which will be coerced to a
#'   string and have \code{'px'} appended.
#' @param expr An expression that generates a trianglify
#' @param env The environment in which to evaluate \code{expr}.
#' @param quoted Is \code{expr} a quoted expression (with \code{quote()})? This
#'   is useful if you want to save an expression in a variable.
#'
#' @name trianglify-shiny
#'
#' @export
trianglifyOutput <- function(outputId, width = '100%', height = '400px'){
  htmlwidgets::shinyWidgetOutput(outputId, 'trianglify', width, height, package = 'trianglify')
}

#' @rdname trianglify-shiny
#' @export
renderTrianglify <- function(expr, env = parent.frame(), quoted = FALSE) {
  if (!quoted) { expr <- substitute(expr) } # force quoted
  htmlwidgets::shinyRenderWidget(expr, trianglifyOutput, env, quoted = TRUE)
}
