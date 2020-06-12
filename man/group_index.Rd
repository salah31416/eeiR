% 
\name{group_index}
\alias{group_index}
\title{Group ESG and Index}
\usage{
group_index(data, id_names = c("Taxa"), col_data = "Taxa", by = NULL, ref = NULL, add = NULL, k = NULL, na.rm = FALSE)
}
\arguments{
	\item{data}{data.table or data.frame}
	\item{id_names}{vector of id variables. Can be integer (corresponding id column numbers) or character (id column names).}
	\item{col_data}{name of the column containing the names of the taxa}
	\item{by}{group by}
	\item{ref}{data.tabel or data.frame with reference data for esg}
	\item{add}{append functional group default}
	\item{k}{append functional group default}
	\item{na.rm}{remove NA}
}
\description{
Using morphological (external morphology, internal anatomy and texture), physiological (surface area/volume ratio, photosynthetic/non-photosynthetic ratio, photosynthetic performance, growth and light adaptation) and life history (longevity and succession) traits along with distributional data across eutrophication gradients, different benthic macrophyte ESG's relevant to nutrient and light responses in transitional waters were determined (Orfanidis et al., 2014)

ESG I (slow-growing, late-successional species) and ESG II (fast-growing, opportunistic species) are both divided hierarchically into three sub-groups, as follows: ESG IA, ESG IB, ESG IC, ESG IIA, ESG IIB and ESG IIC.
}
