
"
vol_qry <- function(id, from, to){
  query <- 
    '
    {
    trafficData(trafficRegistrationPointId: id ) {
      volume {
        byHour(from: from, to: to) {
          edges {
            node {
              from
              to
              total {
                volumeNumbers {
                  volume
                }
              }
            }
          }
        }
      }
    }
  }
  '
}
"

vol_qry <- function(id, from, to) {
  query <- glue(
    '{{
      trafficData(trafficRegistrationPointId: "{id}") {{
        volume {{
          byHour(from: "{from}", to: "{to}") {{
            edges {{
              node {{
                from
                to
                total {{
                  volumeNumbers {{
                    volume
                  }}
                }}
              }}
            }}
          }}
        }}
      }}trafficRegistrationPoints(trafficRegistrationPointIds:"{id}"){{name}}
    }}',
    id = id,
    from = from,
    to = to
  )
  return(query)
}