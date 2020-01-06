% 
\name{index}
\alias{index}
\title{Indices EEIc - EQR - ESC}
\usage{
index(dta, group, ..., name.col1 = NULL, mean_by = NULL,
	 k = c(a = 0.503, b = 0.954, c = -0.204,
		   d = -0.998, e = 0.355, f = -0.109)
)}
\description{
calculates the EEIc, EQR and ESC indices.
}
\arguments{
	\item{dta}{data.table}
	\item{group}{name group ESG}
	\item{...}{insert colunm by function data.table}
	\item{name.col1}{name first colunm}
	\item{mean_by}{mean }
	\item{k}{constant for EEI}
}

