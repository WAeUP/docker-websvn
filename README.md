# docker-websvn
Lightweight docker image providing websvn and basic access to subversion (svn) repositories.

This container additionally provides WSGI functionality to serve trac sites.

### Caveats

#### trac-related

- syslog not enabled: trac logging requires other log targets The backing
  alpine provides no syslog which trac can handle. If you set `log_type`
  `syslog` in trac.ini, trac-admin will quit with some 'file-not-found'
  message.  Use `none` or `file` instead.
