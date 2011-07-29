What?
=====

A agent for mcollective and a simple client script that summarize the
logs produced by the default logfile audit plugin.

Audit logs look like this:

<pre>
2011-07-29T12:44:17.938227+0100: reqid=31bcf7b1c01ed599854c062fb8492bd1: reqtime=1311939871 caller=cert=puppetcommander@monitor3.example.net agent=puppetd action=status data={:process_results=>true}
</pre>

This agent turn all entries in the log into a summary hash and return it.
The provided client summarize that for a whole network

If you are starting to write authorization rules for a network that is
already running mcollective you can enable auditing for a while then use
the gathered audit data to assist in knowing who use what so you can write
policy files.

Uage?
=====

<pre>
$ mc-audit-summarize.rb
iptables:
=========

                    cert=rip: block

nrpe:
=====

                 cert=nagios: runcommand
                    cert=rip: runcommand

audit_summary:
==============

                    cert=rip: summarize

puppetd:
========

        cert=puppetcommander: runonce, status
                    cert=rip: enable, status
</pre>

Contact?
========

R.I.Pienaar / rip@devco.net / http://devco.net / @ripienaar
