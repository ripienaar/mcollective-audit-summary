#!/usr/bin/ruby

require 'mcollective'

include MCollective::RPC

summary = {}

mc = rpcclient("audit_summary")
mc.progress = false

mc.summarize do |r, s|
    node_summary = s[:data][:audit_summary]

    node_summary.keys.each do |agent|
        unless summary[agent]
            summary[agent] = node_summary[agent]
        else
            node_summary[agent][:actions].keys.each do |action|
                summary[agent][:actions][action][:callers] << node_summary[agent][:actions][action][:callers]
            end
        end
    end
end

summary.keys.each do |agent|
    puts "#{agent}:"
    puts "=" * (agent.size + 1)
    puts

    callers = {}
    summary[agent][:actions].keys.each do |action|
        summary[agent][:actions][action][:callers].flatten.uniq.sort.each do |callerid|
            callers[callerid] ||= []
            callers[callerid] << action
        end

    end

    callers.keys.sort.each do |callerid|
        puts "\t%20s: %s" % [ callerid, callers[callerid].join(", ") ]
    end

    puts
end

