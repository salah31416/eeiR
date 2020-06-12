% 
\name{index}
\alias{index}
\title{Indices EEIc - EQR - ESC}
\usage{
index(data, id_names = c("FG", "Taxa"), col_fg = "FG", by = NULL, k = NULL, na.rm = FALSE)
}
\arguments{
	\item{data}{data.table or data.frame.}
	\item{id_names}{vector of id variables. Can be integer (corresponding id column numbers) or character (id column names).}
	\item{col_fg}{name colunm of functional group.}
	\item{by}{vector group by}
	\item{k}{constant for EEI}
	\item{na.rm}{remove NA}
}
\description{
calculates the EEIc, EQR and ESC indices.
}
