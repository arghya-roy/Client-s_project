function handler () {
    EVENT_DATA=$1
    DATA=`ls / && cp main.sh /tmp/ && ls /tmp/ && cd /tmp/ && pwd && chmod 777 main.sh && ./main.sh && ls /tmp ` # "ls" is in backticks
    RESPONSE="{\"statusCode\": 200, \"body\": \"$DATA\"}"
    echo $RESPONSE
}