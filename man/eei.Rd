% 
\name{eei}
\alias{eei}
\title{Ecological Evaluation Index}
\usage{
eei(x, y, type = c("eeic", "hyp", "esi"), 
	k = c(a = 0.503, b = 0.954, c = -0.204, d = -0.998, e = 0.355, f = -0.109))
}
\arguments{
	\item{x}{ESGI value }
	\item{y}{ESGII value}
	\item{type}{type of indice}
	\item{k}{vector with a,b,d,c,e and f coefficients}
}
\description{
	A biotic index implementation.	
}
