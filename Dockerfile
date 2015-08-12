FROM java:7


ENV CONSUMER_NAME='cloudwatch-logs-subscription-consumer-1.2.0'
COPY ${CONSUMER_NAME}-cfn.zip ${CONSUMER_NAME}.zip
RUN unzip ${CONSUMER_NAME}.zip

# YOUR CONSTANTS
ENV \
  KINESIS_STREAM='' \
  REGION='eu-west-1' \
  TABLE='' \
  ES_ENDPOINT='' \
  ES_NAME='elasticsearch' \
  AWS_ACCESS_KEY_ID='' \
  AWS_SECRET_ACCESS_KEY=''

CMD java \
  -DkinesisInputStream=${KINESIS_STREAM} \
  -DregionName=${REGION} \
  -DappName=${TABLE} \
  -Dlog4j.configuration=log4j.properties \
  -DelasticsearchClusterName=${ES_NAME} \
  -DelasticsearchEndpoint=${ES_ENDPOINT} \
  -cp ${CONSUMER_NAME}/${CONSUMER_NAME}.jar \
  com.amazonaws.services.logs.connectors.samples.elasticsearch.ElasticsearchConnector
