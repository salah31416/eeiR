% 
\name{esg}
\alias{esg}
\title{Ecological Status Group}
\usage{
esg(a = 0, b = 0, c = 0, type = c("esg1", "esg2"), k = NULL)
}
\arguments{
	\item{a}{coefficients of the ESG}
	\item{b}{coefficients of the ESG}
	\item{c}{coefficients of the ESG}
	\item{type}{predefined categories of ESG I and ESG II}
	\item{k}{constant of the ESG. For "esg1" k = c(1, 0.8, 1) 
		and "esg2" k = c(0.8, 1, 1)}
}
\description{
The late-successional group with low growth rates and long life histories (Ecological Status Group I, mostly K-selection) and the opportunistic group with high growth rates and short life histories (ESG II, mostly r-selection).
}
