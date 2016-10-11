{application, rabbitmq_trust_store, [
  {description, "Client certificate trust store. Provides a way to whitelist client x509 certificates."},
  {vsn, "3.6.5"},
  {modules, ['rabbit_trust_store','rabbit_trust_store_app','rabbit_trust_store_sup']},
  {registered, []},
  {mod, {rabbit_trust_store_app, []}},
  {env, [
         {default_refresh_interval, 30}
        ]},
  {applications, [
    kernel,
    stdlib,
    rabbit
  ]}
]}.
