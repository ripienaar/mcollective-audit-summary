metadata    :name        => "audit_summary",
            :description => "Summarize logfile Audit logs",
            :author      => "R.I.Pienaar <rip@devco.net>",
            :license     => "ASL 2.0",
            :version     => "0.1",
            :url         => "http://www.devco.net/",
            :timeout     => 20

action "summarize", :description => "Summary of audit log entries" do
    display :always

    output :audit_summary,
           :description => "Summary of audit lines",
           :display_as => "Audit Summary"
end

