module MCollective
    module Agent
        class Audit_summary<RPC::Agent
            metadata    :name        => "audit_summary",
                        :description => "Summarize logfile Audit logs",
                        :author      => "R.I.Pienaar <rip@devco.net>",
                        :license     => "ASL 2.0",
                        :version     => "0.1",
                        :url         => "http://www.devco.net/",
                        :timeout     => 20

            action "summarize" do
                stats = {}
                logfile = Config.instance.pluginconf["rpcaudit.logfile"] || "/var/log/mcollective-audit.log"

                File.read(logfile).each do |line|
                    # 2011-07-28T14:13:57.919752+0100: reqid=86396af9843b20464d549e9803975f1b: reqtime=1311858850 caller=cert=puppetcommander@monitor3.pinetecltd.net agent=puppetd action=status data={:process_results=>true}
                    if line =~ /reqid=(.+): reqtime=(.+) caller=(.+?)@(.+) agent=(.+) action=(.+) data=(.+)/
                        reqid = $1; reqtime = $2; callerid = $3; callerhost = $4; agent = $5; action = $6; data = $7

                        stats[agent] = {:actions => {}} unless stats.include?(agent)

                        if stats[agent][:actions].include?(action)
                            act = stats[agent][:actions][action]

                            act[:callers] << callerid unless act[:callers].include?(callerid)
                        else
                            stats[agent][:actions][action] = {:callers => [callerid]}
                        end
                    end
                end

                reply[:audit_summary] = stats
            end
        end
    end
end
