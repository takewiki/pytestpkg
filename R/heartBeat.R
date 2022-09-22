#' 查询最大内码
#'
#' @return 返回值
#' @export
#'
#' @examples
#' max_age()
log_maxId <- function() {
  conn <- tsda::conn_rds('py_test')
  sql <- paste0("select isnull(max(FinterId),0)+1 as FinterId from t_rsync_log")
  data <-tsda::sql_select(conn,sql)
  res <- data$FinterId
  return(res)

}

#' 心跳测试
#'
#' @param msg 内容
#'
#' @return 返回值
#' @export
#'
#' @examples
#' log_heart()
log_heart <- function(msg='rsync is running!'){
  conn <- tsda::conn_rds('py_test')
  FinterId <- log_maxId()
  sql <- paste0(" insert into t_rsync_log values(",FinterId,",'",msg,"',GETDATE())")
  tsda::sql_update(conn,sql)
  res <- TRUE
  return(res)

}
