

demo <- Hmisc::sasxport.get("/Users/francescamatano/Dropbox/CMU/courses/ta/_survey_pack_francesca/suRvey303/data-raw/DEMO_I.xpt")

bpx <- Hmisc::sasxport.get("/Users/francescamatano/Dropbox/CMU/courses/ta/_survey_pack_francesca/suRvey303/data-raw/BPX_I.xpt")

bmx <- Hmisc::sasxport.get("/Users/francescamatano/Dropbox/CMU/courses/ta/_survey_pack_francesca/suRvey303/data-raw/BMX_I.xpt")

whq <- Hmisc::sasxport.get("/Users/francescamatano/Dropbox/CMU/courses/ta/_survey_pack_francesca/suRvey303/data-raw/WHQ_I.xpt")

seq_selected <- whq$seqn
tmp <- Reduce( intersect,
               list(demo$seqn[demo$seqn %in% seq_selected],
                    bpx$seqn[bpx$seqn %in% seq_selected],
                    bmx$seqn[bmx$seqn %in% seq_selected],
                    whq$seqn[whq$seqn %in% seq_selected]))

demo_cols <- c("DMDBORN4", "RIDAGEYR", "RIAGENDR", "RIDRETH3") %>% sapply(tolower)
bpx_cols  <- c("BPXPLS", "BPXSY1", "BPXDI1") %>% sapply(tolower)
whq_cols  <- c("WHD010", "WHD020") %>% sapply(tolower)
bmx_cols <- c("BMXWT", "BMXHT") %>% sapply(tolower)
others   <- c("wtint2yr", "wtmec2yr", "sdmvpsu", "sdmvstra")
mydata <- cbind(demo[demo$seqn %in% tmp, c(demo_cols, others)],
              bpx[bpx$seqn %in% tmp, bpx_cols],
              bmx[bmx$seqn %in% tmp, bmx_cols],
              whq[whq$seqn %in% tmp, whq_cols])

devtools::use_data(mydata, overwrite = TRUE)


