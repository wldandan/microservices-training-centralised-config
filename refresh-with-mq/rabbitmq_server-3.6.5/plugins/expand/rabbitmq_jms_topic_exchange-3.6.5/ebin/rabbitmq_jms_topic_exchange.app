{ application, rabbitmq_jms_topic_exchange
, [ {description, "RabbitMQ JMS topic selector exchange plugin"}
  , {vsn, "3.6.5"}
  , {modules, ['rabbit_jms_topic_exchange','sjx_evaluator']}
  , {registered, []}
  , {applications, [kernel, stdlib, rabbit, mnesia]}
  ]
}.
