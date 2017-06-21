library(plotrix)
Ymd.format<-"%Y/%m/%d"
gantt.info<-list(labels=
                   c("IRB Approval"  , "Data Collection"  ,"Interim Analysis", "Final Analysis",
                     "Thesis Submission"),
                 starts=
                   as.POSIXct(strptime(
                     c("2017/07/01","2017/09/01","2018/02/01","2018/09/01","2018/10/01"),
                     format=Ymd.format)),
                 ends=
                   as.POSIXct(strptime(
                     c("2017/07/30","2018/08/01","2018/02/28","2018/09/30","2018/10/30"),
                     format=Ymd.format)),
                 priorities=c(1,2,3,4,5))
vgridpos<-as.POSIXct(strptime(c("2017/06/01","2017/07/01","2017/08/01",
                                "2017/09/01","2017/10/01","2017/11/01","2017/12/01","2018/01/01","2018/02/01","2018/03/01",
                                "2018/04/01","2018/05/01","2018/06/01","2018/07/01","2018/08/01",
                                "2018/09/01","2018/10/01","2018/11/01"),format=Ymd.format))
vgridlab<-
  c("Jun","Jul","Aug","Sep","Oct","Nov","Dec","Jan","Feb","Mar","Apr","May","Jun","Jul","Aug","Sep","Oct","Nov")
gantt.chart(gantt.info,main=" ",
            priority.legend=FALSE,half.height=0.45,vgridpos=vgridpos,vgridlab=vgridlab,xlab="Months",hgrid=TRUE)
