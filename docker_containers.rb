#!/usr/bin/env ruby

docker_ps = `docker ps --no-trunc`.split("\n")[0..-1]

containers = {}
docker_ps.each do |container|
  id        = container.split(' ').first
  name      = container.split(' ').last.split(',').first
  mem_bytes = File.read(open("/sys/fs/cgroup/memory/docker/#{id}/memory.usage_in_bytes")).to_i

  containers[id] = {name: name, mem_bytes: mem_bytes}
end

case ARGV[0]
when 'config'
  puts ({
    'graph_title'            => 'Docker container memory usage',
    'graph_vlabel'           => 'bytes',
    'graph_category'         => 'docker_container',
  }).map{|k,v| [k,v].join(" ")}.join("\n")
  containers.each do |id, container|
    display_name = container[:name].gsub(/[^0-9a-z ]/i, '_')
    puts "#{display_name}.label #{container[:name]}"
  end
else
  containers.each do |id, container|
    display_name = container[:name].gsub(/[^0-9a-z ]/i, '_')
    puts "#{display_name}.value #{container[:mem_bytes]}"
  end
end
