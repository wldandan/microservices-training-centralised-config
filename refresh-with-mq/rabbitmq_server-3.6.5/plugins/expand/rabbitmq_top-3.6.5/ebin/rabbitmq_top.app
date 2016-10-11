{application, rabbitmq_top,
 [{description, "RabbitMQ Top"},
  {vsn, "3.6.5"},
  {modules, ['rabbit_top_app','rabbit_top_extension','rabbit_top_sup','rabbit_top_util','rabbit_top_wm_ets_tables','rabbit_top_wm_process','rabbit_top_wm_processes','rabbit_top_worker']},
  {registered, []},
  {mod, {rabbit_top_app, []}},
  {applications, [kernel, stdlib, rabbit, rabbitmq_management]}]}.
