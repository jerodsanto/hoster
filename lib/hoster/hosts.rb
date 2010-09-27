class Hosts

  # disclaimer: I didn't test this because I didn't have windows around.
  if RUBY_PLATFORM =~ /mswin32/
    @@default_hosts_path = 'C:\WINDOWS\system32\drivers\etc\hosts'
  else
    @@default_hosts_path = '/etc/hosts'
  end

  attr_reader :entries

  def initialize(hosts_path = @@default_hosts_path)
    @hosts_path = hosts_path
    @entries    = extract_entries
  end

  def dump
    File.open(@hosts_path,"r") { |f| f.read }
  end

  def add(host, ip_address = "127.0.0.1")
    if @entries.has_key?(ip_address)
      @entries[ip_address] << host
    else
      @entries[ip_address] = [host]
    end
    write_changes!
  end

  def remove(host)
    @entries.each_pair { |key,value| value.delete_if { |v| v == host } }
    write_changes!
  end
  
  def modify(host, ip_address)
    host_exists = false
    @entries.each_value { |v| host_exists = true if v.include?(host) }
    if host_exists
      remove(host)
      add(host,ip_address)
    else
      raise "#{host} does not exist. Please use 'add' command instead."
    end
  end
  
  def display(ip_address="127.0.0.1")
    puts "  #{ip_address} = #{@entries.values_at(ip_address).join(' ')}\n"
  end

  private

  def extract_entries
    entries = Hash.new
    File.open(@hosts_path,"r").each do |line|
      if line =~ /^(\d+\.\d+\.\d+\.\d+)[ \t]+(.*)?[#\n]/
        ip_address = $1
        hosts_list = $2.split(' ')
        if entries.has_key?(ip_address)
          hosts_list.each do |host|
            entries[ip_address] << host
          end
        else
          entries[ip_address] = hosts_list
        end
      end
    end
    entries
  end
  
  def write_changes!
    @entries.each do |entry|
      append_this     = true
      entry_exists    = false

      begin
        File.open(@hosts_path,"r+") do |file|
          lines = file.readlines
          lines.each_with_index do |line,index|
            if line =~ /#{entry.first}/
              if entry_exists || entry.last.empty?
                lines.delete_at(index)
              else
                lines[index] = "#{entry.first} #{entry.last.join(' ')}\n"
                # update the state of this entry
                append_this  = false
                entry_exists = true
              end
            end
          end
          file.pos = 0
          file.print lines
          file.truncate(file.pos)
        end
        if append_this && !entry.last.empty?
          File.open(@hosts_path,"a") do |file|
            file.print "#{entry.first} #{entry.last.join(' ')}\n"
          end
        end
    rescue Errno::EACCES
      puts "You do not have permission to edit #{@hosts_path}. Run as root or use 'sudo'"
      exit 1
    end
    end
  end

end
